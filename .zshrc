# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
export LANG=en_US.UTF-8
export EDITOR=vim
export JAVA_HOME="/Library/Java/Home"

# ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Plugins loaded from ~/.oh-my-zsh/plugins/*
plugins=(
  brew
  common-aliases
  copypath
  copyfile
  docker
  fasd
  git
  sudo
  web-search
)
setopt HIST_FIND_NO_DUPS
path=(
  "${HOME}/bin"
  /home/linuxbrew/.linuxbrew/bin
  /usr/local/sbin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
)
source "${ZSH}/oh-my-zsh.sh"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
BREW="$(brew --prefix)"
eval "$(direnv hook zsh)"
source "${BREW}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${BREW}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "${BREW}/etc/profile.d/z.sh"
source "${BREW}/opt/fzf/shell/completion.zsh"
source "${BREW}/opt/fzf/shell/key-bindings.zsh"

function http(){
  httpStatusCode="${1}"
  curl -s "http://httpcode.info/${httpStatusCode}" | sed -e "/\s*</d" -e "/^\s*$/d"
}

function play(){
  fileName=${1}
  # 7=Max, 3=Mid, 0=Mute
  volume=${2}
  [ -n "${volume}" ] && osascript -e "set Volume ${volume}"
  (afplay "${HOME}/sound_clips/${fileName}.mp3"&)
}

function gitOriginDefault(){
  local defaultDefault='origin/master'
  local originDefault="$(git symbolic-ref refs/remotes/origin/HEAD --short 2> /dev/null)"
  echo "${originDefault:-${defaultDefault}}" | cut -d/ -f2-
}

alias gbda='gud && git branch --merged | grep -vE "^(\*|\s*($(git_current_branch)|master|develop|dev)\s*$)" | xargs -n 1 git branch -d'
alias gbdo='gud && git branch --remotes --merged | grep origin | sed "s,.*origin/,,"| grep -vE "^($(git_current_branch)|master|develop|dev)\s*$" | xargs -n 1 git push --delete origin'
alias gcm='git checkout $(gitOriginDefault)'
alias gmom='git merge origin/$(gitOriginDefault)'
alias grbm='git rebase $(gitOriginDefault)'
alias gsta='git stask --keep-index --incluce-untracked'

alias gitip='echo "git clone git://$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '\''{print $2}'\'')/"'
alias gitserve='git daemon --reuseaddr --base-path=. --export-all --verbose --enable=receive-pack'
alias gserve='gitip && gitserve'
alias gu='git reset --soft HEAD~'
alias god='git remote set-head origin'
alias gud='gcm && git fetch --all --prune && ggpull'
alias path='echo ${PATH} | tr ":" "\n"'
alias zshrc='${EDITOR} ~/.zshrc && zr'
alias zr='source ~/.zshrc'
alias l='exa -abghl --time-style long-iso'
alias ll='l --sort modified -r --color always | head -21'
alias C='clipcopy' #ohmyzsh builtin fuction
alias paste='clippaste' #overrides Unix paste, ohmyzsh function
alias csv='sed "s/,,/, ,/g;s/,,/, ,/g" | column -s, -t'
alias tsv='sed "s/^\t/ \t/g;s/\t\t/\t \t/g;s/\t\t/\ty\t/g" | column -s$'"'"'\t'"'"' -t'
alias trim='awk '"'"'{$1=$1};1'"'"''
alias paren='sed -e "s/^/(/" -e "s/$/)/"'
alias dq='sed -e "s/^/\"/" -e "s/$/\"/"'
alias sq='sed -e "s/^/'"'"'/" -e "s/$/'"'"'/"'
alias comma='sed "s/$/,/" | sed "$ s/.$//"'
alias pline='echo "$(clippaste | wc -l) lines on clipboard"'
alias sqlstr='clippaste | sq | comma | clipcopy && pline'
alias sqlint='clippaste | comma | clipcopy && pline'
alias sqlwith='clippaste | sq | paren | comma | clipcopy && pline'
alias sqlwithint='clippaste | paren | comma | clipcopy && pline'
alias cs='clippaste | sort -n | clipcopy && pline'
alias csu='clippaste | sort -n | uniq | clipcopy && pline'
alias brew='HOMEBREW_NO_AUTO_UPDATE=1 brew'


##MAC Specific
alias apfix='sudo killall -9 AirPlayUIAgent && sudo killall -9 AirPlayXPCHelper'
alias gggpush='ggpush && play girls_generation_gee 3'
alias 1738='play 1738_trap_queen'
alias bhd='play black_hawk_down'
alias bieb='play baby_opening'
alias blast='play instant_rap_air_horn'
alias boo='play boo'
alias cantina='play star_wars_cantina_music'
alias cmo='play cash_me_outside 7'
alias dv='play star_wars_imperial_march'
alias forge='play what_is_the_forge'
alias galva='play galva_pronunciation'
alias hsf='play hawaiian_shirt_friday'
alias keke='play drake_in_my_feelings_hook'
alias lol='play laugh_track'
alias shut='play jack_black_listen_to_my_order'
alias standup='play stand_up'
alias ting='play roadman_shaq_gun_sound_freestyle'
alias train='play chugga'
alias vin='play dashboard_confessional_vindicated_hook'
alias walk='play midnight_cowboy_im_walkin_here'

alias pc='open -a pycharm "$(git rev-parse --show-toplevel || echo ".")"'
alias st='open -a sourcetree "$(git rev-parse --show-toplevel || echo ".")"'

##Ubuntu Specific
alias opn='gnome-open .' > /dev/null 2>&1
