function yeet --description 'removes package'
    if count $argv > /dev/null
        {$AUR_HELPER} -Rns $argv
    else
        echo "Error - Argument needed (Usage: yeet packagename)"
    end
end
    