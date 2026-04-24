(menu-bar-mode -1)
(tool-bar-mode -1)
(setq initial-frame-alist '((fullscreen . maximized) (alpha-background . 0.95) (vertical-scroll-bars . nil)))
(setq default-frame-alist '((alpha-background . 0.95) (vertical-scroll-bars . nil)))
(setq package-enable-at-startup nil)
(defmacro loadf (path)
  "Eval file in Emacs config directory.
PATH: file name."
  (load-file (concat user-emacs-directory path)))
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
