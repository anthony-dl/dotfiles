#!/usr/bin/python3
from PIL import ImageGrab
import os
from pathlib import Path
import glob
import re


def increment_path(path, exist_ok=False, sep="", mkdir=False):
    path = Path(path)
    if path.exists() and not exist_ok:
        path, suffix = (
            (path.with_suffix(""), path.suffix) if path.is_file() else (path, "")
        )
        dirs = glob.glob(f"{path}{sep}*")  # similar paths
        matches = [re.search(rf"%s{sep}(\d+)" % path.stem, d) for d in dirs]
        i = [int(m.groups()[0]) for m in matches if m]  # indices
        n = max(i) + 1 if i else 2
        path = Path(f"{path}{sep}{n}{suffix}")  # increment path
    if mkdir:
        path.mkdir(parents=True, exist_ok=True)  # make directory
    return path


try:
    image = ImageGrab.grabclipboard()
    os.makedirs("clipboard", exist_ok=True)
    path = "clipboard/image.png"
    path = increment_path(path)
    if image is None:
        print("No image found on the clipboard")
    else:
        image.save(path)
        snippet = (
            r"\begin{figure}[htbp]"
            + "\n \t \centering"
            + f"\n \t \includegraphics[width=\linewidth]{{{path}}}"
            + "\n \t \caption{a nice plot}"
            + "\n \t \label{fig:fig}"
            + "\n \end{figure}"
        )
        print(snippet)
except:
    pass
