# Ranger File Manager Configuration

## Overview

This Ranger setup provides a terminal-based file manager workflow focused on:

- fast keyboard navigation
- Neovim integration
- Kitty image previews
- text/code previews
- clipboard workflow
- minimal configuration
- clean integration with Fish and Kitty

Ranger is used as a lightweight terminal file manager inside the dotfiles environment.

---

## File Structure

```text
ranger/
└── .config/
    └── ranger/
        ├── rc.conf
        ├── rifle.conf
        ├── scope.sh
        ├── commands.py
        └── commands_full.py
```

---

## Responsibility Split

| File | Purpose |
|---|---|
| `rc.conf` | Ranger UI, behavior, keybindings |
| `rifle.conf` | decides how files are opened |
| `scope.sh` | preview system |
| `commands.py` | custom Ranger commands |
| `commands_full.py` | full default command reference |

---

## rc.conf

`rc.conf` defines the main Ranger behavior.

Important settings:

```conf
set viewmode miller
set column_ratios 1,3,4

set preview_files true
set preview_directories true
set collapse_preview true

set use_preview_script true

set preview_images true
set preview_images_method kitty
```

This enables:

- Miller column navigation
- file previews
- directory previews
- Kitty image previews
- external preview handling through `scope.sh`

---

## Neovim Integration

Files are opened directly in Neovim:

```conf
map e shell nvim -- %f
map <ENTER> shell nvim -- %f
map <CR> shell nvim -- %f
```

The editor itself is configured globally in Fish:

```fish
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less
```

Do not use this in Ranger:

```conf
set editor nvim
```

Ranger has no `editor` option. This causes:

```text
The option named 'editor' does not exist
```

---

## Clipboard Workflow

Clipboard integration uses `wl-copy`.

Required package:

```text
wl-clipboard
```

Recommended mappings:

```conf
# Copy file content to clipboard.
map yc shell -- sh -c 'cat "$1" | wl-copy' sh %f

# Copy file path to clipboard.
map yP shell -- sh -c 'printf "%s/%s" "$1" "$2" | wl-copy' sh %d %f

# Copy selected files with headers.
map yC shell -- sh -c 'for f in "$@"; do echo "===== $f ====="; cat "$f"; echo; done | wl-copy' sh %s
```

Reason:

- `yy` should stay Ranger's default file copy command.
- Custom clipboard actions should use separate bindings.

---

## rifle.conf

`rifle.conf` decides how files are opened.

Main rule:

```conf
ext md|txt|lua|java|c|cpp|h|hpp|py|sh|bash|fish|html|css|js|ts|json|xml|csv|tex|yml|yaml|toml|ini|conf = nvim -- "$@"
```

This means common text and code files open in Neovim.

Recommended fallbacks:

```conf
mime ^text = ${VISUAL:-$EDITOR} -- "$@"
label open, has xdg-open = xdg-open -- "$@"
label editor = ${VISUAL:-$EDITOR} -- "$@"
label pager = "$PAGER" -- "$@"
```

---

## scope.sh

`scope.sh` controls the preview pane.

The optimized preview setup focuses on:

- text/code preview with `bat` or `batcat`
- JSON preview with `jq`
- PDF text preview with `pdftotext`
- archive listing with `unzip` or `tar`
- image preview through Kitty
- audio/video metadata with `mediainfo`

---

## Required Packages

The Ranger setup depends on:

```text
ranger
bat
jq
unzip
poppler-utils
mediainfo
wl-clipboard
```

Optional but useful:

```text
less
file
tar
```

Most systems already include `file` and `tar`.

---

## Ubuntu bat/batcat Note

On Ubuntu, the package is named:

```text
bat
```

but the executable is often:

```text
batcat
```

The preview script should detect both:

```bash
if command -v bat >/dev/null 2>&1; then
    BAT_CMD="bat"
elif command -v batcat >/dev/null 2>&1; then
    BAT_CMD="batcat"
else
    BAT_CMD=""
fi
```

This keeps the setup portable.

---

## Kitty Image Preview

Ranger image preview is configured through:

```conf
set preview_images true
set preview_images_method kitty
```

This works well inside Kitty and avoids external image preview tools like `w3mimgdisplay`.

---

## Workflow Philosophy

Ranger is used as a fast terminal file manager.

Main workflow:

```text
navigate files
→ preview content
→ open/edit in Neovim
→ copy paths/content for AI workflows
→ manage files without leaving the terminal
```

This fits the rest of the dotfiles architecture:

```text
Kitty  → terminal UI
Fish   → shell workflow
Ranger → file navigation
Neovim → editing
```

---

## Troubleshooting

### Image preview does not work

Check:

```conf
set preview_images true
set preview_images_method kitty
```

Also make sure you are running Ranger inside Kitty.

---

### `bat` not found

On Ubuntu, try:

```bash
command -v batcat
```

If it exists, use `batcat` or automatic detection in `scope.sh`.

---

### `wl-copy` not found

Install:

```bash
sudo apt install wl-clipboard
```

---

### Ranger editor option error

Remove:

```conf
set editor nvim
```

Use Fish environment variables instead:

```fish
set -gx EDITOR nvim
set -gx VISUAL nvim
```

---

## Summary

The Ranger setup is designed as a minimal terminal file manager layer.

It provides:

- fast navigation
- previews
- Neovim opening
- Kitty image support
- clipboard integration
- portable preview behavior

It should stay small and focused instead of carrying the full default Ranger configuration.
