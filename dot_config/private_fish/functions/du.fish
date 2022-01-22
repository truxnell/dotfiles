# Largely ripped from https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
function dud --description 'size of directories in this folder'
    du -d 1 -h
end

function duf --description 'size of files and dirs in this folder'
    du -sh *
end