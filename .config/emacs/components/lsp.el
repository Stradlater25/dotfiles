;; -*- lexical-binding: t; -*-
(setopt strd/eglot-server-programs
		'(((python-mode python-ts-mode) . ("rass" "python"))
		  ((rust-ts-mode rust-mode)     . ("rust-analyzer"))
		  (tsx-ts-mode
		   . ("lspx" "--lsp" "\"typescript-language-server\"" "--stdio" "--lsp" "tailwindcss-language-server" "--stdio" "--lsp" "vscode-eslint-language-server" "--stdio")
		   )))
		   ;; . ("lspx" "--" "tailwindcss-language-server" "--stdio" "--" "typescript-language-server" "--stdio")
			  ;; :initializationOptions
			   ;; (:includeLanguages
				;; (:tsx "html" :typescriptreact "html" :typescript "html")
				;; :validate t)
				;; ))))

;; (add-hook 'tsx-ts-mode-hook
		  ;; (lambda ()
			;; (setq-local eglot-workspace-configuration
						;; '(:tailwindCSS
						  ;; (:includeLanguages
						   ;; (:tsx "html" :typescriptreact "html" :typescript "html")
						   ;; :validate t
						   ;; :lint
						   ;; (
							;; :cssConflict "warning"
										 ;; :invalidApply "error"
										 ;; :incalidTailwindDirective "error")
						   ;; ))
						;; )))


;; (setopt strd/eglot-workspace-configuration
;; 		'())

;; (tsx-ts-mode . ("rass" "--" "tailwindcss-language-server" "--stdio"
;; "--" "typescript-language-server" "--stdio"))
;; ()

;; eglot-language-id
