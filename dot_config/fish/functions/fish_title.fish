
function fish_title
    # emacs is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS
        echo (status current-command) (prompt_pwd)
    end
end
