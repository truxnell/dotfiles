# Disable fish greeting
set -g fish_greeting

# Set Editor
set -gx KUBE_EDITOR nano
set -gx VISUAL nano
set -gx EDITOR nano
set -gx AUR_HELPER paru

# Set fzf options
set -gx fzf_preview_file_cmd cat
set -gx fzf_preview_dir_cmd lsd --all --color=always

# Set SOPS age
set -gx SOPS_AGE_KEY_FILE {{ .chezmoi.homeDir }}/.config/sops/age/keys.txt

if status is-interactive
    # Commands to run in interactive sessions can go here
end

## Source thefuck
if type -q thefuck
    thefuck --alias | source
end

## Source chezmoi
if type -q chezmoi
    chezmoi completion fish | source
end

## Source custom configs
for file in $__fish_config_dir/custom.d/*.fish
    source $file
end

## Source zoxide
if type -q zoxide
    zoxide init fish | source
end
