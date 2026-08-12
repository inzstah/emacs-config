;; 1. Package Manager Bootstrap
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

;; Themes
(use-package gruber-darker-theme
  :ensure t)

;; God Mode (Modal editing)
(use-package god-mode
  :ensure t
  :bind
  (("<escape>" . god-local-mode)
   :map god-local-mode-map
   ("i" . god-local-mode))

  :custom
  (god-mode-enable-auto-repeat t)

  :config

  ;; Exclude buffers that rely on single-key native commands
  (dolist (mode '(dired-mode magit-status-mode magit-log-mode magit-diff-mode))
    (add-to-list 'god-exempt-major-modes mode))

  ;; Catch-all for dynamically spawned Magit sub-buffers
  (add-to-list 'god-exempt-predicates
               (lambda () (derived-mode-p 'magit-mode)))

  ;; Dynamic visual indicator in the mode-line
  (defun my/god-mode-update-indicator ()
    (if god-local-mode
        (set-face-attribute 'mode-line nil :background "GoldenRod4" :foreground "white")
      (face-spec-set 'mode-line (face-user-default-spec 'mode-line))))

  (add-hook 'god-mode-enabled-hook #'my/god-mode-update-indicator)
  (add-hook 'god-mode-disabled-hook #'my/god-mode-update-indicator)

  ;; Translates internal shortcuts visually if you use which-key
  (with-eval-after-load 'which-key
    (which-key-enable-god-mode-support)))

;; 2. Basics & UI
(setopt x-gtk-resize-child-frames 'resize)
(tool-bar-mode 0)
(menu-bar-mode 0)
(tab-bar-mode 1)
(global-visual-line-mode 1)

(setq kill-whole-line t)
(setq use-short-answers t)

(global-whitespace-mode 1)
(setq tab-bar-show 1)
(setq tab-bar-new-button-show nil)
(setq tab-bar-tab-hints t)
(delete-selection-mode 1)
(setq inhibit-startup-screen t)

(global-set-key (kbd "C-c d") #'duplicate-dwim)
(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "<f5>") 'recompile)

;; Make sure keybindings works with russian keyboard layout
(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

(set-face-attribute 'default nil :height 120)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

(setq whitespace-style '(face spaces tabs trailing space-mark tab-mark))

;; Vertico & such
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

;; Floating Minibuffer Completion
(use-package posframe
  :ensure t)

(use-package vertico-posframe
  :ensure t
  :after vertico
  :init
  (vertico-posframe-mode 1)
  :custom
  ;; Visual polish
  (vertico-posframe-poshandler #'posframe-poshandler-frame-bottom-right-corner)
  (vertico-posframe-parameters
   '((left-fringe . 8)
     (right-fringe . 8)
     (internal-border-width . 1))))

(use-package marginalia
  :ensure t
  :after vertico
  :init
  (marginalia-mode))

;; Dashboard
(use-package page-break-lines
  :ensure t
  :init
  (global-page-break-lines-mode 1)
  :config
  (setq page-break-lines-char ?─))

(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :config
  (setq dashboard-page-separator "\n\f\n")

  (setq dashboard-set-navigator t)

  (setq dashboard-startupify-list '(dashboard-insert-banner
                                    dashboard-insert-newline
                                    dashboard-insert-banner-title
                                    dashboard-insert-newline
                                    dashboard-insert-navigator
                                    dashboard-insert-newline
                                    dashboard-insert-items
                                    dashboard-insert-newline
                                    dashboard-insert-footer))

  (setq dashboard-navigator-buttons
        `(
          ((nil "📦 Packages" "Manage Emacs packages"
                (lambda (&rest _) (list-packages)) 'default)
           (nil "✉️ Mail" "Open default mail client"
                (lambda (&rest _) (call-interactively 'compose-mail)) 'default)
           (nil "⚙️ Settings" "Open init.port.el"
                (lambda (&rest _) (find-file "~/.emacs.d/init.port.el")) 'default))
	  ((nil "🗞️ Telega" "Open telega client"
		(lambda (&rest _) (telega)) 'default))))

  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome to Emacs!")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-projects-backend 'project-el)
  ;; (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-navigation-cycle t)
  (setq dashboard-items '((recents   . 10)
                          (projects  . 5)
                          (bookmarks . 5))))

(with-eval-after-load 'dashboard
  (define-key dashboard-mode-map (kbd "l") (lambda () (interactive) (list-packages)))
  (define-key dashboard-mode-map (kbd "m") (lambda () (interactive) (call-interactively 'compose-mail)))
  (define-key dashboard-mode-map (kbd "s") (lambda () (interactive) (find-file "~/.emacs.d/init.port.el"))))


(add-hook 'server-after-make-frame-hook 'dashboard-open)

;; 3. Environment & Paths
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x pgtk))
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
  :ensure t
  :after (consult eglot)
  :bind (:map eglot-mode-map
              ("C-c s" . consult-eglot-symbols)))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

;; Ensure company works in eglot buffers
(add-hook 'eglot-managed-mode-hook #'company-mode)
(setq compilation-ask-about-save nil)

(use-package project
  :ensure t)

;; 7. Load Side Modes
(load (expand-file-name "init-prog.el" user-emacs-directory))
(load (expand-file-name "init-org.el" user-emacs-directory))
(load (expand-file-name "init-telega.el" user-emacs-directory))

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
  (setq dired-sidebar-subtree-line-prefix "+")
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; 10. Version Control
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package magit-todos
  :ensure t
  :hook (magit-mode . magit-todos-mode))

(with-eval-after-load 'magit
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(setq display-buffer-alist
      '(("\\*magit:.*"
         (display-buffer-reuse-window display-buffer-same-window)
         (reusable-frames . visible))))

