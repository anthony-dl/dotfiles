;; .emacs

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))


;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Setup some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment
    ein                             ;; Emacs iPython Notebook
    flycheck                        ;; On the fly syntax checking
    py-autopep8                     ;; Run autopep8 on save
    blacken                         ;; Black formatting on save
    magit                           ;; Git integration
    material-theme                  ;; Theme
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ====================================
;; Basic Customization
;; ====================================

(setq inhibit-startup-message t)  ;; Hide the startup message
(load-theme 'material t)          ;; Load material theme
(global-linum-mode t)             ;; Enable line numbers globally

;; ====================================
;; DEVELOPMENT SETUP
;; ====================================
;; Enable elpy
(elpy-enable)


;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; User-Defined init.el ends here

(setq-default system-name "UMassAmherst")
(setq-default user-full-name "VuLe")

(setq-default author (concat user-full-name "@" system-name)) 
(setq-default editor (concat user-full-name "@" system-name))


;; (load-theme 'dracula t)

;; If there are no archived package contents, refresh them
;; activate all packages
;; fetch the list of packages available

;; fullscreen at startup time
(add-hook 'window-setup-hook' toggle-frame-maximized t)
;; disable menu bar at start up
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; enable electric pair mode
(electric-pair-mode 1)
;; (global-display-line-numbers-mode 1)
(show-paren-mode 1)
(global-auto-highlight-symbol-mode 1)
(global-visual-line-mode t)
(column-number-mode 1)
(setq-default fill-column 79)
;; (add-hook 'prog-mode-hook #'auto-fill-mode)

(setq inhibit-startup-message t)   ;; hide the startup message
;; (load-theme 'material t)           ;; load material theme
;; (global-linum-mode t)              ;; enable line numbers globally
(setq linum-format "%4d \u2502 ")  ;; format line number spacing

;; Allow hash to be entered 

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; set key binding for backward delete to Ctrl + J
(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-j") 'newline)
;; revert buffer by C-c r
(global-set-key (kbd "C-c r") 'revert-buffer)

;; This code section is for preventing generating ~ files
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Auto save after 10 seconds
(global-auto-revert-mode t)
(auto-save-visited-mode t)
(setq auto-save-interval 5)
(global-auto-revert-mode t)
(setq auto-revert-interval 5)

; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

(defun my-blacken-mode ()
  "Format the buffer with Black, preserving the cursor position."
  (interactive)
  (when (eq major-mode 'python-mode)
    (let ((original-position (point)))
      (blacken-buffer)
      (save-buffer)
      (goto-char original-position))))

;; Bind the custom function to a keybinding
(global-set-key (kbd "C-c c ") 'my-blacken-mode)


(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; set link for to env for python IDE
(setq python-shell-interpreter "/home/vudle/anaconda3/envs/py310/bin/python3")
(setq python-shell-interpreter-args "-i")
(require 'pyvenv)
(pyvenv-activate "/home/vudle/anaconda3/envs/py310")

(defun file-header ()
  "Add a header to Python files."
  (interactive)
  (when (not (file-exists-p buffer-file-name))
    (goto-char (point-min))
    (setq modified-time (format-time-string "%Y-%m-%d %H:%M"))
    (when (or (equal major-mode 'python-mode)
	      ;; (equal major-mode 'java-mode)
	      (equal major-mode 'c-mode))
      (insert (concat "\"\"\"\n"
		      (file-name-nondirectory buffer-file-name)
		      "\nCreated: "
		      modified-time
		      "\nAuthor: "
		      author
		      "\nLast updated: "
		      modified-time
		      "\nLast modified by: "
		      editor
		      "\nLicense: © Copyright 2022-2024, Vu Le"
		      "\nDesc:"
		      "\n\"\"\"\n\n")))
    (when (or (eq major-mode 'tex-mode)
	      (eq major-mode 'latex-mode))
      (insert (concat "%% "
		      (file-name-nondirectory buffer-file-name)
		      "\n%% Created on: "
		      modified-time
		      "\n%% Author: "
		      author
		      "\n%% Last updated: "
		      modified-time
		      "\n%% Last modified by: "
		      editor
		      "\n\n")))))

(add-hook 'write-file-functions 'file-header)

(defun insert-update-header ()
  "Insert or update header with current date and time."
  (interactive)
  (when (and buffer-file-name
             (or (equal major-mode 'python-mode)
                 (equal major-mode 'java-mode)
                 (equal major-mode 'c-mode)
                 (equal major-mode 'tex-mode)
		 (equal major-mode 'latex-mode)
		 ))
    (let ((modified-time (format-time-string "%Y-%m-%d %H:%M:%S")))
      (save-excursion
        (goto-char (point-min))
        (cond ((re-search-forward "Last updated: \\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} [0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\}\\)" nil t)
               (replace-match (concat "Last updated: " modified-time))))
	(goto-char (point-min))
	(cond ((re-search-forward "Last modified by: \\(.+\\)" nil t)
               (replace-match (concat "Last modified by: " author))))
	))))

(add-hook 'before-save-hook 'insert-update-header)

;;;;;;;;;;; LaTex configuration begins ;;;;;;;;;;
;; Install AUCTeX if not already installed
(unless (package-installed-p 'auctex)
  (package-refresh-contents)
  (package-install 'auctex))

(defun clean-latex-commands ()
  "Run bash script to remove Latex log files."
  (interactive)
  (when (or (eq major-mode 'tex-mode)
	    (eq major-mode 'latex-mode))
    (shell-command "rm -f *.out *.log *.aux *.snm *.toc *.bbl *.blg *.nav *-blx.bib *.run.xml *.synctex.gz")
    (message "Cleaned latex output log files")
    )
  )

(global-set-key (kbd "C-c C-x C-c") 'clean-latex-commands)

(defun make-latex-commands ()
  "Run a Bash script to compile pdflatex."
  (interactive)
  (when (or (eq major-mode 'tex-mode)
	    (eq major-mode 'latex-mode))
    (setq latex-file-name (file-name-nondirectory buffer-file-name))
    (setq latex-file-name (concat "" latex-file-name ""))
    (setq filename (file-name-sans-extension latex-file-name) )
  
    (shell-command (format "pdflatex -interaction=nonstopmode %s.tex" filename))
    ;; (message (buffer-name (current-buffer)))
    (when (search-forward-regexp "bibliography{" nil t)
      (message "creating bibliography")
      (shell-command (format "bibtex %s.aux" filename)))
    (when (search-forward "\\makeindex" nil t)
      (message "creating bibliography")
      (shell-command (format "makeindex %s" filename)))
    
    (shell-command (format "pdflatex -interaction=nonstopmode '%s'.tex" filename))
    (shell-command (format "pdflatex -interaction=nonstopmode '%s'.tex" filename))
    (message "Compiled PDFLaTex successfully")))

(global-set-key (kbd "C-c l") 'make-latex-commands)


(defun insert-latex-image-from-clipboard ()
  "Take and save the image taken from clipboard and insert the snippet in the current buffer."
  (interactive)
  (setq output (shell-command-to-string "clipboard.py"))
  (when (or (eq major-mode 'tex-mode)
	    (eq major-mode 'latex-mode))
    (insert output)
    (message "Inserted image and snippet from clipboard"))
  )

(global-set-key (kbd "C-c i") 'insert-latex-image-from-clipboard)

(add-hook 'LaTex-mode-hook 'flyspell-mode)
(add-hook 'TeX-mode-hook 'flyspell-mode)
