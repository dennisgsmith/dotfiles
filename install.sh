#!/bin/bash

curl -sL https://mskelton.github.io/termicons/termicons.ttf -o ~/Library/Fonts/termicons.ttf

brew install \
	wezterm \
	nvim

tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

echo 'export TERM=wezterm' >> $HOME/.zshrc

exec $SHELL

