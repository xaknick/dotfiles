# dotfiles
Use GNU stow to create symlinks for specified tools:
```
stow zsh nvim wezterm
```

If you already have configs for some of tools, you can apply them and overwrite the config from this repository:
```
stow --adopt zsh nvim wezterm
```
