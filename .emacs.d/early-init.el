(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq package-enable-at-startup nil)
(defmacro loadf (path)
  "Eval file in Emacs config directory.
PATH: file name."
  (load-file (concat user-emacs-directory path)))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
