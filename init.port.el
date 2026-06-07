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

(setq kill-whole-line t)
(setq use-short-answers t)

(global-whitespace-mode 1)
(setq tab-bar-show 1)
(setq tab-bar-new-button-show nil)
(setq tab-bar-tab-hints t)
(delete-selection-mode 1)
(setq inhibit-startup-screen t)

(global-set-key (kbd "C-c d") #'duplicate-dwim)

(set-face-attribute 'default nil :height 120)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

(setq whitespace-style '(face spaces tabs trailing space-mark tab-mark))

;; Vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package savehist
  :ensure t
  :init
  (savehist-mode))

;; Dashboard
(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
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
  :config
  (load-theme 'gruber-darker t))

;; 5. Completion (Company)

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.2))

;; 6. LSP & Development Base
(use-package eglot
  :ensure t
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l h" . eldoc)
              ("C-c l f" . eglot-format)
              ("C-c l F" . eglot-format-buffer)
              ("C-c l d" . xref-find-definitions-at-mouse)
              ("C-c l R" . eglot-reconnect)))

(use-package consult
  :ensure t)

(use-package consult-eglot
  :esure t
  :after (consult eglot)
  :bind (:map eglot-mode-map
              ("C-c s s" . consult-eglot-symbols)))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

;; Ensure company works in eglot buffers
(add-hook 'eglot-managed-mode-hook #'company-mode)
(setq compilation-ask-about-save nil)

(use-package project
  :ensure t)

;; 7. Load Programming Modes
(load (expand-file-name "init-prog.el" user-emacs-directory))

;; 8. Multiple Cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-c m c" . mc/edit-lines)))

;; 9. Dired Sidebar
(use-package dired-sidebar
  :ensure t
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-subtree-line-prefix "> ")
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; 10. Version Control
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package magit-todos
  :ensure t
  :hook (magit-mode . magit-todos-mode))
