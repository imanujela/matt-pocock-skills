# The canonical install block

Change it here first, then propagate. One install story, one wording. README.md must say this and nothing else.

This fork installs from https://github.com/imanujela/matt-pocock-skills. Do not send users to mattpocock/skills or claude-plugins-official. Those serve the upstream set, which does not have the new skills.

The marketplace name in .claude-plugin/marketplace.json is imanujela. The plugin name stays mattpocock-skills, so the install target is mattpocock-skills@imanujela.

## Local installer

scripts/link-skills.sh clones this repo if needed and links every skill except deprecated/ into Claude Code, Codex, and Hermes. That is the route that also installs pressure-check and simplify-diff, which the plugin does not ship.

```bash
bash scripts/link-skills.sh
```

## Claude Code

```bash
claude plugin marketplace add imanujela/matt-pocock-skills
claude plugin install mattpocock-skills@imanujela
```

Updates when the plugin version in this repo changes.

## Codex

```bash
codex plugin marketplace add imanujela/matt-pocock-skills
codex plugin add mattpocock-skills@imanujela
```

Updates itself at startup.

## GitHub Copilot (CLI and VS Code)

```bash
copilot plugin marketplace add imanujela/matt-pocock-skills
copilot plugin install mattpocock-skills@imanujela
```

Then, once, add to ~/.copilot/settings.json:

```json
{
  "extraKnownMarketplaces": {
    "imanujela": { "source": { "source": "github", "repo": "imanujela/matt-pocock-skills" }, "autoUpdate": true }
  }
}
```

In VS Code, run **Chat: Install Plugin From Source** and enter https://github.com/imanujela/matt-pocock-skills.

## Gemini CLI

```bash
gemini skills install https://github.com/imanujela/matt-pocock-skills.git --path skills/engineering
gemini skills install https://github.com/imanujela/matt-pocock-skills.git --path skills/productivity
```

Re-run both commands to update. Gemini does not read this marketplace, and --path takes one bucket. in-progress and misc are not in those two commands. Use scripts/link-skills.sh for pressure-check and simplify-diff.

## Every other agent

```bash
npx skills@latest add imanujela/matt-pocock-skills -a <agent>
```

To update, run npx skills@latest update, and re-run add to pick up new skills. When the installer asks which skills to take, include setup-matt-pocock-skills, deepen-picked, and rewrite-agent-docs.

One skill:

```bash
npx skills@latest add imanujela/matt-pocock-skills --skill=<name>
npx skills@latest update <name>
```

## The two routes are exclusive

Installing the plugin and a skills.sh copy leaves every skill twice. Pick one.
