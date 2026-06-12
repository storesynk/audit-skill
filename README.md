# Storesynk Audit

An AI skill that audits and debugs [Storesynk](https://www.storesynk.com) builds in Webflow. Give Claude the URL of the page that's misbehaving and a description of the problem — it fetches the live page, checks your Storesynk markup against the official structural rules, matches your symptom against the most common support issues, and reports exactly what's wrong and how to fix it, with links to the official docs.

## What it checks

- **Installation** — script tag present (once), token/domain configured, version requirements
- **Structure** — component nesting rules (e.g. nested Product Containers, cart hierarchy), with stable rule codes
- **Attributes** — every `sf-*` attribute validated against the complete catalog (typos get caught)
- **Element types** — components placed on the right HTML elements
- **Known issues** — the most frequent support problems (checkout 404s, sync failures, market quirks, account loops…) matched by symptom

## Requirements

The skill audits your **published** page by fetching its HTML, so Claude needs network access in your environment:

- **Claude Code** (terminal, desktop app, IDE, web): works out of the box — no extra setup.
- **Claude (claude.ai)**: requires a paid plan and two capabilities turned on — **code execution** (skills run inside it) and **web search** (so Claude can retrieve your live page). See the step-by-step under [Install → Claude (claude.ai)](#claude-claudeai) below.

Optional, for deeper diagnostics:

- **Claude in Chrome** (or any browser automation tool): lets Claude read console errors and runtime state on your live site, not just the served HTML.
- **Webflow MCP**: lets Claude inspect unpublished Designer state. Without it, publish to your `*.webflow.io` staging domain and audit that.

## Install

### Claude Code CLI (terminal) — plugin marketplace

```
/plugin marketplace add storesynk/audit-skill
/plugin install storesynk-audit@storesynk
```

(The `/plugin` commands are terminal-only; in the desktop app use the Customize panel below.)

### Claude Code — manual

Copy the skill folder into your skills directory:

```bash
git clone https://github.com/storesynk/audit-skill.git
cp -r audit-skill/skills/storesynk-audit ~/.claude/skills/
```

(Use your project's `.claude/skills/` instead of `~/.claude/skills/` to install for a single project.)

### Claude Desktop app

1. Open the Claude Desktop app and open the **Customize** panel in the left sidebar.
2. Click **Skills** (or **Plugins**, depending on your app version).
3. Click the **+** button next to **Personal plugins** / **Personal skills**.
4. Click **+ Create plugin**
5. Click **Add marketplace**
6. Click **Add from a repository**
7. Paste the repository URL into the dialog:
   ```
   https://github.com/storesynk/audit-skill
   ```
8. Click **Use → https://github.com/storesynk/audit-skill** text which appears below the skills list.
9. Click **Sync**.

Start a new conversation and the skill is ready — ask something like _"Audit my Storesynk build at https://mystore.webflow.io"_.

### Claude (claude.ai)

Available on paid plans (Pro, Max, Team, Enterprise). Exact menu labels can shift as claude.ai evolves — if something looks different, search "skills" in the [Claude help center](https://support.claude.com).

1. **Enable code execution**: go to **Settings → Capabilities** and turn on **Code execution** (sometimes labeled "Code execution and file creation"). Skills run inside this sandbox — without it, skills won't work.
2. **Enable web search**: in the same Capabilities settings, turn on **Web search**. You can also check it per-chat via the tools (sliders) menu in the message box. Without it, Claude cannot fetch your live page to audit it.
3. **Install the skill**: open the **Customize** panel in the left sidebar and follow the same steps as the [Claude Desktop app](#claude-desktop-app) section above — add the marketplace from the repository URL and click **Sync**.

   **Fallback — zip upload:** if you don't see the Customize panel, download `storesynk-audit.zip` from the latest [release](https://github.com/storesynk/audit-skill/releases) (don't unzip it) and upload it under **Settings → Capabilities → Skills → Upload skill**.
4. **Use it**: start a new chat and describe your issue with the page URL (e.g. _"My add to cart isn't working on https://mystore.com/products/x"_). If the skill doesn't kick in on its own, say _"use the Storesynk Audit skill"_.

**Team/Enterprise note:** if the Code execution or Skills toggles are missing, your organization admin needs to enable those capabilities for the workspace first.

## Use

Ask Claude things like:

> My add to cart button doesn't do anything on https://mystore.com/products/blue-shirt — can you check it?

> Audit my Storesynk build before launch: https://mystore.webflow.io

Claude will ask for whatever it needs (the exact page URL, what's broken, whether it's a CMS page) and produce a structured audit report.

Tips:

- Share the **published page where the problem happens** — the custom domain or the `*.webflow.io` staging domain.
- Pasting browser console errors helps a lot.
- If Claude has browser tools (e.g. Claude in Chrome), it can also inspect runtime state and console output itself.

## Support

- Discord: https://discord.com/invite/NddWajkVK3
- Email: hello@storesynk.com
- Docs: https://www.storesynk.com/docs-home
