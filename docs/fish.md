# Fish Shell Configuration

## Overview

This Fish setup focuses on:

- terminal-first workflows
- minimal UI noise
- Git-aware prompts
- fast navigation
- modular architecture
- modern CLI tooling
- theme-aware terminal UX

The configuration intentionally avoids large shell frameworks and instead uses native Fish features with lightweight custom functions.

---

# Goals

Main goals of the setup:

- fast shell startup
- minimal maintenance
- readable configuration
- workflow efficiency
- clean terminal aesthetics
- reproducible setup via GNU Stow

---

# Directory Structure

```text
fish/
├── completions/
├── conf.d/
├── functions/
│   ├── fish_prompt.fish
│   └── fish_right_prompt.fish
├── config.fish
└── fish_variables
```

---

# Configuration Philosophy

The setup follows a modular architecture.

Responsibilities are separated into:

| Component | Responsibility |
|---|---|
| config.fish | shell initialization |
| functions/ | reusable shell logic |
| fish_prompt.fish | left prompt |
| fish_right_prompt.fish | Git-aware right prompt |
| conf.d/ | optional modular startup files |
| completions/ | custom shell completions |

The structure is intentionally lightweight and easy to extend over time.

---

# config.fish

`config.fish` acts as the shell entrypoint.

Main responsibilities:

- interactive shell detection
- shell defaults
- aliases
- zoxide initialization
- helper command setup

---

## Interactive Shell Guard

```fish
if status is-interactive
```

Ensures the configuration only runs for interactive shells.

Prevents unnecessary execution in:

- scripts
- subprocesses
- automation environments

---

## Disabled Greeting

```fish
set -g fish_greeting ""
```

Disables the default Fish startup greeting for a cleaner shell experience.

---

## Modern CLI Workflow

The setup replaces traditional Unix tools with modern alternatives.

| Traditional | Modern |
|---|---|
| ls | eza |
| cat | bat |
| find | fd |
| grep | ripgrep |
| cd | zoxide |

---

# Prompt System

The shell prompt is split into two independent components:

| Prompt | Purpose |
|---|---|
| fish_prompt | navigation and session context |
| fish_right_prompt | Git repository state |

This separation keeps the shell readable while still exposing important repository information.

---

# Left Prompt

The left prompt intentionally stays minimal.

Displayed information:

- current directory
- SSH session indicator
- root user warning
- prompt arrows

---

## SSH Awareness

When connected through SSH, the prompt displays:

```text
user@hostname
```

This helps prevent confusion between local and remote systems.

---

## Root Warning

A red `#` is shown when running as root.

This provides additional safety during administrative work.

---

# Right Prompt

The right prompt provides Git repository awareness.

Displayed information includes:

| Feature | Symbol |
|---|---|
| command failure | ✘ |
| branch | branch name |
| detached HEAD | magenta branch |
| merge/rebase action | action label |
| ahead of remote | ⬆ |
| behind remote | ⬇ |
| stash exists | ✭ |
| added files | ✚ |
| deleted files | ✖ |
| modified files | ✱ |
| renamed files | ➜ |
| merge conflicts | ═ |
| untracked files | ◼ |

---

# Git Performance Considerations

The Git prompt is optimized to avoid unnecessary slowdowns.

Example:

Instead of:

```bash
git stash list
```

the configuration directly checks stash references:

```text
.git/refs/stash
```

This avoids expensive Git operations during prompt rendering.

---

# Theme Integration

The shell intentionally uses minimal hardcoded styling.

The terminal theme itself is handled by Kitty.

Fish only provides small semantic highlights:

- errors
- warnings
- Git states
- SSH awareness

This keeps the terminal visually consistent across themes.

---

# Kitty Theme Switching

Custom Fish helper functions allow fast terminal theme switching.

Example:

```fish
kitty-monalisa
kitty-novel
```

These commands update Kitty theme symlinks without manual editing.

---

# fish_variables

`fish_variables` should NOT be version controlled.

Reason:

- machine-specific state
- universal variables
- local shell state
- unstable cross-system behavior

Recommended `.gitignore` entry:

```gitignore
fish/fish_variables
```

---

# Empty conf.d/ and completions/

Both directories currently remain intentionally empty.

They exist for future extensibility.

Possible future use cases:

## conf.d/

```text
aliases.fish
env.fish
paths.fish
zoxide.fish
```

## completions/

Custom CLI completions for personal scripts or tools.

---

# Shell Workflow Philosophy

The shell is treated as a lightweight workflow environment rather than only a command runner.

Focus areas:

- navigation speed
- keyboard-driven workflows
- Git awareness
- minimal distractions
- clean terminal aesthetics
- reproducibility

---

# Future Improvements

Possible future additions:

- startup performance profiling
- modular conf.d/ separation
- custom completions
- AI workflow helper commands
- session management
- project bootstrap commands

---

# Summary

This Fish setup intentionally prioritizes:

- simplicity
- readability
- modularity
- performance
- maintainability
- theme-aware terminal UX

The result is a lightweight shell environment optimized for modern terminal-based development workflows.
