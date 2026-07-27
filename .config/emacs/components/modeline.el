(defvar strd-ml-colors-alist
  '( ;color
    ;active ;inactive ;active-fg;inactive-fg
    (l1 "#fe8019" "#928374" "#ebdbb2" "#3c3836")
    (l2 "#fb4934" "#7c6f64" "#ebdbb2" "#3c3836"))
  "Modeline colors.")

(defun strd-ml-active-colors (number)
  (let ((focused (mode-line-window-selected-p)))
    (if focused number (+ number 1))))

(set-face-attribute 'mode-line nil :height 108)
(set-face-attribute 'mode-line-inactive nil :height 108)


(defvar strd-ml-icons-alist
  `((linux "")
    (emacs ,(nerd-icons-devicon "nf-dev-emacs"))
    (windows "")
    (apple "")
    ("Arch" "󰣇")
    ("Gentoo" "󰣨")
    ("Ubuntu" "󰕈")
    ("Kubuntu" "")
    ("Fedora" "󰣛")
    (err "")
    (warn "")
    (git-branch "")
    (git-added "")
    (git-modified "")
    (git-removed "")
    (ln "")
    (arr "")
    (arr-r "")
    (arr2 "")
    (arr2-r "")))

(defun strd-get-os-icon ()
  (let ((get-icon (lambda (icon) (cadr (assoc icon strd-ml-icons-alist)))))
    (if (eq system-type 'ms-dos) (funcall get-icon 'windows))
    (if (eq system-type 'darwin) (funcall get-icon 'apple)
      ;;else
      (or (ignore-errors
            (funcall get-icon (string-trim
			       (shell-command-to-string
				"lsb_release -si 2> /dev/null"))))
          (funcall get-icon 'linux)))))


(defun strd-get-icon (icon) (cadr (assoc icon strd-ml-icons-alist)))


(defun strd-ml-sep (bg fg &optional right)
  (let ((arrow (strd-get-icon (if right 'arr-r 'arr))))
    (propertize arrow 'face `(:background ,(if (eq bg nil) 'unspecified bg) :foreground ,(if (eq fg nil) 'unspecified fg)))))

(defun strd-ml-sep-2 (bg fg &optional right)
  (let ((arrow (strd-get-icon (if right 'arr2-r 'arr2))))
    (propertize arrow 'face `(:background ,(if (eq bg nil) 'unspecified bg) :foreground ,(if (eq fg nil) 'unspecified fg)))))

(defvar strd-ml-icon-spacing 1)
(defvar strd-ml-icon-space (propertize " " 'display `(min-width ,strd-ml-icon-spacing)))


(defun strd-ml-ostype (&optional level1 level2 right)
"OS logo and buffer status widget.
LEVEL1: widget's colors from 'strd-ml-colors-alist'.
LEVEL2: next widget's colors from 'strd-ml-colors-alist'.
RIGHT: separator direction."
  (let* ((read-only-icon (when buffer-read-only (concat "" strd-ml-icon-space)))
         (modified-icon (when (buffer-modified-p) (concat "" strd-ml-icon-space)))
         (os-icon (concat (strd-get-os-icon) strd-ml-icon-space))
         (colors strd-ml-colors-alist)
         (bg-col (nth (strd-ml-active-colors 1) (assoc level1 colors)))
         (fg-col (nth (strd-ml-active-colors 3) (assoc level1 colors)))
         (lnextbg-col (nth (strd-ml-active-colors 1) (assoc level2 strd-ml-colors-alist))))
    (concat (propertize (concat " " os-icon read-only-icon modified-icon)
                 'face `(:background ,bg-col :foreground ,fg-col :height 1.0))
     (propertize (strd-ml-sep lnextbg-col bg-col)
                 'face `(:background ,lnextbg-col :foreground ,bg-col :height 1.0)))))
; 

(defun strd-ml-cursor (&optional level level2 right)
  "Cursor position widget."
  (let* ((ln-icon (strd-get-icon 'ln))
         (bg-col (nth (strd-ml-active-colors 1) (assoc level strd-ml-colors-alist)))
         (fg-col (nth (strd-ml-active-colors 3) (assoc level strd-ml-colors-alist)))
         (lnextbg-col (nth (strd-ml-active-colors 1) (assoc level2 strd-ml-colors-alist)))
         (pos (format-mode-line "%o%%"))
         (short-pos
          (cond
           ((string= pos "All%") "ALL")
           ((string= pos "Bottom%") "BOT")
           ((string= pos "Top%") "TOP")
           (t pos))))
    (concat
     (strd-ml-sep lnextbg-col bg-col t)
     (propertize (concat
                  short-pos " " ln-icon (format "%%2l:%%2C") " ")
                 'face `(:foreground ,fg-col :background ,bg-col)))))

(defun strd-ml-buffer (&optional level level2 right)
  (let* ((bg-col (nth (strd-ml-active-colors 1) (assoc level strd-ml-colors-alist)))
         (fg-col (nth (strd-ml-active-colors 3) (assoc level strd-ml-colors-alist)))
         (lnextbg-col (nth 1 (assoc level2 strd-ml-colors-alist)))
         (mode (format-mode-line "%b"))
         (utility-buf (and (string-prefix-p "*" mode) (string-suffix-p "*" mode))))
    (concat (propertize (concat " "
		  (if utility-buf (strd-get-icon 'emacs) (nerd-icons-icon-for-extension mode))
                  " " mode) 'face `(:foreground ,fg-col :background ,bg-col))
     (strd-ml-sep nil bg-col right))))

(defun strd-ml-flymake-and-major-mode (&optional level level2 right)
  (let* ((bg-col (nth (strd-ml-active-colors 1) (assoc level strd-ml-colors-alist)))
         (fg-col (nth (strd-ml-active-colors 3) (assoc level strd-ml-colors-alist)))
         (lnextbg-col (nth 1 (assoc level2 strd-ml-colors-alist)))
	 (err-icon (concat (strd-get-icon 'err) strd-ml-icon-space))
	 (warn-icon (concat (strd-get-icon 'warn) strd-ml-icon-space)))
    (concat (strd-ml-sep nil bg-col right)
	    (when (and (boundp 'flymake-mode) flymake-mode)
	      (propertize (concat err-icon
			(format-mode-line flymake-mode-line-error-counter) " " warn-icon
			(substring (format-mode-line flymake-mode-line-warning-counter) 1) " " (strd-ml-sep-2 nil nil right) " ")
		'face `(:foreground ,fg-col :background ,bg-col) ))
	    (propertize (concat (symbol-name major-mode) " ") 'face `(:foreground ,fg-col :background ,bg-col)))))



(defun strd-ml-fringe-state ()
  "Compensate for left fringe displacement in mode-line right alignment.
When left fringe is visible in Emacs GUI, it shifts the entire
mode-line content to the right, causing right-aligned widgets to be truncated.
This function calculates the necessary padding based on current fringe width
and adds proportional spacing to restore proper right-side alignment.
The fringe width is divided by 10 to scale the compensation appropriately
for the mode-line context.

IMPORTANT: This function must be placed LAST in 'mode-line-format'
to ensure proper compensation for right-aligned elements."
  (let ((fringe-width (nth 0 (window-fringes))))
    (when (and (< 0 fringe-width) (display-graphic-p))
      (propertize " "
                  'display
                  `(space :width ,(/ (float fringe-width) 10))))))


(defun strd-ml-git (&optional level level2 right)
  (let* ((bg-col (nth (strd-ml-active-colors 1) (assoc level strd-ml-colors-alist)))
         (fg-col (nth (strd-ml-active-colors 3) (assoc level strd-ml-colors-alist)))
	 (warn-icon (concat (strd-get-icon 'warn) strd-ml-icon-space)))
(concat
 (format-mode-line vc-mode)
 )))


(defun simple-vc-modeline ()
  "Show Git status with change counts in modeline."
  (when (and vc-mode (eq (vc-backend buffer-file-name) 'Git))
    (let ((default-directory (vc-root-dir)))
      (when (vc-git-root default-directory)
        (let* ((branch-icon (concat (strd-get-icon 'git-branch) strd-ml-icon-space))
	       (added-icon (concat (strd-get-icon 'git-added) strd-ml-icon-space))
	       (modified-icon (concat (strd-get-icon 'git-modified) strd-ml-icon-space))
	       (removed-icon (concat (strd-get-icon 'git-removed) strd-ml-icon-space))
	       (output (shell-command-to-string "git status --porcelain"))
	       (branch (replace-regexp-in-string 
                       "\n$" "" 
                       (shell-command-to-string "git branch --show-current")))
               (lines (split-string output "\n" t))
               (modified (length (seq-filter (lambda (line) (string-match "^.M" line)) lines)))
               (added (length (seq-filter (lambda (line) (string-match "^[?A]" line)) lines)))
               (deleted (length (seq-filter (lambda (line) (string-match "^.D" line)) lines))))
          (format " %s %s%d %s%d %s%d"
		  (concat branch-icon branch)
		  added-icon added
		  modified-icon modified
		  removed-icon deleted))))))

(setq-default mode-line-format
              '((:eval (strd-ml-ostype 'l1 'l2))
                (:eval (strd-ml-buffer 'l2))
		(:eval (simple-vc-modeline))
                ;; (:eval flymake-mode-line-format)
                ;; (:eval (flymake-mode-line-counters))
                ;; (:eval (mode-line-window-selected-p))
                mode-line-format-right-align
		;; vc-mode
                (:eval (strd-ml-flymake-and-major-mode 'l2 nil t))
                ;; mode-line-modes
                (:eval (strd-ml-cursor 'l1 'l2 t))
                (:eval (strd-ml-fringe-state))))
