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

I've been reading the foundational LLM-reasoning papers in order, and the first one — Wei et al.'s *Chain-of-Thought Prompting* (2022) — turned out to be a good excuse to finally understand why it works at the level of the attention mechanism, not just the prompting trick. This post is the result.

> [!note] On how this was written
> This is a mix of my own thinking and a long back-and-forth with Claude. I read the paper, then worked through the mechanics in conversation with an LLM until the explanations clicked. What follows is the synthesis — my current understanding, written in my voice, but shaped by that dialogue. Treat it as one reader's mental model, not authoritative ground truth.

---

## The core insight

Showing a model a few examples of *reasoning chains* — not just question → answer pairs, but the worked steps in between — dramatically improves its performance on complex reasoning: arithmetic, commonsense, symbolic tasks. The model learns to generate intermediate steps before committing to an answer.

The headline result is genuinely surprising. A simple prompting change, no fine-tuning, produces striking gains. On GSM8K math word problems, a 540B model given 8 chain-of-thought examples beat a fine-tuned GPT-3 that had a dedicated verifier. You change what's in the prompt, and reasoning ability appears.

---

## Why it works — the mechanics

A transformer generates one token at a time. When it generates token N, it has full attention over *every* prior token — both the prompt and every token it has already produced. This is direct access through attention, not a sequential hidden state being passed along. Token N can attend to token 1 with the same fidelity as it attends to token N−1.

So when the model has generated an intermediate step — "he has 3 left" — that step becomes a *real input* conditioning everything that follows. It isn't a side effect of the computation; it's part of the context now. **The reasoning chain works because generated tokens become real inputs.**

Two mechanisms build on this:

1. **Retrieval cue.** The model has seen enormous amounts of step-by-step reasoning in training — textbooks, proofs, worked examples. Chain-of-thought examples (or just "Let's think step by step") activate that statistical neighborhood. There's no mode switch happening internally. It predicts tokens that *resemble* reasoning because it's been anchored into the part of its distribution where reasoning-shaped text lives.

2. **Probability-space navigation.** Training data has a strong statistical pattern: correct conclusions tend to follow correct intermediate steps. By generating those intermediate tokens *before* the answer, the model steers itself toward a region of probability space where correct answers cluster. Each step shifts the distribution for what comes next — away from "plausible-but-wrong shortcut" territory and toward "correct continuation" territory.

In one sentence: the reasoning chain works not because tokens "think," but because each intermediate step constrains the probability distribution for what follows, navigating toward the regions where correct answers live.

---

## The scale catch

Chain-of-thought only works above roughly 100B parameters. Below that threshold it actively *hurts* — smaller models produce fluent-sounding but incorrect reasoning chains, and those wrong steps then anchor a wrong answer.

This makes sense mechanically. A smaller model doesn't have a rich enough statistical map of "correct reasoning step → correct next step." It generates steps that *look* like reasoning but are closer to random walks through that space, and those wrong intermediate tokens condition an equally wrong conclusion.

The implication is worth sitting with: chain-of-thought is not a generalizable prompting trick you can sprinkle on any model. It's an emergent capability that unlocks at scale. That's also why it matters for agents — as models get pushed smaller for edge deployment or cost, this reasoning scaffold degrades. It's a real constraint on where agentic behavior stays reliable.

---

## Few-shot vs zero-shot

- **Few-shot (this paper):** provide ~8 examples of (question + reasoning chain + answer). Most effective.
- **Zero-shot (Kojima et al., a separate paper):** just append "Let's think step by step," no examples. Also works — same retrieval-cue mechanism, slightly weaker, but requires no hand-crafted examples.

---

## Attention mechanics — the deep dive

Understanding *why* generated tokens become real inputs means understanding how attention actually works. This is the part I most wanted to nail down.

### The setup: Q, K, V

Each token embedding gets projected into three vectors via learned weight matrices:

- **Query (Q):** what this token is looking for
- **Key (K):** what this token advertises about itself
- **Value (V):** what this token passes forward if it gets attended to

```
Q = embedding · W_Q
K = embedding · W_K
V = embedding · W_V

attention output = softmax(Q · Kᵀ / √d_k) · V
```

The output for each token is a weighted blend of all the value vectors, where the weights come from query–key similarity scores. Every token simultaneously "looks at" every other token in the context.

During generation, **causal masking** zeros out all forward-looking attention — token N can only attend to tokens 1 through N. This is precisely how the reasoning chain feeds into the answer: the answer token's query attends over the full preceding context, including every intermediate step the model just generated.

### How W_Q, W_K, W_V get learned

They start random and are shaped by backpropagation. The signal: if attending to "5" and "2" while generating "3" (in "had 5, gave away 2, so has 3") produces a correct prediction, the gradient reinforces the W_Q / W_K values that produced that dot product. Over billions of examples the matrices learn which relationships matter for next-token prediction — no explicit supervision, entirely emergent.

Probing studies find distinct patterns in what different attention heads end up tracking: some follow syntactic dependencies (subject → verb), some track coreference ("it" → its referent), some track positional patterns. None of this was designed in.

W_V has a different character from W_Q and W_K. Q and K handle *routing* — who attends to whom. V handles *content* — what actually gets passed forward. W_V learns to produce representations that blend usefully, so the weighted sum of value vectors contains what downstream layers need.

### Why the dot product is the right similarity measure

The dot product of vectors A and B equals `|A| |B| cos(θ)` — high when both vectors are large *and* point in similar directions. In the learned space, direction encodes relationship: the Q and K vectors for tokens that should attend to each other end up pointing similarly through training.

The alternatives are worse. L2 distance loses discriminative power in high dimensions (the curse of dimensionality — all distances converge toward each other). Cosine similarity normalizes out magnitude, throwing away signal. The dot product is also just *fast*: it reduces to matrix multiplication, which GPU hardware is massively optimized for.

The `√d_k` scaling matters too. In high dimensions, random dot products have variance equal to the dimension size, which pushes softmax into near-one-hot saturation — where gradients vanish and learning stalls. Dividing by `√d_k` keeps the variance at 1 regardless of dimension.

### Multi-head attention

Instead of one set of Q/K/V matrices, H heads run in parallel with independent weights. Each head learns different relationship types at once. The outputs are concatenated and projected back to the model dimension. That's why each token's output reflects multiple kinds of relationship to all the other tokens simultaneously.

### Positional encoding — the set-operation problem

Attention is permutation-invariant. Without explicit position information, "John bit the dog" and "the dog bit John" are indistinguishable to it. Three main approaches solve this:

**Sinusoidal** (original Transformer, Vaswani et al. 2017): add a fixed position vector to each token embedding before the first layer, built from sinusoids at different frequencies — low frequency for coarse position, high for fine-grained. Each position gets a unique signature, and position `p+k` can be written as a linear function of position `p`, so the model can learn to compute relative distance.

**RoPE — Rotary Position Embeddings** (Su et al. 2021, used in LLaMA / Mistral / most current models): instead of adding to embeddings, *rotate* the Q and K vectors based on their position before the dot product. The rotation is structured so the dot product between position `m`'s query and position `n`'s key automatically encodes the *relative distance (m−n)*, not absolute positions. Better than absolute encoding because relative position ("5 tokens ago") is usually what matters, and it extrapolates to longer sequences more gracefully.

**ALiBi — Attention with Linear Biases** (Press et al. 2022): subtract a linear penalty from attention scores proportional to distance. The default prior is "further apart = less attention," which the model can override with learned weights. Simpler than RoPE, with similar extrapolation benefits.

### How it all composes

When the model generates a reasoning-chain token, it has:

- position-aware token representations (via the encoding scheme),
- learned Q/K routing that weights the relevant prior tokens highly,
- learned V content that blends into something useful for downstream layers,
- all of this across H heads simultaneously, in every layer.

The answer token is generated from a context that is, at once, syntactically structured, semantically weighted, and position-aware — a far richer input than any fixed hidden state could ever represent. That's the real reason the chain of thought works: the steps don't just sit there as text, they reshape the input that produces the answer.

---

## Where this leads

The same conditioning-scaffold idea shows up everywhere downstream:

- **ReAct** extends chain-of-thought directly — the reasoning chain stays the same mechanic, but instead of staying internal it *interleaves with actions* (querying an API, reading a result). Real-world observations get appended to the context, and the model reasons over them. Same token-conditioning scaffold, much bigger surface area.
- **Tree of Thoughts** takes the conditioning insight and asks: what if, instead of one chain, you search a *tree* of possible reasoning paths and evaluate which branch to follow? The intermediate steps become nodes in a search tree.

Once you see reasoning as "generated tokens reshaping the input distribution," a lot of the agent literature stops looking like a grab-bag of tricks and starts looking like variations on a single move.

---

## References

- **This paper:** Wei et al. (2022), *Chain-of-Thought Prompting Elicits Reasoning in Large Language Models* — [arXiv 2201.11903](https://arxiv.org/abs/2201.11903)
- **Zero-shot CoT:** Kojima et al. (2022), *Large Language Models are Zero-Shot Reasoners* — [arXiv 2205.11916](https://arxiv.org/abs/2205.11916)
- **Attention is All You Need:** Vaswani et al. (2017) — the original Transformer; introduces Q/K/V and sinusoidal positional encoding — [arXiv 1706.03762](https://arxiv.org/abs/1706.03762)
- **RoPE:** Su et al. (2021), *RoFormer: Enhanced Transformer with Rotary Position Embedding* — [arXiv 2104.09864](https://arxiv.org/abs/2104.09864)
- **ALiBi:** Press et al. (2022), *Train Short, Test Long: Attention with Linear Biases Enables Input Length Extrapolation* — [arXiv 2108.12409](https://arxiv.org/abs/2108.12409)
- **Attention-head probing:** Clark et al. (2019), *What Does BERT Look At? An Analysis of BERT's Attention* — [arXiv 1906.04341](https://arxiv.org/abs/1906.04341)
