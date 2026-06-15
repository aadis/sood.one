---
title: "Reading The Ego Tunnel, Part 3: How a Brain With No Center Binds the World Together"
description: There is no place in the brain where it all comes together — no screen, no viewer — and yet experience is seamlessly unified. The mechanism on offer is a rhythm, and once you read it as communications engineering it turns out to compute in the medium itself, with nobody there to read the code.
date: 2026-06-15
tags:
  - consciousness
  - neuroscience
  - philosophy
  - reading
  - ego-tunnel
publish: true
---

Chapter 2 of *The Ego Tunnel* closes not with an argument but with an interview — Metzinger in conversation with the neurophysiologist Wolf Singer — and it's the part of the book I've thought about most, partly because it's where the abstract problem of consciousness finally gets a concrete mechanism bolted under it, and partly because that mechanism, read with an engineer's eye, turns out to be doing something stranger and more beautiful than it first lets on. This is the third instalment on the chapter; the [first two](/posts/ego-tunnel-2-other-minds) were about what consciousness *is* and what it does between minds. This one is about how a brain with no boss manages to have a unified experience at all.

> [!note]
> On how these get written: I read the source material and think it through, a good deal of it in a long back-and-forth with an LLM, and then I lean on the LLM as an editor to turn that thinking into something readable, because I've never written much and I haven't got the patience to grind my own sentences into shape. The ideas, the connections, and the judgments are mine, the wrong ones included. The prose has had help. I'd rather say that plainly than pretend otherwise.

## The puzzle: unity with no place for it to happen

Start with the thing Singer puts first, because it's easy to nod past and it shouldn't be. The most reliable property of consciousness is that it's *unified* — at any instant everything you're experiencing hangs together as one coherent scene, even as the contents change from moment to moment. That sounds banal until you ask where the unifying happens, and the answer is nowhere:

> The binding problem results from two distinct features of the brain: First, the brain is a highly distributed system, in which a very large number of operations are carried out in parallel; second, it lacks a single convergence center, in which the results of these parallel computations could be evaluated in a coherent way.

No screen. No inner theater. No place it all arrives to be looked at by someone. The brain is millions of specialists working in parallel with no head office — and yet the output is a single seamless world, not a committee's worth of disconnected reports. That's genuinely strange, and most of our intuitions about the mind quietly smuggle in a viewer at the center to make it un-strange. Singer is refusing the viewer, which means the unity has to be *built* by some mechanism rather than *witnessed* by some homunculus.

## Why binding is a problem at all

Here's why it's hard, and it falls right out of the distributed architecture. Feature detectors are scattered and specialized: one population fires for "red," another for "vertical," another for "leftward motion." Now put two things in front of you at once — a red vertical bar drifting left, and a green horizontal bar drifting right. Every one of those feature detectors is now active simultaneously: red, green, vertical, horizontal, left, right. And from that bare list of what's firing, nothing tells you whether you're seeing a red-vertical-left thing and a green-horizontal-right thing, or a red-horizontal-right thing and a green-vertical-left thing. The features are all present; the *grouping* is lost.

So each neuron has to broadcast two things at once. Singer:

> neurons participating in a distributed representation of a particular type of content convey two messages in parallel: First, they have to signal whether the feature they're tuned to is present; second, they have to indicate which of the many other neurons they're cooperating with in forming a distributed representation.

The first message is uncontroversial — neurons signal that their feature is present by firing faster. The second is the hard one, the "who am I bound with" signal, and it's the whole problem, because the brain can't solve it by having a dedicated neuron for every possible whole object (there aren't enough neurons for every conjunction of every feature). It has to compose objects out of reused parts, and the moment you compose from reused parts you need a way to say which parts go together. This isn't armchair theorizing, either: when you overload someone's attention, the binding actually *fails* — flash a green T and a red X and people will confidently report a red T and a green X. The features got detected correctly and bound to the wrong partners.

## The answer: a shared beat

Singer's proposal is that the "who with whom" signal is carried in *time*:

> We've proposed that the relation-defining signature is the precise synchronization of the discharges of the individual neurons.

The neurons representing one object fire in lockstep, on the same beat; the neurons representing the other object fire on a different beat. Same features active, but the timing says who belongs with whom. And crucially this isn't just a label stuck on a group — it's mechanical, because a downstream neuron is a coincidence detector: inputs landing at the same instant summate and push it over threshold, while the same inputs spread out in time just decay and get ignored. So firing in sync is how a coalition makes itself *loud* enough to be acted on:

> Precise synchronization increases the impact of neuronal discharges, favoring further joint processing of the synchronized messages.

The beat doesn't merely mark who's together; it *is* the means by which they act as one. And it's carried on oscillations — rhythmic firing in the beta and gamma bands, roughly 20 to 80 Hz — because oscillating populations lock to each other far more easily than irregular ones do. The supporting evidence is elegant: take a stimulus degraded by noise so a subject consciously perceives it only about half the time, hold the physical stimulus fixed, and compare the "saw it" trials against the "didn't." On the conscious trials, widely separated cortical regions transiently lock into synchronized high-frequency oscillation; on the unconscious trials the same regions still process the stimulus locally, but they never join into a global synchronized pattern. Singer's reading:

> access to consciousness requires that a sufficiently large number of processing areas... be bound by synchronization and that those coherent states be maintained over a sufficiently long period.

Unity, on this account, just falls out: if entering consciousness *requires* global synchronization, and synchronization *is* the binding of meaning, then whatever makes it into consciousness is necessarily coherent. He cheerfully admits the argument is "somewhat circular," but it's the circularity of an identity claim, not a dodge.

## Read it as communications engineering

This is the point where, if you've ever touched signal processing, the whole thing snaps into a familiar shape, because what Singer is describing is *multiplexing* — and seeing it that way answered a question that had been nagging me, which is how such a low-frequency rhythm could possibly carry enough information.

It's **time-division multiplexing layered on frequency-division multiplexing.** Within a single gamma cycle, competing coalitions take distinct *phase slots* — different objects fire at different moments within the cycle, which is pure TDM. And across the spectrum, the different frequency bands (theta, alpha, beta, gamma) run at once as parallel carriers, which is FDM. The famous theta-gamma coupling, where a slow theta rhythm frames a train of fast gamma cycles, is literally TDM slots inside a frame defined by a slower carrier.

And the capacity question I'd been stuck on dissolves once you stop measuring it in Hertz. The frequency is the clock, not the channel; what matters is how many distinguishable phase slots fit inside a cycle, and that's set by how precisely neurons can lock — to a couple of milliseconds. A 40 Hz cycle is 25 milliseconds long, divided into ~2–3 ms slots gives you roughly **seven** distinguishable slots. Which is, suspiciously, the capacity of working memory — the famous seven-plus-or-minus-two. The apparent weakness, the "low bandwidth," may *be* the explanation for one of the most robust limits in psychology: you can hold about seven things in mind at once because that's how many coalitions fit in the frame before they smear together.

Two refinements make the engineering analogy better than the radio version. First, the low bandwidth is fine because synchrony is only carrying the *grouping tag* — the "who's with whom" — not the *content*. What the object actually *is*, in all its detail, lives in *which* neurons are firing and how fast, a colossal space; the timing only has to separate the handful of coalitions coexisting right now. It's an address bus, not a data bus — except, unlike an engineered system, the same spike train carries both, the rate saying *what* and the timing saying *with whom*, multiplexed onto one signal. Second, unlike radio, where frequency is an arbitrary channel label, here the frequency band also encodes *spatial reach*: low frequencies synchronize over long distances and large territories, high frequencies stay local, because you simply can't hold a fast rhythm coherent across a long slow axon. Gamma is the local network; theta is the long-haul backbone. (This is the spine of Buzsáki's *Rhythms of the Brain*, if you want to go deeper — the brain runs a whole hierarchy of frequencies precisely so that the band tells you both the channel and the range.)

There's even an access protocol. Nobody assigns the slots — there's no scheduler, which there can't be, given there's no convergence center — so what carves them is *inhibition*: rhythmic waves of inhibition open brief windows when excitatory neurons are allowed to fire, the strongest coalition wins the window and its firing recruits inhibition that silences its rivals, and on the next cycle a different coalition gets its turn. It's decentralized contention for a shared medium, which feels like Ethernet — but with a telling difference. Ethernet is built for *fair delivery*: every message gets through eventually. This is built for *selection*: the losing coalitions aren't queued for retransmission, they're suppressed, and may never reach consciousness at all. The inhibitory contention isn't multiplexing in order to share the channel fairly; it's running an *election* for which coalition gets to broadcast — which is exactly what you'd want if the channel's job is to decide what becomes conscious.

## The part that actually unsettles me

Here's the turn. Singer's closing ambition is to read the code — to "extract the information encoded in these high-dimensional time series," as he puts it, on the view that complex content lives in the temporal relations across an assembly rather than in any single neuron's rate. And that ambition quietly imports a picture: a message, encoded into a signal, recovered by a *decoder*. But he has just spent the whole interview insisting there is no decoder — no convergence center, no reader, nobody home to consult the code and understand it. So who reads it?

The resolution, I think, is to drop the reader and keep the code: **encoded information doesn't need anyone to read it; it only needs to influence what happens next.** A pattern is "encoded" in a population if the next stage of the system is causally sensitive to it and it shapes behaviour — full stop. And the thing that makes the next stage sensitive to a *timing* code is just the coincidence-detecting membrane: synchronous inputs summate and propagate, scattered ones die away. The "reader" of the synchrony code isn't a mind. It's the physics of how a neuron adds up its inputs.

Which means the code is *read by the substrate itself*, for free, and that's not a deflation — it's the most interesting thing in the chapter. Temporal coding works because it offloads the decoding onto biophysics: you don't *compute* the binding and then have something interpret the result, the coincidence detection *is* the computation. The timing computes *in the medium* rather than *on top of it*. (It's also, I suspect, why the brain bothers with timing codes at all when artificial networks get so far on firing rates alone: a rate code is expensive, you have to spend many spikes to represent it, whereas a single spike's timing is cheap, and when your budget is twenty watts you take the cheap channel that the physics decodes for you.) The unity of your experience is assembled by a rhythm, the rhythm is read by nothing but the integrating physics of the next neuron along, and there is no one in there reading any of it. The coherence is real and the audience is empty.

## The honest caveats

Two, and they matter. First, all of this is Singer's *hypothesis*, stated with the confidence of consensus, and he's its chief proponent rather than a neutral narrator. Whether synchrony actually does the binding is contested — the sharpest rebuttal (Shadlen and Movshon's "Synchrony Unbound") argues it may be an epiphenomenon of shared input that no neuron actually decodes, and modern deep networks bind complex scenes with no oscillations whatsoever, which proves synchrony isn't *necessary* for binding-like grouping even if the brain happens to use it. And whether synchrony is the mark of *consciousness* specifically is even more open, with serious rival theories putting the essence elsewhere — global broadcast and late ignition, or integrated information, or recurrent processing. A recent adversarial collaboration between two of the leading theories settled neither cleanly. Hold binding-by-synchrony as a strong candidate, not a verdict.

Second, Singer himself draws the line I keep coming back to. Even granting the entire picture — even if the neural correlate of consciousness turns out to be exactly these metastable patterns of synchronized oscillation, fully described and even manipulable — he concedes that something is left over:

> How these neuronal activation patterns eventually give rise to subjective feelings, emotions, and so on, will probably remain a conundrum for quite some time even if we arrive at precise descriptions of neuronal states corresponding to consciousness.

That's the hard problem, stated from inside the lab by a man with no patience for mysticism. He's describing the most complete *third-person* account anyone could hope for and admitting the first-person fact doesn't obviously come with it — the same gap I wrote about in the [flagship essay](/posts/two-gaps-machine-consciousness). It's one thing to read a philosopher say it. It's another to watch a neurophysiologist arrive at the same wall by walking straight at the mechanism.

So: a brain with no center, binding the world with a beat, the beat read by nothing but the physics of the next cell, the whole coherent scene assembled for an audience that isn't there — and even if we map every last oscillation, the question of why any of it is *felt* still standing, untouched, at the end.
