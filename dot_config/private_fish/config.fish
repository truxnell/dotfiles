set -gx KUBE_EDITOR nano
set -gx VISUAL nano
set -gx EDITOR nano
set -gx SOPS_AGE_KEY_FILE {{ .chezmoi.homeDir }}/.config/sops/age/keys.txt

if status is-interactive
    # Commands to run in interactive sessions can go here
end

if type -q thefuck
    thefuck --alias | source
end