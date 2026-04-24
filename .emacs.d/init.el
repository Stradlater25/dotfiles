(loadf "components/elpaca.el")

(savehist-mode)
(global-hl-line-mode 1)
(delete-selection-mode 1) ; allows to delete selected text by any key
(setq kill-whole-line t ; kill-line not leaves blank line
      read-extended-command-predicate #'command-completion-default-include-p
      text-mode-ispell-word-completion nil)
;; (set-frame-parameter nil 'alpha-background 95)
(setq-default save-interprogram-paste-before-kill t ;не перезаписывать внешний буфер при kill/yank
    	      scroll-conservatively most-positive-fixnum ; scroll line-by-line
    	      auto-save-mode nil
     	      auto-save-default nil
	      make-backup-files nil
     	      create-lockfiles nil
    	      visible-bell 1
  	      ring-bell-function 'ignore)
(setq initial-buffer-choice "~/")
(add-to-list 'exec-path (concat (getenv "HOME") "/.local/share/pnpm"))
;; idk why that mess doin' here, but I'll just left it here
;; (setenv "PATH" (concat "/home/stradlater/" ".venv/bin" ":" (getenv "PATH")))

(use-package general
  :ensure t
  :config (loadf "components/general.el"))
(elpaca-wait)

(use-package orderless
 :defer t
 :custom
 (completion-styles '(orderless basic))
 (completion-category-defaults nil)
 (completion-category-overrides
  '((file (styles basic partial-completion)))))

(use-package sudo-edit)

(use-package consult
  :general
  (:keymaps 'global-map
	    "C-s" 'consult-line
	    "C-s" 'consult-line
	    "C-x b" 'consult-buffer
	    "C-x C-b" 'consult-buffer-other-window))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  (c++-mode lsp-deferred)
  (pythoh-ts-mode lsp-deferred)
  (c-mode lsp-deferred)
  (tsx-ts-mode lsp-deferred)
  (cmake-ts-mode lsp-deferred)
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-idle-delay 0.3)
  (lsp-log-io nil)
  (lsp-completion-provider :none)
  (lsp-inlay-hint-enable t)
  (lsp-modeline-diagnostics-enable t)
  (lsp-modeline-code-actions-enable t)
    ;; Breadcrumb (путь к символу вверху буфера)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  ;; cause we use prettier
  (lsp-enable-on-type-formatting nil)
  (lsp-cmake-server-command '("/home/stradlater/.cargo/bin/neocmakelsp" "stdio"))
  :config
  (lsp-enable-which-key-integration t)
  )

(use-package lsp-ui
  :after lsp-mode
  :config
  (set-face-attribute  'lsp-ui-sideline-global nil;; иначе уёбищный шрифт будет
		       :family "Iosevka NF" )
  (set-face-attribute 'lsp-ui-doc-background nil
		      :background (face-attribute 'default :background nil t))
  (set-face-attribute 'lsp-ui-doc-highlight-hover nil
		      :background (face-attribute 'default :background nil t))
  :custom
  ;; Sideline
  (lsp-ui-doc-border (face-background 'isearch))
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-delay 0.3)
  ;; Doc popup
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-show-with-cursor nil) ;;after command
  (lsp-ui-doc-show-with-moust t)
  (lsp-ui-doc-max-height 20)
  :general
  (:keymaps 'lsp-ui-mode-map
            "M-."     'lsp-ui-peek-find-definitions
            "M-?"     'lsp-ui-peek-find-references
            "C-c l d" 'lsp-ui-doc-glance   ; показать доку разово
            "C-c l i" 'lsp-ui-imenu)      ; структура файла
)

(use-package lsp-pyright
  :after lsp-mode)

(use-package flymake
  :disabled t
  :commands flymake-mode
  :after eglot)

(use-package flycheck
  :hook(prog-mode . flycheck-mode)
  :custom
  (flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-indication-mode 'right-fringe)
  )

(use-package flycheck-posframe
  :after flycheck
  :hook (flycheck-mode . flycheck-posframe-mode)
  :custom
  (flycheck-posframe-position 'point-bottom-left-corner)
  (flycheck-posframe-border-width 2))

(use-package projectile
  :config (projectile-mode)
  :general
  ("C-c p" '(:keymap projectile-command-map :wk "Projectile")))

(use-package elcord
  :hook (elpaca-after-init . elcord-mode))

(use-package dired-git-info
  :hook (dired-after-readin . dired-git-info-auto-enable))



(use-package tree-sitter
  :defer t
  :custom
  (treesit-language-source-alist
   '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (scss "https://github.com/tree-sitter/tree-sitter-scss"))))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  :defer t)

(use-package cmake-ts-mode
  :disabled t
  :mode("CMakeLists\\.txt\\'" . cmake-ts-mode))

;;(face-foreground 'line-number-current-line)
(use-package corfu
 :hook (elpaca-after-init . global-corfu-mode)
 :config
 (set-face-attribute 'corfu-border nil
		     :background "#fe8019")
 :custom
 (tab-always-indent 'complete)
 (corfu-auto t)
 (corfu-auto-delay 0.4)
 (corfu-auto-prefix 3)
 (corfu-popupinfo-mode t)
 (corfu-popupinfo-hide nil)
 (corfu-popupinfo-delay '(5.0 . 1.0))
 (corfu-preselect 'first)
 :general
 (:keymaps 'global-map "M-SPC" #'completion-at-point)
 (:keymaps
  'corfu-map "RET" #'corfu-send "TAB" 'corfu-popupinfo-toggle))

(use-package smartparens
 :defer t
 :hook (emacs-lisp-mode . smartparens-mode)
 :hook (org-mode . smartparens-mode))

(use-package multiple-cursors)

(use-package move-text
 :general
 (:keymaps 'global-map "C-M-k" 'move-text-up "C-M-j" 'move-text-down))

(use-package yasnippet
  :commands yas-minor-mode
  :hook (strd/web-mode . yas-minor-mode))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package magit
  :disabled t
  :defer t)

(use-package vterm
  :defer t)

(use-package prettier-js
  :hook
  (tsx-ts-mode . prettier-js-mode)
  (scss-mode . prettier-js-mode))

(add-to-list 'auto-mode-alist '("\\.ts\\'"   . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'"  . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\'" . sass-mode))

(defvar strd/web-mode-hook nil
  "My web mode hook")

(defun strd/web-mode-setup ()
  (run-hooks 'strd/web-mode-hook))

(dolist (mode-hook '(typescript-ts-mode-hook
		     tsx-ts-mode-hook
		     sass-mode-hook
		     scss-mode-hook))
  (add-hook mode-hook #'strd/web-mode-setup))
(add-hook 'strd/web-mode-hook #'display-line-numbers-mode)
(add-hook 'strd/web-mode-hook #'yas-minor-mode-on)
(add-hook 'strd/web-mode-hook #'smartparens-mode)

(use-package org
 :custom-face
 (org-document-title ((t (:height 180))))
 (org-level-1 ((t (:height 160))))
 (org-level-2 ((t (:height 140))))
 (org-level-3 ((t (:height 120))))
 :general-config (:keymaps 'org-mode-map "C-j" nil))

(use-package org-modern
  :disabled t
  :hook (org-mode . org-modern-mode))

(use-package visual-fill-column
  :disabled t
  :after org
  :hook
  (org-mode . visual-fill-column-mode)
  (dashboard-mode . visual-fill-column-mode)
  :custom
  (visual-fill-column-width 100)
  (visual-fill-column-center-text t))

(use-package toc-org :hook (org-mode . toc-org-mode))

(use-package org-auto-tangle :hook (org-mode . org-auto-tangle-mode))

;;    (:keymaps)
  (use-package treemacs
    :general-config
    (:keymaps 'global-map "C-z" 'treemacs)
    :config
    (setq display-line-numbers nil)
    (setq treemacs-nerd-icons-tab " ")
    (loadf "components/treemacs-nerd-icons.el")
    (treemacs-load-theme "nerd-icons")
    :custom
    (treemacs-fringe-indicator-mode nil))

(use-package treemacs-magit
  :disabled t)

(set-face-attribute 'default nil
                    :family "Iosevka NF"
                    :height 110
                    :weight 'medium)
(set-face-attribute 'mode-line nil :family "Iosevka NF")
(set-face-attribute 'mode-line-active nil :family "Iosevka NF")
(set-face-attribute 'mode-line-inactive nil :family "Iosevka NF")

(use-package beacon
  :defer t
  :config (beacon-mode 1))

(use-package nerd-icons)

(use-package nerd-icons-corfu
 :after corfu
 :config
 (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package dired
  :ensure nil
  :custom-face (dired-broken-symlink
		((t (
		     :foreground "OrangeRed1"
		     :background unspecified
		     :weight unspecified)))))

(use-package nerd-icons-dired
  :after nerd-icons
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package dired-subtree
  :after dired
  :disabled t
  :commands (dired-subtree-toggle dired-subtree-cycle)
  :general (:keymaps 'dired-mode-map
		     "<tab>" 'dired-subtree-toggle
		     "<backtab>" 'dired-subtree-cycle))

(use-package colorful-mode
  :custom (colorful-highlight-in-comments t)
  :config (global-colorful-mode))

(use-package indent-bars
  :hook((prog-mode strd/web-mode) . indent-bars-mode)
  :custom
  (indent-bars-color '(highlight :face-bg t :blend 0.2))
  (indent-bars-pattern ".")
  (indent-bars-width-frac 0.1)
  (indent-bars-pad-frac 0.1)
  (indent-bars-no-descend-lists nil)
  (indent-bars-treesit-support t)
  (indent-bars-starting-column 1)
  (indent-bars-zigzag nil)
  (indent-bars-color-by-depth nil)
  (indent-bars-highlight-current-depth nil)
  (indent-bars-treesit-wrap '((c argument_list parameter_list init_declarator parenthesized_expression))))

(use-package rainbow-delimiters
 :defer t
 :hook (prog-mode . rainbow-delimiters-mode)
 :hook (help-mode . rainbow-delimiters-mode)
 :hook (org-mode . rainbow-delimiters-mode))

(use-package gruvbox-theme
  :config
 (load-theme 'gruvbox-dark-soft t)
 (set-face-attribute 'line-number nil :inherit 'default)
 (set-face-attribute 'line-number-current-line nil :inherit 'default))

(use-package hydra)

(use-package vertico
 :init (vertico-mode)
 :general-config (:keymaps 'vertico-map "C-j" nil))

(use-package marginalia
  :after vertico
  :requires vertico
  :init (marginalia-mode))

(use-package powerline
  :hook (elpaca-after-init . powerline-default-theme))

(use-package dashboard
  ;; :hook
  ;; (dashboard-after-initialize
   ;; . (lambda () (set-frame-parameter nil 'visibility t)))
  :config
  (toggle-truncate-lines 1)
  (add-hook
	   'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))

(use-package which-key
  :defer t
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
