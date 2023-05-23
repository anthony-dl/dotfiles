#!/bin/bash

sudo apt-get install xclip

PROJECT_DIR=$(pwd)
MAIN_PATH=$PROJECT_DIR/clipboard.py

# chmod +x $MAIN_PATH
APPENDED_PATH="PATH=\"$(echo $PROJECT_DIR):\$PATH\""
CMD="export $APPENDED_PATH"

if ! grep -qF "$CMD" ~/.bashrc;  then
    echo "Appending to .bashrc $MAIN_PATH"
    echo $(echo $CMD) >> ~/.bashrc
else
    echo "The command already exists in the .bashrc file"
fi

# change mode so that the main file can be called from anywhere
chmod +x $MAIN_PATH
chmod +x $MAIN_PATH
source ~/.bashrc
