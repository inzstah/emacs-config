;; -*- lexical-binding: t; -*-
(when (fboundp 'native-comp-available-p)
  (setq native-comp-async-jobs-number (max 1 (- (num-processors) 2))))

(use-package tracking
  :ensure t)

(defun my/telega-file-buffer-p (buffer-name _action)
  (let ((buf (get-buffer buffer-name)))
    (when buf
      (let ((file-path (buffer-file-name buf)))
        (and file-path
             (string-match-p "/telega/\\(cache\\|files\\)/" file-path))))))

(add-to-list 'display-buffer-alist
             '(my/telega-file-buffer-p
               (display-buffer-in-side-window)
               (side . right)
               (window-width . 0.45)
               (slot . 0)
               (window-parameters . ((no-delete-other-windows . t)))))

;; Purge cache on exit
(defun my/clear-telega-photo-cache ()
  (let ((photo-dir (expand-file-name "~/.telega/cache/photos")))
    (when (file-directory-p photo-dir)
      (delete-directory photo-dir t))))

(add-hook 'kill-emacs-hook #'my/clear-telega-photo-cache)

(use-package telega
  :commands (telega)
  :defer t
  :init
  (setq gc-cons-threshold 100000000) ; ~100MB

  :config
  ;; Optimization variables
  ;; (setq telega-use-images nil)
  ;; (setq telega-avatar-work-dir nil)
  (setq telega-emoji-use-images nil)
  (setq telega-sticker-animated-play t)
  (setq telega-use-tracking-for '(mention))
  (setq telega-chat-fill-limit 20)
  (setq telega-view-file-method 'emacs)

  ;; Kill preview buffer on exit
  (defun my/telega-view-clean-exit ()
    "Bind 'q' to completely drop the file buffer out of the stack."
    (local-set-key (kbd "q") #'kill-current-buffer))

  (add-hook 'telega-open-file-hook #'my/telega-view-clean-exit)

  (defun my/disable-whitespace-mode ()
    (whitespace-mode -1))

  (add-hook 'telega-chat-mode-hook #'my/disable-whitespace-mode)
  (add-hook 'telega-root-mode-hook #'my/disable-whitespace-mode))

;; Emoji as actual images
(when (member "Noto Color Emoji" (font-family-list))
  (set-fontset-font t 'emoji '("Noto Color Emoji" . "iso10646-1") nil 'prepend))

(custom-set-faces
 '(telega-msg-reaction-counter ((t (:inherit default :height 0.9 :weight normal :foreground "gray"))))
 '(telega-msg-reaction ((t (:inherit default :height 1.0 :box nil)))))

(provide 'init-telega.el)
