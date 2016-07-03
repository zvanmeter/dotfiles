eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias zr='source ~/.zshrc'
alias l='ls -lAhF'
alias ll='l -tr'
alias tmux='env TERM=screen-256color tmux'
alias opn='gnome-open .' > /dev/null 2>&1
alias clip='clipcopy' #ohmyzsh builtin fuction
alias paste='clippaste' #overrides Unix paste, ohmyzsh function
alias csv='sed "s/,,/, ,/g;s/,,/, ,/g" | column -s, -t'
alias tsv='sed "s/^\t/ \t/g;s/\t\t/\t \t/g;s/\t\t/\ty\t/g" | column -s$'"'"'\t'"'"' -t'
alias sqlist='paste | awk '"'"'{print "\x27"$0"\x27,"}'"'"' | sed "$ s/.$//" | clip && echo
"$(paste | wc -l) lines modfied in copybuffer"'
alias sqlint='paste | awk '"'"'{print $0","}'"'"' | sed "$ s/.$//" | clip && echo "$(paste | wc
-l) lines modfied in copybuffer"'

my_zsh_plugins=(common-aliases git sudo web-search debian tmux nyan copydir osx)

##MAC Specific
alias apfix='sudo killall -9 AirPlayUIAgent && sudo killall -9 AirPlayXPCHelper'
alias gggpush='ggpush && afplay "$HOME/sound_clips/ggpush.mp3"'

##Ubuntu Specific
alias opn='gnome-open .' > /dev/null 2>&1
