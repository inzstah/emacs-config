;;-*- lexical-binding: t; -*-
;; Go
(use-package go-mode
  :hook (go-mode . eglot-ensure)
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (add-hook 'before-save-hook #'gofmt-before-save nil t))))

;; Rust
(use-package rust-mode
  :ensure t
  :hook (rust-mode . eglot-ensure))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) . ("rustup" "run" "stable" "rust-analyzer"))))

;; Guile Scheme
(use-package geiser
  :ensure t
  :custom
  (geiser-repl-skip-help-p t)
  (geiser-mode-auto-p t))

(use-package geiser-guile
  :ensure t
  :after geiser)


;; Web / HTML
(use-package web-mode
  :mode ("\\.html?\\'" "\\.ejs\\'" "\\.erb\\'" "\\.mustache\\'" "\\.haml\\'")
  :config
  (add-to-list 'web-mode-engine-alist '("elixir" . "\\.(eex|heex)\\'")))

(use-package emmet-mode
  :hook (html-mode sgml-mode css-mode web-mode))

;; C#
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(csharp-mode . ("csharp-ls")))
  (add-to-list 'eglot-server-programs '(csharp-ts-mode . ("csharp-ls"))))

(use-package csharp-mode
  :hook (csharp-mode . eglot-ensure))

;; Elixir & Erlang
(use-package elixir-mode
  :mode ("\\.exs?\\'" "\\.eex\\'" "\\.heex\\'")
  :hook ((elixir-mode . mix-init)
         (elixir-mode . exunit-init)
         (elixir-mode . eglot-ensure)
         (elixir-mode . eglot-format-on-save-mode)))

(use-package erlang
  :hook ((erlang-mode . eglot-ensure)
         (erlang-mode . eglot-format-on-save-mode)))

(use-package mix
  :commands (mix-init mix-run mix-test))

(use-package exunit
  :commands (exunit-init exunit-run))

;; Eglot server configurations for Elixir
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(elixir-mode . (,(or (executable-find "language_server.sh")
                                     (expand-file-name "~/.mix/archives/elixir_ls/elixir_ls/language_server.sh"))))))

(provide 'init-prog-modes)
