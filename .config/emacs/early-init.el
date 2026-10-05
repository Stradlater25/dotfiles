;;; -*- lexical-binding: t -*-
(setq package-enable-at-startup nil)
(defmacro loadf (path)
  "Eval file in Emacs config directory.
PATH: file name."
  (load-file (concat user-emacs-directory path)))
(setq default-frame-alist
      '((tool-bar-lines . 0)
        (menu-bar-lines . 0)
        (font . "Iosevka-11")
        (alpha-background . 95)
        (vertical-scroll-bars . nil)))
