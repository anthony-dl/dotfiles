if [ "$(ls -A ~/google-drive-phenikaa)" ]; then
    echo "~/google-drive-phenikaa is already mounted."
else
    echo "~/google-drive-phenikaa has been mounted."
    google-drive-ocamlfuse ~/google-drive-phenikaa/
fi


if [ "$(ls -A ~/personnal-google-drive)" ]; then
    echo "~/google-drive-phenikaa is already mounted."
else
    echo "~/personnal-google-drive has been mounted."
    google-drive-ocamlfuse -label label ~/personnal-google-drive/
fi

tmux source-file ~/.tmux.conf