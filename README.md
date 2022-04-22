# Dotfiles

Managing my personal Dotfiles using [Chezmoi](https://www.chezmoi.io/).

## Bitwarden

### Saving keys

Add a item & attachemnt via the UI.  All files are saved as attachments in the 'chezmoi' folder in BW.

BW item id's can be listed by below for adding into chezmoi config. (for example, finding id_ed files)
```
bw list items | jq '.' | grep --color --color id_ed -B10 -A10
```