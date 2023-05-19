# dotfiles
This repo contains several configuration files for some programs and software in Linux such Emacs, tmux, terminal, etc.
## Emacs
Serveral changes have been made to original emacs, including the following key-bindings:

	 - Backward delete character: Ctrl + h (previously is the shortcut for help)
	 
	 - Backward kill word: M-x + h
	 
Python IDE on emacs? I have also configured Emacs to become a lightweight yet powerful IDE with incredible code suggestions. In addition, code formaters such as flake8 and blacken are also integrated. The shortcut for formatting code with blaken in Emacs is ```C-c c```

## Tmux
Primarily re-bind the ```Ctrl+b``` to ```Ctrl+q``` to avoid confliction with the ```Ctrl+b``` in the Linux terminal and Emacs which does the backward move.

## Terminal Theme
You can customzing your terminal theme and export it to another Linux machine with:
```bash
dconf load /org/gnome/terminal/legacy/profiles:/ < custom_terminal_theme.txt
```