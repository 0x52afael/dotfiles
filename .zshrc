setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
# setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

# ==========================
# 🧠 Aliases
# ==========================
alias vim="nvim"
alias ls="eza --icons --group-directories-first --color=always --git"
alias ll="eza -l --icons --git"
alias la="eza -a --icons --group-directories-first --color=always --git"
alias tree="eza --tree --icons"
alias lg="lazygit"
alias gs="git status"
# ==========================
# ⚙️ Environment Variables
# ==========================
export LSP_LTEXLS_JAVA_OPTS="--add-opens=java.xml/com.sun.org.apache.xerces.internal.impl=ALL-UNNAMED -Djdk.xml.totalEntitySizeLimit=0"
export LANG=sv_SE.UTF-8
export LC_ALL=sv_SE.UTF-8
export HOMEBREW_PREFIX="$(brew --prefix)"
export NVM_DIR="$HOME/.nvm"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export EDITOR=nvim
export ZSH_DISABLE_COMPFIX=true
export KEYTIMEOUT=10
export JAVA_HOME=$(/usr/libexec/java_home)
autoload -Uz compinit && compinit
export PATH="$JAVA_HOME/bin:$PATH"
# ==========================
# Plugins
# ==========================

# --- NVM ---
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS
  export LANG=sv_SE.UTF-8
  export LC_ALL=sv_SE.UTF-8
  export HOMEBREW_PREFIX="$(brew --prefix)"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \
    \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && \
    . $(brew --prefix)/etc/profile.d/autojump.sh

  if command -v fzf >/dev/null; then
    # Make sure fzf shell integration is loaded
    [[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]] && \
      source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

  # Ctrl+R → Fuzzy search command history
  bindkey '^R' fzf-history-widget
  fi

# --- Autosuggestions ---
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# --- Syntax Highlighting ---
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

source ~/.zsh/fzf/themes/catppuccin-fzf-frappe.sh
else
  source ~/.zsh/load-plugins.zsh
fi


# --- FZF Key Bindings ---


# ==========================
# Completion
# ==========================

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey '^x^e' edit-command-line



reload() {
  source ~/.zshrc
}

zle -N reload 
bindkey '^a^r' reload

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# ==========================
# Prompt (Starship)
# ==========================
eval "$(starship init zsh)"

# Vi-mode
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^E' autosuggest-accept
bindkey -M viins '^E' autosuggest-accept
bindkey -M vicmd '^P' up-line-or-history
bindkey -M viins '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey -M viins '^ ' autosuggest-accept-word
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

zle -N open_yazi
bindkey '^[n' open_yazi

# eval $(thefuck –alias)
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
