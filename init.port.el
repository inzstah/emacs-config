
;; 1. Package Manager Bootstrap
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

;; 2. Basics & UI
(tool-bar-mode 0)
(menu-bar-mode 0)
(tab-bar-mode 1)
(setq tab-bar-show 1)
(setq tab-bar-new-button-show nil)
(setq tab-bar-tab-hints t)
(delete-selection-mode 1)
(setq inhibit-startup-screen t)

(setq initial-buffer-choice nil)

(global-set-key (kbd "C-c d") #'duplicate-line)

(set-face-attribute 'default nil :height 120)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(move-text-default-bindings)

;; Dashboard
(use-package dashboard
  :init

  (setq initial-buffer-choice nil)
  
  (dashboard-setup-startup-hook)
  
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-navigation-cycle t)
  (setq dashboard-items '((recents   . 5)
                          (bookmarks . 5)
                          (projects  . 5)
                          (registers . 5))))

;; 3. Environment & Paths
(add-to-list 'exec-path (expand-file-name "~/go/bin"))
(setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/go/bin")))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

;; 4. Themes
(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

;; 5. Completion (Icomplete + Company)
(icomplete-mode 1)
(defun my-icomplete-styles ()
  (setq-local completion-styles '(initials flex)))
(add-hook 'icomplete-minibuffer-setup-hook 'my-icomplete-styles)

(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.2))

;; 6. LSP & Development
(use-package eglot
  :bind (:map eglot-mode-map
	      ("C-c l a" . eglot-code-actions)
	      ("C-c l r" . eglot-rename)
	      ("C-c l h" . eldoc)
	      ("C-c l f" . eglot-format)
	      ("C-c l F" . eglot-format-buffer)
	      ("C-c l d" . xref-find-definitions-at-mouse)
	      ("C-c l R" . eglot-reconnect)))

(require 'project)

(use-package go-mode
  :hook (go-mode . eglot-ensure)
  :config
  (add-hook 'go-mode-hook (lambda ()
                            (add-hook 'before-save-hook #'gofmt-before-save nil t))))

(use-package emmet-mode
  :ensure t
  :hook (html-mode sgml-mode css-mode web-mode))

;; Ensure company works in eglot buffers
(add-hook 'eglot-managed-mode-hook #'company-mode)

(setq compilation-ask-about-save nil)

;; C# stuff
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
	       '(csharp-mode . ("csharp-ls")))
  (add-to-list 'eglot-server-programs
	       '(csharp-ts-mode .("csharp-ls"))))

(use-package csharp-mode
  :hook ((csharp-mode) . eglot-ensure))


(add-hook 'csharp-mode-hook 'eglot-ensure)

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

(defun my/find-elixir-ls-path ()
  "Find the elixir-ls language server path."
  (let ((archive-path (expand-file-name "~/.mix/archives/hex-elixir_ls/elixir_ls")))
    (if (file-exists-p archive-path)
        archive-path
      ;; Fallback: try common installation paths
      (or (executable-find "elixir-ls")
          (expand-file-name "~/.elixir-ls")))))

(setq my/elixir-ls-path (my/find-elixir-ls-path))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(elixir-mode . (,(or my/elixir-ls-path "elixir-ls")
                                "language_server.sh"))))

(add-hook 'elixir-mode-hook #'eglot-ensure)
(add-hook 'erlang-mode-hook #'eglot-ensure)

(add-hook 'elixir-mode-hook #'eglot-format-on-save-mode)
(add-hook 'erlang-mode-hook #'eglot-format-on-save-mode)

(use-package elixir-mode
  :ensure t
  :mode ("\\.exs?\\'" "\\.eex\\'" "\\.heex\\'")
  :hook (elixir-mode . mix-init)
  :hook (elixir-mode . exunit-init))

(use-package web-mode
  :ensure t
  :mode ("\\.html?\\'" "\\.ejs\\'" "\\.erb\\'" "\\.mustache\\'" "\\.haml\\'")
  :config
  (add-to-list 'web-mode-engine-alist '("elixir" . "\\.(eex|heex)\\'")))

(use-package mix
  :ensure t
  :commands (mix-init mix-run mix-test))

(use-package exunit
  :ensure t
  :commands (exunit-init exunit-run))

(add-hook 'eglot-managed-mode-hook #'company-mode)
(setq compilation-ask-about-save nil)

;; 7. Multiple Cursors
(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-c m c" . mc/edit-lines)))

;; 8. Dired Sidebar
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix ">")
  ;; (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; 9. Version Control (Magit)
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package magit-todos
  :ensure t
  :hook (magit-mode . magit-todos-mode))
