;; -*- lexical-binding: t; -*-
(use-package org
  :ensure nil
  :bind (:map org-mode-map
              ("C-M-a" . org-appear-mode))
  :config
  (setq org-hide-emphasis-markers t)
  (setq org-hide-leading-stars t)
  (setq org-startup-indented t)

  :preface
  )

(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoactivation t
	org-appear-autoemphasis t
	org-appear-autokeywords t
        org-appear-autolinks t
        org-appear-autoentities t
        org-appear-autosubmarkers t))

;; God-mode auto disable org-appear
(with-eval-after-load 'god-mode
  (defun my/god-mode-hide-syntax ()
    "Disable org-appear-mode when moving around in god-mode."
    (when (derived-mode-p 'org-mode)
      (org-appear-mode -1)))

  (defun my/god-mode-show-syntax ()
    "Re-enable org-appear-mode when exiting god-mode to type."
    (when (derived-mode-p 'org-mode)
      (org-appear-mode 1)))

  (add-hook 'god-mode-enabled-hook #'my/god-mode-hide-syntax)
  (add-hook 'god-mode-disabled-hook #'my/god-mode-show-syntax))
