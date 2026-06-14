---
title: "Chain-of-Thought Prompting, and How Attention Actually Makes It Work"
description: Why showing a model its own reasoning steps improves its answers — and the attention mechanics underneath that make generated tokens behave like real inputs.
date: 2026-06-13
tags:
  - AI
  - LLM
  - reasoning
  - transformers
publish: true
---

I've been reading the foundational papers on LLM reasoning roughly in order, and the first of them, Wei et al.'s *Chain-of-Thought Prompting* (2022), turned out to be a good excuse to finally understand why the trick works at the level of the attention mechanism rather than just as a prompting recipe. This post is the result, and it spends most of its length on the mechanics underneath, because that's the part I most wanted to get straight in my own head.

> [!note]
> On how these get written: I read the source material and think it through, a good deal of it in a long back-and-forth with an LLM, and then I lean on the LLM as an editor to turn that thinking into something readable, because I've never written much and I haven't got the patience to grind my own sentences into shape. The ideas, the connections, and the judgments are mine, the wrong ones included. The prose has had help. I'd rather say that plainly than pretend otherwise.

## The core insight

The paper states its own finding plainly in the abstract:

> We explore how generating a chain of thought — a series of intermediate reasoning steps — significantly improves the ability of large language models to perform complex reasoning... such reasoning abilities emerge naturally in sufficiently large language models via a simple method called chain of thought prompting, where a few chain of thought demonstrations are provided as exemplars in prompting.

So if you show a model a few examples that include not just questions and answers but the *worked reasoning* in between, its performance on hard problems — arithmetic, commonsense, symbolic manipulation — improves sharply, because it learns to generate those intermediate steps itself before committing to an answer. The headline number is the kind of thing that should make you stop and look twice, and the authors don't undersell it:

> The empirical gains can be striking. For instance, prompting a 540B-parameter language model with just eight chain of thought exemplars achieves state of the art accuracy on the GSM8K benchmark of math word problems, surpassing even finetuned GPT-3 with a verifier.

You change what's in the prompt, add no new training, and reasoning ability appears that wasn't on display a moment before.

## Why it works

The mechanism becomes clear once you remember how a transformer actually generates text. It produces one token at a time, and when it generates token N it has full attention over every token that came before, both the original prompt and everything it has itself produced so far. This is direct access through attention rather than information being squeezed through a single hidden state and passed along, so token N can attend to token 1 with the same fidelity it brings to token N−1. The consequence is the whole trick: once the model has written out an intermediate step — "he has 3 left" — that step is now part of the context, a real input conditioning everything that follows, not a side effect that evaporates once it's been computed.

Two things build on that. The first is a retrieval cue. The model has seen an enormous amount of step-by-step reasoning in training — textbooks, proofs, worked solutions — and a few chain-of-thought examples, or even just the phrase "let's think step by step," anchor it into that part of its distribution, so it goes on predicting tokens that resemble reasoning because it's been steered into the neighbourhood where reasoning-shaped text lives. There's no internal mode switch; there's just a shift in where in probability space the model is operating. The second is navigation through that space. Training data carries a strong statistical regularity, which is that correct conclusions tend to follow correct intermediate steps, so by generating those steps first the model walks itself toward the region where correct answers cluster, each step reshaping the distribution for what comes next and nudging it away from the plausible-but-wrong shortcuts and toward the correct continuations. The reasoning chain works not because the tokens "think," but because each step it lays down constrains what can plausibly come after it.

## The scale catch

This only works above roughly a hundred billion parameters, and below that threshold it actively *hurts*. A smaller model, prompted to reason step by step, produces fluent-sounding chains that are wrong, and those wrong intermediate tokens then anchor an equally wrong answer, so you'd have been better off without them. That makes sense once you see the mechanism, because a smaller model doesn't carry a rich enough statistical map of "correct step → correct next step," and what looks like reasoning is closer to a random walk through that space, with each misstep conditioning the next. So chain-of-thought isn't a portable prompting trick you can sprinkle on anything; it's an emergent capability that only switches on at scale, which is also why it matters for agents — as models get pushed smaller for cost or for edge deployment, this reasoning scaffold is one of the first things to degrade, and that's a real constraint on where agentic behaviour stays reliable.

There's a zero-shot variant worth knowing, from a separate paper by Kojima et al., where you skip the worked examples entirely and just append "let's think step by step." It runs on the same retrieval-cue mechanism, comes out slightly weaker than the few-shot version, and costs you nothing to hand-craft, which is often the trade you want.

## Why a generated step counts as a real input

The one piece of mechanism worth holding onto is the reason a step the model writes is genuinely available to it later, and it comes down to how attention works at a conceptual level. When a transformer generates a token, that token can look back at every earlier token directly and weigh how much each one matters to what it's producing right now — it isn't reading a single compressed summary of the past, it's reading the past itself, with every word still individually in view. So when the model writes "he has 3 left" and then carries on, that line isn't a note it scribbled and discarded; it's sitting in plain sight, and the answer token, when it comes, reads it with full fidelity alongside everything else. That direct, everything-sees-everything access is the whole reason the chain feeds forward, and it's why the steps don't just sit there as text but actively reshape the input that produces the answer.

(The machinery underneath this — queries, keys, values, the attention formula, positional encodings — is genuinely interesting, and I went down that rabbit hole to satisfy myself, but it isn't load-bearing for the paper's point, so I'll leave it for a piece of its own rather than drag it through here.)

## Where this leads

Once you see reasoning as generated tokens reshaping the input distribution, a lot of the agent literature stops looking like a grab-bag of separate tricks and starts looking like variations on one move. ReAct extends chain-of-thought almost directly, keeping the same token-conditioning mechanic but letting the reasoning interleave with actions — querying an API, reading the result back — so that real-world observations get appended to the context and reasoned over, the same scaffold with a much larger surface area. Tree of Thoughts takes the same conditioning insight and asks what happens if, instead of following one chain, you search a tree of possible reasoning paths and evaluate which branch to keep, turning the intermediate steps into nodes in a search. The underlying idea, in each case, is the one this paper makes visible: a generated step is a real input, and shaping the steps is how you shape the answer.

## References

- **This paper:** Wei et al. (2022), *Chain-of-Thought Prompting Elicits Reasoning in Large Language Models* — [arXiv 2201.11903](https://arxiv.org/abs/2201.11903)
- **Zero-shot CoT:** Kojima et al. (2022), *Large Language Models are Zero-Shot Reasoners* — [arXiv 2205.11916](https://arxiv.org/abs/2205.11916)
- **Attention is All You Need:** Vaswani et al. (2017) — the original Transformer, for anyone who wants the mechanism underneath — [arXiv 1706.03762](https://arxiv.org/abs/1706.03762)
