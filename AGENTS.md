# Repository Guidelines

## Project Structure & Module Organization
Repository root tracks the primary dotfiles that are symlinked into `$HOME` (`bashrc`, `zshrc`, `tmux.conf`, `vimrc`, etc.). `install.sh` bootstraps a new machine by installing core packages and creating the required symlinks. Editor profiles live under `vim/` and `emacs.d/`, while terminal artifacts such as `tmux-resurrect/` and `tmux.conf` capture session state. Use `config/` for app-specific state (e.g., `config/atuin/`, `config/gh/`), and keep standalone helper binaries in `bin/`. Place automation or setup helpers inside `scripts/`, keeping one purpose per file.

## Build, Test, and Development Commands
Run `./install.sh` after updating tracked dotfiles to rebuild symlinks; it assumes Debian-based systems and installs `zsh` and `emacs`. Use `scripts/ripgreplauncher.sh` and other helpers as reference patterns for new utilities. When introducing new shell tools, add them under `bin/` and call them via absolute paths in documentation (e.g., `~/dotfiles/bin/my-tool`).

## Coding Style & Naming Conventions
Shell scripts should target Bash (`#!/bin/bash`) and use four-space indentation, explicit `set -euo pipefail`, and descriptive function names (`sync_tmux_state()`). File names stay lowercase with hyphens where needed (`uv-python-symlink`). Configuration directories mirror the upstream application name; new apps belong under `config/<app-name>/`. Keep comments succinct and focused on intent rather than restating commands.

## Testing Guidelines
Lint shell changes with `shellcheck` (e.g., `shellcheck scripts/ripgreplauncher.sh`). Validate Zsh updates using `zsh -n ~/.zshrc`. For Vim or Emacs changes, launch the editor with the repo config (`vim -Nu ~/dotfiles/vim/vimrc`, `emacs -Q --load ~/dotfiles/emacs.d/init.el`) to confirm clean startups. Re-run `./install.sh` in a temporary user environment when altering the bootstrap flow.

## Commit & Pull Request Guidelines
Commits follow a short, imperative mood (`fix uv`, `update gitignore`) and group related changes; aim for under 72 characters in the subject. Reference related issues when available and briefly note the rationale in the body. Pull requests should summarize the environment tested, mention any manual steps (e.g., rerunning `install.sh`), and include screenshots only when visual themes or terminal prompts change.
