;;; -*- lexical-binding: t -*-
(loadf "components/elpaca.el")

(setq-default
 shift-select-mode t
 kill-whole-line t ; kill-line not leaves blank line
 save-interprogram-paste-before-kill t ;не перезаписывать внешний буфер при kill/yank
 scroll-conservatively most-positive-fixnum ; scroll line-by-line
 auto-save-mode nil
 auto-save-default nil
 make-backup-files nil
 create-lockfiles nil
 visible-bell 1
 idle-update-delay 0.5
 ring-bell-function 'ignore
 read-extended-command-predicate #'command-completion-default-include-p
 highlight-nonselected-windows nil
 scroll-conservatively 101
 fast-but-imprecise-scrolling t
 text-mode-ispell-word-completion nil
 inhibit-compacting-font-caches nil
 gc-cons-percentage 0.6
 vc-follow-symlinks t
 gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"
 default-input-method "russian-computer"
 truncate-lines t
 tab-width 4
 fill-column 80
 create-lockfiles nil
 make-backup-files nil
 use-short-answers t
 recentf-save-file (concat user-emacs-directory "components/recentf.el"))

(savehist-mode)
(global-hl-line-mode)
(delete-selection-mode 1) ; allows to delete selected text by any key
(modify-syntax-entry ?- "w") ; - is not separating "word"

(setq-default gamegrid-glyph-height-mm 10.0)    ; bigger scale in tetris
(setq-default completion-auto-help nil) ; disabling built-in completion popups
(setq-default indent-tabs-mode nil)

(defun increment-number-at-point ()
  "Increment number at pos"
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+") (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun decrement-number-at-point ()
  "Decrement number at pos"
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+") (error "No number at point"))
  (replace-match (number-to-string (1- (string-to-number (match-string 0))))))

(bind-key "H-p"   'increment-number-at-point)
(bind-key "H-M-p" 'decrement-number-at-point)
  ;; (setq initial-buffer-choice "~/")

(with-eval-after-load 'cc-mode
  (add-to-list 'c-default-style '(c-mode . "linux"))
  (add-to-list 'c-default-style '(c++-mode .  "linux")))

(defalias 'typescript-mode 'typescript-ts-mode)

(use-package orderless
 :defer t
 :custom
 (completion-styles '(orderless basic))
 (completion-category-defaults nil)
 (completion-category-overrides
  '((file (styles basic partial-completion)))))

(use-package consult
  :bind
  ("C-s"	. 'consult-line)
  ("C-s"	. 'consult-line)
  ("C-x b"	. 'consult-buffer)
  ("C-x C-b"	. 'consult-buffer-other-window))

(use-package eglot
    :hook (tsx-ts-mode . eglot-ensure)
    :custom
    (eglot-code-action-indications '(left-fringe))
    (eglot-workspace-configuration
     '(:typescript
       (:preferences
        ( :includeCompletionsForModuleExports t
          :includeCompletionsWithSnippetText t
          :includeInlayParameterNameHints "none"
          :includeInlayParameterNameHintsWhenArgumentMatchesName nil
          :includeInlayFunctionParameterTypeHints nil
          :includeInlayVariableTypeHints nil
          :includeInlayPropertyDeclarationTypeHints nil
          :includeInlayFunctionLikeReturnTypeHints nil
          :includeInlayEnumMemberValueHints nil
          ))))
    :config
    (add-to-list 'eglot-server-programs
                 '((tsx-ts-mode typescript-ts-mode) .
                   ("rass" "--"
                    "typescript-language-server" "--stdio" "--"
                    "unocss-language-server" "--stdio"
                    )))
   )
;; "vscode-eslint-language-server" "--stdio" "--"

  ;; (use-package eglotx
  ;;   :ensure (:host github :repo "cxa/eglotx")
  ;;   :after eglot
  ;;   :demand t
  ;;   :config (eglotx-presets-mode 1))

  (use-package sideline
    :hook (eglot-server-initialized . sideline-mode))
    ;; :custom (sideline-backends-right '(sideline-flymake)))

  ;; (use-package sideline-flymake)

  (use-package eldoc-box
    :hook (eglot-managed-mode . eldoc-box-hover-mode)
    :custom
    (eldoc-box-max-pixel-width  400)
    (eldoc-box-max-pixel-height 300)
    (eldoc-box-only-multi-line t)
    (eldoc-box-clear-with-C-g t))

(use-package flycheck
  :hook (c++-ts-mode)
  :custom
  (flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-indication-mode 'right-fringe))

(use-package flycheck-posframe
  :after flycheck
  :hook (flycheck-mode)
  :custom
  (flycheck-posframe-position 'point-bottom-left-corner)
  (flycheck-posframe-border-width 2))

(use-package treesit
  :ensure nil) ;; use built-in

(use-package corfu
  :disabled
  :defer t
  :hook ((prog-mode org-mode) . corfu-mode)
  :config
  (set-face-attribute
   'corfu-border nil
   :background "cyan")
  :custom
  (tab-always-indent 'complete)
  (corfu-auto t)
  (corfu-auto-delay 0.3)
  (corfu-auto-prefix 2)
  (corfu-preselect 'prompt)
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match t)
  (corfu-quit-on-exact-match nil)
  (corfu-popupinfo-mode t)
  (corfu-popupinfo-hide nil)
  (corfu-popupinfo-delay '(3.0 . 0.6))
  :bind
  (("M-SPC" . #'completion-at-point)
   :map corfu-map
   ("TAB"   . 'corfu-insert)
   ("<tab>" . 'corfu-insert)
   ("C-j"   . 'corfu-next)
   ("C-k"   . 'corfu-previous)
   ("C-i"   . 'corfu-popupinfo-toggle)))

(use-package company
  :init (setq tab-always-indent 'complete)
  :hook ((prog-mode org-mode) . company-mode)
  :custom
  (company-frontends ; I don't like docstring in echo
   '(company-childframe-unless-just-one-frontend
     company-echo-metadata-frontend
     company-preview-if-just-one-frontend))
  :bind
  (:map
   company-active-map
   ([remap next-line] . 'company-select-next-or-abort)
   ([remap previous-line] . 'company-select-previous-or-abort)
   ("<f1>" . nil)
   ("C-n" . nil)
   ("C-p" . nil)
   ))

(use-package project
  :custom
  (project-list-file
   (concat user-emacs-directory "components/projects")))

(use-package vundo
  :bind
  (("H-u" . vundo)
   :map vundo-mode-map
   ([remap next-line]         . vundo-next)
   ([remap forward-char]      . vundo-forward)
   ([remap backward-char]     . vundo-backward)
   ([remap previous-line]     . vundo-previous)
   ([remap beginning-of-line] . vundo-goto-first-saved)))

(use-package cape
  :after corfu
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package yasnippet
  :bind
  (:map yas-minor-mode-map
   ("TAB" . nil))
  :hook (prog-mode . yas-minor-mode))

(use-package yasnippet-snippets :after yasnippet)

(use-package yasnippet-capf
  :after cape
  :init
  (defun strd/add-yas-capf ()
    "Add `yasnippet-capf' to capf functions."
    (add-to-list 'completion-at-point-functions #'yasnippet-capf))
  :hook
  (emacs-lisp-mode . strd/add-yas-capf))

(use-package jinx
  :custom
  (jinx-languages "ru_RU en_US")
  :bind
  ("M-$" . jinx-correct)
  ("C-M-$" . jinx-languages ))

(use-package apheleia
  :hook (prog-mode))

(use-package multiple-cursors
  :custom
  (mc/list-file
   (concat user-emacs-directory "components/mc-lists.el"))
  :bind
  ("H-j" . 'mc/mark-next-lines)
  ("H-k" . 'mc/mark-previous-lines)
  ("H-m m" . 'mc/edit-lines))

(use-package move-text
  :bind
  ("C-M-k" . 'move-text-up)
  ("C-M-j" . 'move-text-down))

(use-package prettier-js
  :disabled
  :if window-system
  :hook ((tsx-ts-mode css-ts-mode) . prettier-js-mode))

(add-hook 'prog-mode-hook (lambda () (column-number-mode +1)))
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'electric-pair-local-mode)
;; (add-hook 'tsx-ts-mode ;; inside tsx-ts-mode for - char support (in corfu)
		  ;; (lambda () (modify-syntax-entry ?- "w")))

(use-package magit
  :commands (magit)
  :defer t
  :bind
  (:map magit-file-section-map
        ("C-j" . 'magit-next-line)))

(use-package vterm
  :init
  (add-hook 'vterm-mode-hook (lambda () (hl-line-mode -1)))
  :bind 
  ("H-<return>" . 'vterm)
  ("C-x C-<return>" . 'vterm-other-window))

(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t)
  :ensure t)
  ;; :config


;;   (add-to-list 'markdown-code-lang-modes '("javascript" . js-ts-mode))
;;   (add-to-list 'markdown-code-lang-modes '("js" . js-ts-mode)))
    ;; :mode ("README\\.md\\'" . gfm-mode)
    ;; :init (setq markdown-command "multimarkdown")
    ;; :bind
    ;; (:map markdown-mode-map
;;   ;; Перенаправляем синтаксис на ts-режимы
          ;; ("C-c C-e" . markdown-do)))

(use-package dired
  :ensure nil
  :bind
  (:map
   dired-mode-map
   ("C-o" . nil)
   ("C-c o" . 'dired-display-file))
  :custom
 (dired-kill-when-opening-new-dired-buffer t))

(use-package org
  :ensure nil
  :defer t
  :bind
  (:map
   org-mode-map
   ("C-j" . nil))
  :config
  (set-face-attribute 'org-level-1 nil :height 1.5)
  (set-face-attribute 'org-level-2 nil :height 1.3)
  (set-face-attribute 'org-level-3 nil :height 1.1)
  (set-face-attribute 'org-document-title nil :height 1.7))

(use-package toc-org
  :hook (org-mode))

(use-package org-auto-tangle
  :hook (org-mode))

(use-package treemacs
    :bind
    (("C-z" . 'treemacs)
     ("H-SPC" . 'treemacs-select-window))
    (:map
     treemacs-mode-map
     ("C-j" . 'treemacs-next-line)
     ("C-k" . 'treemacs-previous-line))
    :config
    (treemacs-filewatch-mode t)
    (treemacs-git-mode 'deferred)
    (treemacs-project-follow-mode t)
    :custom
    (treemacs-follow-after-init nil)
    (treemacs-expand-after-init nil)
    (treemacs-indent-guide-mode t)
    (treemacs-nerd-icons-tab " ")
    (display-line-numbers nil)
    (treemacs-fringe-indicator-mode 'only-when-focused)
    (treemacs-is-never-other-window t))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package treemacs-nerd-icons
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-buffer-encoding nil) ; убрать индикатор кодировки
  (doom-modeline-hud t) ; добавляет индикатор скроллинга слева
  (doom-modeline-bar-width 4) ; ширина этого индикатора
  (doom-modeline-unicode-fallback t)
  (doom-modeline-minor-modes nil)
  (doom-modeline-indent-info nil)
  (doom-modeline-position-column-line-format '("%2l:%2c"))
  (doom-modeline-position-column-format '("%c"))
  (doom-modeline-position-line-format '("%2l")))
  ;; :config
  ;; (add-hook
  ;;  'elpaca-after-init-hook
  ;;  (lambda ()
  ;;    (setq-local
  ;;     mode-line-format nil
  ;;     default-directory
  ;;     (concat (getenv "HOME") "/")))))

(use-package keycast
  :commands keycast-mode
  :config
  (define-minor-mode keycast-mode
    "Show Current command and its key binding in the mode line (fix for use with `doom-modeline')."
    :global t
    (if keycast-mode
        (progn
          (add-to-list 'global-mode-string '("" keycast-mode-line " "))
          (add-hook 'pre-command-hook 'keycast--update t)
          (add-hook 'minibuffer-exit-hook 'keycast--minibuffer-exit t))
      (setopt global-mode-string (delete '("" keycast-mode-line " ") global-mode-string))
      (remove-hook 'pre-command-hook 'keycast--update)
      (remove-hook 'minibuffer-exit-hook 'keycast--minibuffer-exit))))

(use-package pulsar
  :init
  (pulsar-global-mode 1))

(use-package nerd-icons
  :custom
  (nerd-icons-font-family "Symbols Nerd Font"))

(use-package nerd-icons-corfu
  :after (corfu nerd-icons)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-completion
  :after (marginalia nerd-icons)
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-dired
  :after (nerd-icons nerd-icons)
  :hook (dired-mode))

(use-package colorful-mode
  :hook (prog-mode help-mode)
  :custom (colorful-highlight-in-comments t))

(use-package indent-bars
  :hook
  (prog-mode .
             indent-bars-mode)
  :custom
  (indent-bars-color '(highlight :face-bg t :darken t))
  (indent-bars-highlight-current-depth '(:face cursor :face-bg t :blend 0.7))
  (indent-bars-ts-highlight-current-depth '(no-inherit)) ; equivalent to nil
  (indent-bars-pattern ".")
  (indent-bars-width-frac 0.1)
  (indent-bars-pad-frac 0.1)
  (indent-bars-display-on-blank-lines t)
  (indent-bars-treesit-ignore-blank-lines-types '("module"))
  (indent-bars-no-descend-lists 'skip)
  (indent-bars-treesit-support t)
  (indent-bars-zigzag nil)
  (indent-bars-starting-column 1)
  (indent-bars-color-by-depth nil)
  (indent-bars-starting-column 1)
  
  (indent-bars-treesit-wrap '((c argument_list parameter_list init_declarator parenthesized_expression))))

(use-package rainbow-delimiters
  :hook ((prog-mode help-mode org-mode)))

(use-package kusanagi-theme
  :disabled
  :ensure (:host github :repo "LionyxML/kusanagi-theme")
  :config (load-theme 'kusanagi t))

(use-package catppuccin-theme
  :init (setq catppuccin-flavor 'frappe)
  :config (load-theme 'catppuccin t))

(use-package hydra
  :config
  (defhydra resize-window (:color red :hint nil)
    "
Window size
------------------------------------------
_H-l_: + horizontally      _=_: 50/50
_H-h_: - horizontally      _-_: Minimum height
_H-k_: + vertically	    
_H-j_: - vertically
"
    ("H-l" enlarge-window-horizontally)
    ("H-h" shrink-window-horizontally)
    ("H-k" enlarge-window)
    ("H-j" shrink-window)
    ("="  balance-windows)
    ("-"  shrink-window-if-larger-than-buffer)
    )
  (bind-key "C-x o"   'resize-window/body)
  )

(use-package vertico
  :init (vertico-mode)
  :bind
  (:map vertico-map
		("C-j". nil)))

(use-package marginalia
  :after vertico
  :requires vertico
  :init (marginalia-mode))

(use-package dashboard
  :if window-system
  :custom
  (dashboard-startup-banner 'logo)
   ;; (concat user-emacs-directory "components/greetings3.txt"))
  (dashboard-icon-type 'nerd-icons)
  (dashboard-center-content t)
  (dashboard-set-file-icons t)
  (dashboard-items '((recents . 5) (projects . 3)))
  (dashboard-startupify-list
   '(dashboard-insert-banner
     dashboard-insert-init-info
     dashboard-insert-items))
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (add-hook 'dashboard-after-initialize-hook (lambda () (setq default-directory "~/")))
  (dashboard-setup-startup-hook))
  ;; (set-face-attribute 'dashboard-text-banner nil :width 'extra-expanded))

(use-package which-key
  :init (which-key-mode)
  :custom
  (which-key-sort-order #'which-key-key-order-alpha)
  (which-key-sort-uppercase-first nil)
  (which-key-add-column-padding 4)
  (which-key-max-display-columns 4)
  (which-key-min-display-lines 10)
  (which-key-side-window-max-height 0.5)
  (which-key-idle-delay 1.5)
  (which-key-max-description-length 30)
  (which-key-allow-imprecise-window-fit nil)
  (which-key-separator " ⊳ "))

(use-package ace-window
  :bind ("C-o" . 'ace-window))

(use-package general
  :config
  (general-def
	:keymaps 'global-map
	"C-j"           'next-line
	"C-k"           'previous-line
	"C-h"           'backward-char
	"C-l"           'forward-char
	"C-p"           'scroll-down-command
	"C-n"           'scroll-up-command
	"M-l"           'forward-word
	"M-h"           'backward-word
	"C-M-l"         'forward-sexp
	"C-M-h"         'backward-sexp
	"C-;"           'kill-line
	"K"             'self-insert-command
	"M-b"           'help-command
	"M-RET"         'duplicate-line
	"S-RET"         'open-line
	"C-x C-u"       'undo   ;; ребинд, ибо отпускать ctrl заёбывает
	"C-H-n"         'scroll-other-window
	"C-H-p"         'scroll-other-window-down
	"M-RET"         'duplicate-line
	"S-<return>"    'open-line
	"M-b"            nil
	"M-b"            nil
	"M-f"            nil
	"C-M-f"          nil
	"C-M-b"          nil
	"C-x u"          nil
	"C-x C-o"        nil
	"C-x +"          nil
	"C-x -"          nil
	"C-x <"          nil
	"C-x >"          nil
	"C-x C-d"        nil
	"C-x C-<left>"   nil
	"C-x C-<right>"  nil)
  
  (general-def
	:keymaps 'help-map
	:prefix-map 'help-map
	:prefix "<f1>"
	"I" nil
	"K" '(describe-keymap :wk "Keymap")
	"k" '(describe-key    :wk "KEY"))

  (bind-key "<H-tab>" (lambda () (interactive) (insert-char ?\t)))
  (bind-key "C-j" 'next-line 'lisp-interaction-mode-map)
  )
