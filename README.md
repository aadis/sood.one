# sood.one

Personal site built on Quartz v5.

## Setup on a new machine

1. `npm ci && npx quartz plugin install`
2. Create `.vault-path.local` (git-ignored) pointing to your local Obsidian vault:
   ```bash
   echo "/path/to/your/vault" > .vault-path.local
   ```
3. Run `./sync.sh` to copy published notes into `content/`, then `npx quartz build --serve` to preview.

`sync.sh` defaults to the work-laptop vault path if `.vault-path.local` is absent.

---

# Quartz v5

> “[One] who works with the door open gets all kinds of interruptions, but [they] also occasionally gets clues as to what the world is and what might be important.” — Richard Hamming

Quartz is a set of tools that helps you publish your [digital garden](https://jzhao.xyz/posts/networked-thought) and notes as a website for free.

🔗 Read the documentation and get started: https://quartz.jzhao.xyz/

[Join the Discord Community](https://discord.gg/cRFFHYye7t)

## Sponsors

<p align="center">
  <a href="https://github.com/sponsors/jackyzha0">
    <img src="https://cdn.jsdelivr.net/gh/jackyzha0/jackyzha0/sponsorkit/sponsors.svg" />
  </a>
</p>
