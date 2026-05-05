# ⚙️ Dotfiles

Personal Linux setup managed with GNU Stow.

---

## 🧰 Tools

- fish
- kitty
- neovim (LazyVim)
- ranger

---

## 🚀 Setup

### Option 1 (recommended)

```bash
bash <(curl -s https://raw.githubusercontent.com/eleventozero/dotfiles/main/bootstrap.sh)
```

### Option 2 (manual)

```bash
git clone git@github.com:eleventozero/dotfiles.git
cd dotfiles
./install.sh
```

---

## 🏗️ Structure

Each tool is managed with GNU Stow:

- fish → ~/.config/fish
- kitty → ~/.config/kitty
- ranger → ~/.config/ranger
- nvim → ~/.config/nvim

---

## 🧠 Notes

- Uses symlinks via stow  
- Safe to run multiple times  
- Existing configs are automatically backed up  
