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

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(global-set-key (kbd "C-c d") #'duplicate-dwim)

(set-face-attribute 'default nil :height 120)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(use-package move-text
  :config
  (move-text-default-bindings))

(setq whitespace-style '(face spaces tabs trailing space-mark tab-mark))

;; Ido
(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  :config
  (ido-mode 1))

(use-package ido-vertical-mode
  :after ido
  :init
  (setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
  :config
  (ido-vertical-mode 1))

(use-package smex
  :after ido
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command))
  :init
  (smex-initialize))

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

;; 6. LSP & Development Base
(use-package eglot
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l h" . eldoc)
              ("C-c l f" . eglot-format)
              ("C-c l F" . eglot-format-buffer)
              ("C-c l d" . xref-find-definitions-at-mouse)
              ("C-c l R" . eglot-reconnect)))

(use-package consult)

(use-package consult-eglot
  :after (consult eglot)
  :bind (:map eglot-mode-map
              ("C-c s s" . consult-eglot-symbols)))

(use-package smartparens
  :config
  (smartparens-global-mode t))

;; Ensure company works in eglot buffers
(add-hook 'eglot-managed-mode-hook #'company-mode)
(setq compilation-ask-about-save nil)

(use-package project)

;; 7. Load Programming Modes
(load (expand-file-name "init-prog.el" user-emacs-directory))

;; 8. Multiple Cursors
(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-c m c" . mc/edit-lines)))

;; 9. Dired Sidebar
(use-package dired-sidebar
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
  :bind ("C-x g" . magit-status))

(use-package magit-todos
  :hook (magit-mode . magit-todos-mode))
