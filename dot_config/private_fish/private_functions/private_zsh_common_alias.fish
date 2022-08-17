# converted from 
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-abbres/common-abbres.plugin.zsh

# ls, the common ones I use a lot shortened for rapid fire usage
if type -q lsd
    abbr l 'lsd -lF'     #size,show type,human readable
    abbr la 'lsd -lAF'   #long list,show almost all,show type,human readable
    abbr lr 'lsd -tRF'   #sorted by date,recursive,show type,human readable
    abbr lt 'lsd -ltF'   #long list,sorted by date,show type,human readable
    abbr ll 'lsd -l'      #long list
    abbr ldot 'lsd -ld .*'
    abbr lS 'lsd -1FSs'
    abbr lart 'lsd -1Fcart'
    abbr lrt 'lsd -1Fcrt'
    abbr lsr 'lsd -lARF' #Recursive list of files and directories
    abbr lsn 'lsd -1'     #A column contains name of files and directories
else
    abbr l 'ls -lFh'     #size,show type,human readable
    abbr la 'ls -lAFh'   #long list,show almost all,show type,human readable
    abbr lr 'ls -tRFh'   #sorted by date,recursive,show type,human readable
    abbr lt 'ls -ltFh'   #long list,sorted by date,show type,human readable
    abbr ll 'ls -l'      #long list
    abbr ldot 'ls -ld .*'
    abbr lS 'ls -1FSsh'
    abbr lart 'ls -1Fcart'
    abbr lrt 'ls -1Fcrt'
    abbr lsr 'ls -lARFh' #Recursive list of files and directories
    abbr lsn 'ls -1'     #A column contains name of files and directories

end

abbr grep 'grep --color'
abbr sgrep 'grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

abbr t 'tail -f'

# Command line head / tail shortcuts
abbr -g H '| head'
abbr -g T '| tail'
abbr -g G '| grep'
abbr -g L "| less"
abbr -g M "| most"
abbr -g LL "2>&1 | less"
abbr -g CA "2>&1 | cat -A"
abbr -g NE "2> /dev/null"
abbr -g NUL "> /dev/null 2>&1"
abbr -g P "2>&1| pygmentize -l pytb"

abbr dud 'du -d 1 -h'
abbr duf 'du -sh *'
abbr ff 'find . -type f -name'

abbr h 'history'
abbr hgrep "fc -El 0 | grep"
abbr help 'man'
abbr p 'ps -f'
abbr sortnr 'sort -n -r'
abbr unexport 'unset'

abbr rm 'rm -i'
abbr cp 'cp -i'
abbr mv 'mv -i'