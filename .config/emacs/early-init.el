;; -*- lexical-binding: t; -*-
(setq package-enable-at-startup nil)
(defmacro loadf (path)
  "Eval file in Emacs config directory.
PATH: file name."
  (load-file (concat user-emacs-directory path)))

(dolist (tag '((tool-bar-lines .0)
			   (vertical-scroll-bars . nil)
			   (alpha-background . 95)
			   (menu-bar-lines . 0)
			   (font . "Iosevka-11")))
  (add-to-list 'default-frame-alist tag))
