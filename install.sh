#!/bin/sh

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
	bin_dir="$HOME/.local/bin"
	if [ "$(command -v curl)" ]; then
		sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
	elif [ "$(command -v wget)" ]; then
		sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
	else
		echo "To install chezmoi, you must have curl or wget installed." >&2
		exit 1
	fi
fi

sudo rpm --import 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key'
curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/config.rpm.txt' | sudo tee /etc/yum.repos.d/doppler-cli.repo
sudo yum update && sudo yum install doppler
