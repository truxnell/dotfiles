# Dotfiles

Managing my personal Dotfiles using [Chezmoi](https://www.chezmoi.io/).

## Bitwarden

### Saving keys

Add item & fiel attachment to bitwarden.  Item id's can be found by the below grep (after logging in)
```
bw list items | jq '.' | grep --color --color id_ed -B10 -A10
```