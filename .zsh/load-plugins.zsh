### --- Zinit bootstrap ---
if [[ ! -f ~/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  echo "Installing Zinit..."
  mkdir -p ~/.local/share/zinit && \
  git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
fi
source ~/.local/share/zinit/zinit.git/zinit.zsh

### --- NVM (lazy-load) ---
zinit ice wait'0' depth=1 silent
zinit light lukechilds/zsh-nvm
# Completions

zinit ice wait'0' depth=1 silent
zinit light zsh-users/zsh-completions

# Autosuggestions
zinit ice wait'0' depth=1 silent
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting (must come last)
zinit ice wait'0' depth=1 silent
zinit light zsh-users/zsh-syntax-highlighting

zinit light mdumitru/fancy-ctrl-z
### --- Maintenance ---
zinit compile
zinit cdreplay -q


open_yazi() {
    zle -I 
    yazi 
    zle redisplay
}

