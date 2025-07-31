# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export SYSTEM_COLOR_SCHEME=dark

export ZSH="$HOME/.oh-my-zsh"

[ -f /tmp/system_color_scheme.tmp ] && source /tmp/system_color_scheme.tmp

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster-new-line"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="warlord"
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
 export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  sudo
  zsh-autosuggestions
  extract
  zsh-syntax-highlighting
  cabal
)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/aliasrc

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# npm set prefix ~/.npm
# export PATH="$HOME/.npm/bin:$PATH"
# export PATH="$HOME/node_modules/.bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH=$PATH:~/.cabal/bin:~/.psvm/current/bin:~/.local/bin

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


# export LC_ALL=en_US.UTF-8
# export LANG="en_US.UTF-8"
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8

#fortune | cowsay | lolcat
figlet -f ~/.fonts/figlet/Bloody "Shivam" -w 1000 | lolcat

alias myxargs='perl -p -e "s/\n/\0/;" | xargs -0'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

[[ -e /usr/bin/fzf ]] && source <(fzf --zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
if [[ -n "$IN_NIX_SHELL" ]]; then
  unset FZF_DEFAULT_COMMAND
else
  export FZF_DEFAULT_OPTS=' --bind "alt-a:select-all,alt-d:deselect-all"'
  export FZF_DEFAULT_COMMAND='rg --files --ignore-case --no-ignore --hidden --follow --glob "!.git/*"'
fi
# export LD_LIBRARY_PATH=/usr/lib
# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

if [[ -s /Library/Java/JavaVirtualMachines/jdk1.8.0_281.jdk/Contents/Home/bin ]]; then
  export PATH="/Library/Java/JavaVirtualMachines/jdk1.8.0_281.jdk/Contents/Home/bin:$PATH"
fi

if [[ -s /usr/lib/jvm/default/bin ]]; then
  export PATH=${PATH}:/usr/lib/jvm/default/bin
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if command -v direnv >/dev/null 2>&1 && [[ -z "$IN_NIX_SHELL" ]]; then
  eval "$(direnv hook zsh)"
fi


export PATH="$PATH:$HOME/Library/Python/3.9/bin"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

[ -s "$HOME/.config/.secrets" ] && source $HOME/.config/.secrets

# Added by helper-cli

he() {
  local command
  command=$(h -e)
  if [[ -n "$command" ]]; then
    print -z "$command"
  fi
}

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
