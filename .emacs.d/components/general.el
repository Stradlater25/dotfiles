;; -*- lexical-binding: t; -*-
(general-define-key
 :keymaps 'global-map
 "C-j"		'next-line
 "C-k"		'previous-line
 "C-h"		'backward-char
 "C-l"		'forward-char
 "C-p"		'scroll-down-command
 "C-n"		'scroll-up-command
 "C-<tab>"	(lambda () (interactive) (insert-tab))
 "M-RET"	'duplicate-line
 "C-;"		'kill-line
 
 "H-<return>"	'vterm
 "C-x C-<return>" 'vterm-other-window
 "H-z"		'resize-window/body
 )

(general-define-key
 :keymaps 'global-map
 "H-j" 'mc/mark-next-lines
 "H-k" 'mc/mark-previous-lines
 "H-m m" 'mc/edit-lines :wk "Edit multiple lines"
 )
     
(general-unbind
  :keymaps 'lisp-interaction-mode-map
  "C-j")
(with-eval-after-load 'hydra
  (defhydra resize-window (:hint nil)
    "
^Window size^
^^^^^^^^-------------------------------------------------------------
_H-l_: Enlarge horizontally	
_H-h_: Shrink horizontally
_H-k_: Enlarge vertically	
_H-j_: Shrink vertically
"
    ("H-l" enlarge-window-horizontally)
    ("H-h" shrink-window-horizontally)
    ("H-k" enlarge-window)
    ("H-j" shrink-window)
    ))

