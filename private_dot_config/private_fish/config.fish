# Disable fish greeting
set -g fish_greeting

# Set Editor
set -gx KUBE_EDITOR nano
set -gx VISUAL nano
set -gx EDITOR nano
set -gx AUR_HELPER paru

# Set SOPS age
set -gx SOPS_AGE_KEY_FILE {{ .chezmoi.homeDir }}/.config/sops/age/keys.txt

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Enable thefuck
if type -q thefuck
    thefuck --alias | source
end

## Source custom configs
for file in $__fish_config_dir/custom.d/*.fish
    source $file
end