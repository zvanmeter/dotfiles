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
  copydir
  copyfile
  docker
  fasd
  git
  osx
  sudo
  web-search
)
source "${ZSH}/oh-my-zsh.sh"

path=(
  "${HOME}/bin"
  /usr/local
  /usr/local/sbin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  "${HOME}/go/bin"
)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.

eval "$(direnv hook zsh)"
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/etc/profile.d/z.sh

alias path='echo ${PATH} | tr ":" "\n"'
alias zshrc='${EDITOR} ~/.zshrc && zr'
alias zr='source ~/.zshrc'
alias l='exa -abghl --time-style long-iso'
alias ll='l --sort modified -r --color always | head -21'
alias tmux='env TERM=screen-256color tmux'
alias C='clipcopy' #ohmyzsh builtin fuction
alias paste='clippaste' #overrides Unix paste, ohmyzsh function
alias csv='sed "s/,,/, ,/g;s/,,/, ,/g" | column -s, -t'
alias tsv='sed "s/^\t/ \t/g;s/\t\t/\t \t/g;s/\t\t/\ty\t/g" | column -s$'"'"'\t'"'"' -t'
alias trim='awk '"'"'{$1=$1};1'"'"''
alias gulp='npm run gulp'
alias jspm='npm run jspm'
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
unalias fd

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

##MAC Specific
alias apfix='sudo killall -9 AirPlayUIAgent && sudo killall -9 AirPlayXPCHelper'
alias gggpush='ggpush && play girls_generation_gee 3'
alias 1738='play 1738_trap_queen'
alias bhd='play black_hawk_down'
alias bieb='play baby_opening'
alias blast='play instant_rap_air_horn'
alias boo='play boo'
alias cantina='play star_wars_cantina_music'
alias chant='play tibetan_monk_chant'
alias cmo='play cash_me_outside 7'
alias dv='play star_wars_imperial_march'
alias forge='play what_is_the_forge'
alias herd='play swedish_cattle_herding_call'
alias hsf='play hawaiian_shirt_friday'
alias lol='play laugh_track'
alias standup='play stand_up'
alias train='play chugga'
alias walk='play midnight_cowboy_im_walkin_here'
alias halo='play halo_title_theme'
alias ting='play roadman_shaq_gun_sound_freestyle'
alias rg='play eminem_rap_god'
alias shut='play jack_black_listen_to_my_order'
alias galva='play galva_pronunciation'

alias pc='open -a pycharm "$(git rev-parse --show-toplevel || echo ".")"'
alias st='open -a sourcetree "$(git rev-parse --show-toplevel || echo ".")"'

##Ubuntu Specific
alias opn='gnome-open .' > /dev/null 2>&1
