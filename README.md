# Emacs
Edit 
# Python IDE
It works awesome.

# Latex Environments
Apart from elpy mode for python IDE, this configuration also feature AuCTex for writing beautiful LaTex documents in Emacs. To further raise the convinence when making a LaTex document, especially when it comes to inserting an image from clipboard (Screenshot for example), I additionally wrote a python script to take the image and save it in the image in the current folder that contains the main `.tex` file and insert all the snippet for it as well. To use such cool function, navigate to the [utils](../utils) folder and run `bash setup.sh` to make the python script callable from anywhere. The key-binding for this function is `C-c i`, which stands for inserting.

In addition, here are some key-bindings for using LaTex with AUCTex in Emacs:

## Changing the font
<details>
<summary>Click to expand/collapse</summary>

AUCTeX provides convenient keyboard shortcuts for inserting macros which specify the font to be used for typesetting certain parts of the text. They start with `C-c C-f`, and the last `C-` combination tells AUCTeX which font you want:

`C-c C-f C-b`: Insert bold face ‘\textbf{∗}’ text.

`C-c C-f C-i` Insert italics ‘\textit{∗}’ text.

`C-c C-f C-e` Insert emphasized ‘\emph{∗}’ text.

`C-c C-f C-s` Insert slanted ‘\textsl{∗}’ text.

`C-c C-f C-r` Insert roman \textrm{∗} text.

`C-c C-f C-f` Insert sans serif ‘\textsf{∗}’ text.

`C-c C-f C-t` Insert typewriter ‘\texttt{∗}’ text.

`C-c C-f C-c` Insert SMALL CAPS ‘\textsc{∗}’ text.

</details>

## General AUCTeX Keybindings:
<details>
<summary>Click to expand/collapse</summary>

`C-c C-n`: Next error (jump to the next error or warning)

`C-c C-p`: Previous error (jump to the previous error or warning)

`C-c C-f`: Fill paragraph (automatically format the current paragraph)

`C-c C-e`: Insert environment (prompt for an environment name and insert the corresponding environment)

`C-c C-s`: Insert sectioning command (prompt for a sectioning command and insert it)

`C-c C-m`: Insert macro (prompt for a LaTeX macro name and insert it)

`C-c C-c`: Compile (run LaTeX on the current document)

`C-c C-v`: View (open the compiled document in a PDF viewer)

`C-c C-r`: Command on region (run a LaTeX command on the selected region)

`C-c C-i`: Check and insert image (prompt for an image file name, check its existence, and insert the corresponding LaTeX code)

`C-c C-l`: Check and insert label (prompt for a label name, check for existing labels, and insert the corresponding LaTeX code)

</details>

## Math Mode Keybindings:
<details>
<summary>Click to expand/collapse</summary>

`C-c C-a`: Insert aligned environment

`C-c C-e`: Insert equation environment

`C-c C-m`: Insert math environment

`C-c RET`: Insert math macro

</details>

## Sectioning Keybindings:
`C-c C-s s`: Insert section

`C-c C-s c`: Insert chapter

`C-c C-s p`: Insert part

`C-c C-s a`: Insert appendix

## LaTeX environments
In Emacs with AUCTeX, you can use the `C-c C-e` keybinding to insert LaTeX environments, including the "figure, equation, itemize" environments. Here's how you can do it:

Press `C-c C-e` (which stands for TeX-insert-environment) and then fill all the values here such as `label, caption`