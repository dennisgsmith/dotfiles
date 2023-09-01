#!/bin/bash

curl -sL https://mskelton.github.io/termicons/termicons.ttf -o ~/Library/Fonts/termicons.ttf

brew install \
	wezterm \
	nvim \
	direnv \
	coreutils \
	curl \
	git

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

exec $SHELL

