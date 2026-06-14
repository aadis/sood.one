---
title: "Two Gaps: Could We Ever Tell Whether an AI Is Conscious?"
description: There are two very different reasons a mind can be hard to understand, and they get constantly confused. Pulling them apart — with help from a 2009 philosophy book and a 2025 interpretability paper — turns out to clarify what we could and couldn't ever know about a conscious machine.
date: 2026-06-14
tags:
  - consciousness
  - AI
  - philosophy
  - interpretability
  - ego-tunnel
publish: true
---

This one sits at the join between two things I've been reading: Thomas Metzinger's *The Ego Tunnel*, which I've been [working through chapter by chapter](/posts/ego-tunnel-2-other-minds), and a recent position paper out of DeepMind on how we might use large language models to interpret themselves. They turned out to be about the same problem from opposite ends, and the place they meet is a distinction I now think is worth more than almost anything else in either text. There are two completely different reasons a mind can be hard to understand, they get confused all the time, and once you separate them a lot of the noise around machine consciousness gets quieter.

> [!note]
> On how these get written: I read the source material and think it through, a good deal of it in a long back-and-forth with an LLM, and then I lean on the LLM as an editor to turn that thinking into something readable, because I've never written much and I haven't got the patience to grind my own sentences into shape. The ideas, the connections, and the judgments are mine, the wrong ones included. The prose has had help. I'd rather say that plainly than pretend otherwise.

## One reality, two ways of knowing

Start with a distinction philosophers make that sounds dry and isn't. There's a difference between something being irreducible *ontologically* and irreducible *epistemically*, and the whole argument hangs on not mixing them up.

Ontological irreducibility would mean consciousness is made of different stuff from matter — that mind and body are two kinds of thing, and no amount of physics will ever contain the mental, because it isn't physical to begin with. That's old-fashioned dualism, the soul in the machine, and I don't believe it, and neither does Metzinger. There's no extra substance, no woo. The brain is physical all the way down.

Epistemic irreducibility is a much narrower and more interesting claim. It says there's one reality, one kind of stuff, but two genuinely different *ways of knowing* it that can't be folded into each other even in principle. Knowing everything about a brain from the outside, in the third person, is one kind of knowledge. Knowing what an experience is like from the inside, in the first person, is another. The bet is that the second never reduces to the first — that you could have a complete third-person account and still be missing something real.

The standard illustration is Frank Jackson's: imagine a scientist who has lived her whole life in a black-and-white room and knows every physical fact there is to know about colour vision, every wavelength and every neuron. One day she walks outside and sees red for the first time. Does she learn something new? If your gut says yes, then there's first-person knowledge that complete third-person knowledge didn't include. Thomas Nagel made the same point with a bat: we could map echolocation down to the last detail and still not know what it is like to *be* the bat using it, not because the bat has a magic non-physical mind, but because that knowledge is only available from the inside of that particular system. You can have the whole map and still never have set foot in the territory.

You can hold all of this as a committed materialist. That's the part people miss. Saying first-person knowledge doesn't reduce to third-person knowledge is not saying there's a ghost. It's saying there are two instruments, and one of them can't read what the other one writes.

## The analogy that splits the problem in two

Here's the picture that made it concrete for me. Take a computer running a program — say something in Lisp. Put the chip under an electron microscope and you can see every voltage, every logic gate flipping. You'd have a complete physical description of the machine. And from that description alone you could not, just by looking, recover the program: the data structures, the functions, the thing the software is actually *doing*. The low-level account is total and the high-level understanding is still missing.

That feels like the consciousness problem, and it is, but the analogy is sharper than it first appears, because it actually contains two different gaps that usually get smeared together.

The first gap is one of levels. The voltages are at the bottom; the program lives several storeys up, in a vocabulary of loops and variables that the raw electrical story doesn't hand you. This is a real and famous difficulty — the neuroscientists Eric Jonas and Konrad Kording once ran standard brain-science methods on a classic video-game chip running *Donkey Kong* and found the methods couldn't recover how it worked. But notice the crucial feature of this gap: it's bridgeable, at least in principle. It's third-person all the way through. With enough effort you could decompile the chip and reconstruct the program. Hard, maybe brutally hard, but not impossible, because nothing in it requires being on the inside. Call this Gap 1.

The second gap only shows up once you imagine the first one closed. Suppose you've finished the decompile. You now have the complete functional story of the system, every level mapped. Is anything still missing? For the Lisp machine, the honest answer is no — there's nothing it's like to be that program; once you've described what it does at every level, you've described all of it. For a brain, the claim at the heart of the hard problem is that something *is* still missing even then: the first-person fact, the what-it's-like, the bit that doesn't appear anywhere in a third-person account no matter how complete. Call this Gap 2.

The two gaps behave completely differently, and that's the whole point. Gap 1 closes with more third-person work. Gap 2, if it's real, never closes at all, because it isn't a gap in our description, it's a gap between description and experience.

So the sharp question, the one that actually separates people, is this: after the complete decompile of a brain, is there a residue or not? If you think no — that the sense of mystery is just Gap 1 not yet finished — you're roughly with Daniel Dennett, and consciousness is a hard engineering problem and nothing more. If you think yes — that a first-person remainder survives the finished decompile — you're with Nagel and Chalmers. And, again, you can sit in either camp as a strict materialist. Metzinger himself lands mostly on the Gap-1 side, betting that his self-model machinery is exactly the high-level structure we've been missing, while treating the thin Gap-2 residue as a fact about knowing rather than a fact about being.

## Why LLMs change the question

For most of history this was a debate you couldn't do anything with, because we could never finish the decompile of a brain. The two gaps stayed tangled together forever, and everyone argued from intuition.

Large language models change that, and this is the part I find genuinely new. We have the weights. We can run interventions, trace circuits, watch the thing compute. There's now an entire research field — mechanistic interpretability — whose job is, in effect, to do the decompile, and it's making real progress. For the first time we have a complex, language-using system where the complete third-person account isn't a fantasy but an active program of work. Which means the question "after the full decompile, is there a residue?" stops being purely philosophical and edges toward something you could actually confront.

This is also where Metzinger's framework earns its keep, because it tells you not to be fooled by the obvious thing. An LLM will produce the *content* of selfhood all day — "I think," "I feel," "I'm not sure" — fluently and convincingly. But Metzinger's criterion for a genuine self isn't fluency, and it isn't even self-representation. It's a *transparent self-model*: a system that models itself and cannot see that model as a model, so that the self is lived rather than merely depicted. By that test, an LLM saying "I" is almost certainly producing text shaped like selfhood, the way it produces text shaped like the French Revolution, rather than living inside a self. The "I" is a token, not a tunnel.

And here the AI question loops straight back to something from the previous essay. When an LLM says "I," the most important effect isn't in the model, it's in *you*. It installs a belief that someone is home, by exploiting the machinery you evolved for reading other minds. We're built to take fluent first-person talk as evidence of a first person, and we can't easily switch that off. So the real near-term risk isn't that we'll accidentally build a suffering machine. It's that we'll be unable to tell whether we have, in either direction, because the cue we instinctively trust — it talks like there's someone there — is exactly the cue a Gap-1 system can produce with nobody there at all.

## A 2009 book predicting a 2025 paper

The DeepMind paper I mentioned argues, roughly, that since LLMs can hold a conversation, we should let them help interpret themselves — explain their own reasoning, teach us their internal concepts, even coin new words for ideas they have that we lack. It's a genuinely interesting proposal, and I've written about it [on its own terms](/posts/agentic-interpretability) too. But read through the two-gap lens, the entire enterprise lives in Gap 1. Its optimism — that a model can teach us its alien concepts until what looked opaque becomes clear — is a bet that the decompile can be completed cooperatively. Its pessimism — the appeals to computational limits and undecidability — is a bet that the decompile has a ceiling. Both are claims about third-person understanding. Neither touches Gap 2, and they can't, because interpretability is a third-person method by definition. You can teach someone a concept by examples; you cannot teach them what red is like by examples, and no amount of conversation crosses that line.

The thing that genuinely startled me is in the paper's fine print. It concedes, as a limitation, that "models do not know why they behave as they do" — they follow their own rules the way a fluent speaker follows grammar they could never state. The paper presents this as an awkward fact about current LLMs. But Metzinger, sixteen years earlier, explains exactly why it has to be true of *any* system like this. His whole account of self-models is that they're transparent: introspection reaches the model, never the machinery that builds it. A system that models itself is therefore structurally unable to report its own real causes; it will confabulate fluent, sincere, wrong explanations, because the only instrument it has for looking inward can't see the process doing the looking. That's not a quirk of GPT-style models. It's a prediction a philosophy book made about minds in general, and the interpretability researchers walked straight into it from the engineering side without naming it.

## What the distinction buys you

The reason I think the two-gap split is worth holding onto is that almost every confused conversation about machine consciousness is really a Gap 1 / Gap 2 confusion. "We'll understand AI once interpretability matures" is a Gap 1 claim, and it's probably right. "Therefore we'll know whether it's conscious" smuggles in Gap 2, and doesn't follow at all, because finishing the decompile tells you everything about what the system does and nothing, on its own, about whether there's anything it's like to be it. Conversely, "it talks like it's conscious, so maybe it is" mistakes Gap-1 fluency for Gap-2 presence, which is exactly the mistake our mind-reading instincts are built to make.

I don't have the answer to whether there's a residue, for brains or for models. Nobody does. But I'm now fairly sure that the honest position is to keep the two questions apart: how a mind works, which is hard and tractable, and whether it's like anything to *be* that mind, which may be hard and permanently out of reach of the only tools we have. The danger isn't that we'll fail to answer the second question. It's that we'll mistake an answer to the first for an answer to the second, and build, regulate, or dismiss conscious machines on the strength of that confusion.

## References

- **Metzinger (2009)**, *The Ego Tunnel: The Science of the Mind and the Myth of the Self* — the self-model and transparency framework this leans on.
- **Kim et al. (2025)**, *Because We Have LLMs, We Can and Should Pursue Agentic Interpretability* — [arXiv 2506.12152](https://arxiv.org/abs/2506.12152).
- **Jonas & Kording (2017)**, *Could a Neuroscientist Understand a Microprocessor?* — [PLOS Computational Biology](https://doi.org/10.1371/journal.pcbi.1005268).
- **Jackson (1982)**, *Epiphenomenal Qualia* — the black-and-white-room argument ("Mary's Room").
- **Nagel (1974)**, *What Is It Like to Be a Bat?* — the canonical statement of the first-person/third-person gap.
- **Marr (1982)**, *Vision* — the three levels of analysis (computational, algorithmic, implementational) behind the "levels" framing of Gap 1.
