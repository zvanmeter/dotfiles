# Path to your oh-my-zsh installation.
export ZSH=/Users/zvm/.oh-my-zsh

# ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=""
plugins="${plugins} battery"
plugins="${plugins} brew"
plugins="${plugins} common-aliases"
plugins="${plugins} copydir"
plugins="${plugins} debian"
plugins="${plugins} docker"
plugins="${plugins} git"
plugins="${plugins} nyan"
plugins="${plugins} osx"
plugins="${plugins} sudo"
plugins="${plugins} tmux"
plugins="${plugins} web-search"
plugins="${plugins} zsh-autosuggestions"
source ${ZSH}/oh-my-zsh.sh

PATH=""
PATH="${PATH}:${HOME}/bin"
PATH="${PATH}:/usr/local"
PATH="${PATH}:/usr/local/sbin"
PATH="${PATH}:/usr/local/bin"
PATH="${PATH}:/usr/bin"
PATH="${PATH}:/bin"
PATH="${PATH}:/usr/sbin"
PATH="${PATH}:/sbin"
export PATH
export LANG=en_US.UTF-8
export EDITOR='vim'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.

function http(){curl -s http://httpcode.info/${1} | sed -e "/\s*</d" -e "/^\s*$/d"}

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(direnv hook zsh)"

alias zshrc="${EDITOR} ~/.zshrc && zr"
alias zr='source ~/.zshrc'
alias l='ls -lAhF'
alias ll='l -tr | tail -15'
alias tmux='env TERM=screen-256color tmux'
alias C='clipcopy' #ohmyzsh builtin fuction
alias paste='clippaste' #overrides Unix paste, ohmyzsh function
alias csv='sed "s/,,/, ,/g;s/,,/, ,/g" | column -s, -t'
alias tsv='sed "s/^\t/ \t/g;s/\t\t/\t \t/g;s/\t\t/\ty\t/g" | column -s$'"'"'\t'"'"' -t'
alias sqlist='paste | awk '"'"'{print "\x27"$0"\x27,"}'"'"' | sed "$ s/.$//" | clipcopy && echo "$(paste | wc -l) lines modfied in copybuffer"'
alias sqlint='paste | awk '"'"'{print $0","}'"'"' | sed "$ s/.$//" | clipcopy && echo "$(paste | wc -l) lines modfied in copybuffer"'
alias sqlwith='paste | awk '"'"'{print "(\x27"$0"\x27),"}'"'"' | sed "$ s/.$//" | clipcopy && echo "$(paste | wc -l) lines modfied in copybuffer"'
alias cs='paste | sort -n | clipcopy && echo "$(paste | wc -l) lines modfied in copybuffer"'
alias csu='paste | sort -n | uniq | clipcopy && echo "$(paste | wc -l) lines modfied in copybuffer"'
alias trim='awk '"'"'{$1=$1};1'"'"''
alias gulp='npm run gulp'
alias jspm='npm run jspm'

funcion play(){
  fileName=${1}
  volume=${2}
  [ -n "${volume}" ] && osascript -e "set Volume ${volume}"
  (afplay "${HOME}/sound_clips/${fileName}.mp3"&)
}

##MAC Specific
alias apfix='sudo killall -9 AirPlayUIAgent && sudo killall -9 AirPlayXPCHelper'
alias gggpush='ggpush && play ggpush 3'
alias train='play chugga'
alias lol='play laugh_track'
alias boo='play boo'
alias 1738='play 1738'
alias blast='play instant_rap_air_horn'
alias forge='play what_is_the_forge'
alias walk='play walkin_here'
alias bhd='play black_hawk_down'
alias standup='play stand_up'
alias cmo='play cash_me 8'

##Ubuntu Specific
alias opn='gnome-open .' > /dev/null 2>&1
