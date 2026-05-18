# Kitty Terminal Configuration

## Overview

This Kitty setup defines the visual layer of the dotfiles environment.

It focuses on:

- dark transparent terminal design
- amber/gold main foreground
- minimal visual noise
- portable theme switching
- clean integration with Fish, Ranger, and Neovim

---

## File Structure

```text
kitty/
└── .config/
    └── kitty/
        ├── kitty.conf
        ├── current-theme.conf
        └── themes/
            ├── MonaLisa.conf
            ├── MonaLisa-Gruvbox.conf
            ├── MonaLisa-Kanagawa.conf
            └── MonaLisa-Tokyo.conf
```

---

## Responsibility Split

| File | Purpose |
|---|---|
| `kitty.conf` | terminal behavior, font, opacity, shortcuts |
| `themes/*.conf` | color palettes |
| `current-theme.conf` | active theme symlink |

This separates terminal behavior from visual styling.

---

## Main Settings

Important settings in `kitty.conf`:

```conf
font_family JetBrainsMonoNL Nerd Font
font_size 13.5

window_padding_width 12
cursor_shape beam

background_opacity 0.75
background_blur 10

enable_audio_bell no
confirm_os_window_close 0

hide_window_decorations yes
tab_bar_style hidden
```

Notes:

- `hide_window_decorations yes` removes the OS title bar.
- `tab_bar_style hidden` removes Kitty's internal tab bar.
- Tabs can still be switched with shortcuts.

```conf
map ctrl+shift+right next_tab
map ctrl+shift+left previous_tab
```

---

## Theme System

Kitty loads the active theme through:

```conf
include current-theme.conf
```

`current-theme.conf` should be a symlink, not a copied theme file.

Correct:

```text
current-theme.conf -> themes/MonaLisa.conf
```

---

## Relative Symlink Strategy

Use relative symlinks so the repo stays portable.

Correct command:

```bash
cd ~/.config/kitty
ln -sf themes/MonaLisa.conf current-theme.conf
```

Avoid absolute symlinks like:

```text
/home/user/.config/kitty/themes/MonaLisa.conf
```

Relative symlinks are better for:

- cloned setups
- GNU Stow
- different usernames
- different machines

---

## Switching Themes

Example:

```bash
cd ~/.config/kitty
ln -sf themes/MonaLisa-Gruvbox.conf current-theme.conf
kitty @ set-colors -a current-theme.conf
```

Verify:

```bash
ls -l current-theme.conf
```

Expected:

```text
current-theme.conf -> themes/MonaLisa-Gruvbox.conf
```

---

## ANSI Colors

Kitty defines the 16 terminal ANSI colors.

| Normal | Bright |
|---|---|
| `color0` black | `color8` brblack |
| `color1` red | `color9` brred |
| `color2` green | `color10` brgreen |
| `color3` yellow | `color11` bryellow |
| `color4` blue | `color12` brblue |
| `color5` magenta | `color13` brmagenta |
| `color6` cyan | `color14` brcyan |
| `color7` white | `color15` brwhite |

Fish, Git, Ranger, and many terminal tools use these colors.

---

## Theme Direction

Current visual direction:

```text
dark noir background
+ amber/gold foreground
+ readable semantic ANSI accents
+ warm Gruvbox/Kanagawa-inspired colors
```

Core colors:

```conf
background #110b0d
foreground #f6d56a
```

These should stay stable. Accent colors can be adjusted for readability.

---

## Troubleshooting

### Theme does not change

Reload:

```bash
kitty @ set-colors -a ~/.config/kitty/current-theme.conf
```

Or restart Kitty.

---

### Broken `current-theme.conf`

Fix:

```bash
cd ~/.config/kitty
rm current-theme.conf
ln -sf themes/MonaLisa.conf current-theme.conf
```

---

### Top bar is still visible

There are two different bars:

| Bar | Fix |
|---|---|
| Kitty tab bar | `tab_bar_style hidden` |
| OS title bar | `hide_window_decorations yes` |

---

## Summary

The Kitty setup uses a simple layered architecture:

```text
kitty.conf
→ terminal behavior

themes/*.conf
→ color palettes

current-theme.conf
→ active theme symlink
```

This keeps the setup portable, clean, and easy to theme.
