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


##MAC Specific
alias apfix='sudo killall -9 AirPlayUIAgent && sudo killall -9 AirPlayXPCHelper'
alias gggpush='ggpush && osascript -e "set Volume 3" && (afplay "${HOME}/sound_clips/ggpush.mp3"&)'
alias train='osascript -e "set Volume 3" && (afplay "${HOME}/sound_clips/chugga.mp3"&)'
alias lol='afplay "${HOME}/sound_clips/laugh_track.mp3"'
alias boo='afplay "${HOME}/sound_clips/boo.mp3"'
alias 1738='afplay "${HOME}/sound_clips/1738.mp3"'
alias blast='afplay "${HOME}/sound_clips/instantrapairhorn.mp3"'
alias forge='afplay "${HOME}/sound_clips/what_is_the_forge.mp3"'
alias walk='afplay "${HOME}/sound_clips/walkin_here.mp3"'
alias bhd='afplay "${HOME}/sound_clips/black_hawk_down.mp3"'
alias standup='afplay "${HOME}/sound_clips/stand_up.mp3"'
alias cmo='osascript -e "set Volume 8" && (afplay "${HOME}/sound_clips/cash_me.mp3"&)'

##Ubuntu Specific
alias opn='gnome-open .' > /dev/null 2>&1
