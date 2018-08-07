equalsz = '========================================================='

default:
	@ echo "Error: Please specify if you would like to import or export the config files."

import:
	cp $(HOME)/.bashrc .
	cp $(HOME)/.gitconfig .
	cp $(HOME)/.gitignore .
	cp $(HOME)/.tmux.conf .
	cp $(HOME)/.zshrc .
	cp $(HOME)/.vimrc .

push:
	@ git add --all
	@ git commit -m "*automated push message*"
	@ git push

export:
	cp .bashrc $(HOME)
	cp .gitconfig $(HOME)
	cp .gitignore $(HOME)
	cp .tmux.conf $(HOME)
	cp .zshrc $(HOME)
	cp .vimrc $(HOME)

sauce:
