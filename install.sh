#!/bin/bash

curl -sL https://mskelton.github.io/termicons/termicons.ttf -o ~/Library/Fonts/termicons.ttf

brew analytics off

brew install \
	wezterm \
	nvim \
	direnv \
	coreutils \
	curl \
	git \
	go \
	jq \
	pnpm \
	pipx \
	gdal \
	colima \
        docker \
	docker-compose \
	docker-credential-helper \
	docker-buildx \
	awscli \
	pandoc \
	ripgrep \
	libpq \
	delve \
	lazydocker \
	lazygit

brew install --cask aws-vault
brew link --force libpq

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

exec $SHELL

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

asdf plugin add python https://github.com/danhper/asdf-python.git
asdf install python 3.11.5
asdf global python system

pipx ensurepath

mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn /opt/homebrew/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx

npm install -g quicktype
