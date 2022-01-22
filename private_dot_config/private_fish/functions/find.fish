function ff --description 'find a file in current directory recursively'
    if count $argv > /dev/null
        find . -type f -name '$argv'
    else
        echo "Missing argument - Usage: ff filename"
    end
end
