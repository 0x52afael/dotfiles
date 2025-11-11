### --- Zinit bootstrap ---
if [[ ! -f ~/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  echo "Installing Zinit..."
  mkdir -p ~/.local/share/zinit && \
  git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
fi

source ~/.local/share/zinit/zinit.git/zinit.zsh


### --- General optimization options ---
# Compile and cache plugins for faster startup
zinit ice wait lucid

# Automatically compile scripts after first run
autoload -Uz compinit && zinit cdreplay -q


### --- Plugins ---

# 🟢 NVM (Node Version Manager)
# Lazy-load only when you run node, npm, or nvm commands
zinit ice wait"1" lucid \
    atinit"export NVM_LAZY_LOAD=true" \
    trigger-load'nvm;node;npm;npx'
zinit light lukechilds/zsh-nvm


# 🟡 Autojump
# Lazy-load only when `j` is first used
zinit ice wait"1" lucid \
    trigger-load'j'
zinit light wting/autojump


# 🔵 FZF (fuzzy finder)
# Load when Ctrl+R is first pressed or fzf command is used
zinit ice wait"1" lucid \
    trigger-load'fzf;fzf-history-widget' \
    atclone'[[ -f install ]] && bash install --no-update-rc --key-bindings --completion || true' \
    atpull'%atclone' \
    nocompile'!'  # skip compilation to avoid slowdown on large scripts
zinit light junegunn/fzf


# 🟣 Zsh Autosuggestions
# Lazy-load slightly after prompt (1s delay)
zinit ice wait "1" lucid
zinit light zsh-users/zsh-autosuggestions


# 🔴 Syntax Highlighting
# Load last (should come after autosuggestions)
zinit ice wait"1" lucid
zinit light zsh-users/zsh-syntax-highlighting


### --- Optional extras ---
# Enable fzf-tab completion enhancement (optional)
# zinit ice wait"1" lucid
# zinit light Aloxaf/fzf-tab


### --- Maintenance ---
# Compile plugins and snippets for faster startup
zinit compile
zinit cdreplay -q

