;;; geka-theme.el --- A dark theme based on gruber-darker and kanagawa-dragon -*- lexical-binding: t -*-

;; Copyright (C) 2026  Custom

;; Author: Custom
;; Version: 1.1.0
;; Package-Requires: ((emacs "24.1"))
;; Keywords: faces, theme

;; This file is NOT part of GNU Emacs.

;;; Commentary:
;; A dark theme that combines the grayscale and brownish tones of
;; gruber-darker with the colorful accents of kanagawa-dragon.
;; Explicitly supports cape, consult, corfu, dashboard, god-mode,
;; magit, magit-todos, marginalia, posframe, smartparens, vertico,
;; vertico-posframe, speedbar, tab-bar, and whitespace-mode.

;;; Code:

(deftheme geka
  "A dark theme based on gruber-darker and kanagawa-dragon.")

(let ((class '((class color) (min-colors 89)))
      ;; Gruber-Darker Base
      (bg-main      "#181818")
      (bg-dim       "#282828")
      (bg-alt       "#353535")
      (bg-active    "#484848")
      (bg-inactive  "#282828")
      (fg-main      "#e4e4ef")
      (fg-dim       "#a0a0a0")
      (fg-alt       "#95a99f")
      (border       "#453d41")
      (cursor       "#ffdd33")

      ;; Gruber + Kanagawa Colors
      (red          "#f43841")
      (red-warmer   "#ff4f58")
      (red-cooler   "#c4746e") ;; kanagawa dragon-red
      (red-faint    "#c73c3f")
      (red-intense  "#a02020")
      (green        "#73c936")
      (green-warmer "#76946A") ;; kanagawa autumn-green
      (green-cooler "#8a9a7b") ;; kanagawa dragon-green-2
      (green-faint  "#87a987") ;; kanagawa dragon-green
      (yellow       "#ffdd33")
      (yellow-warmer "#DCA561") ;; kanagawa autumn-yellow
      (yellow-cooler "#cc8c3c") ;; gruber-darker brown
      (yellow-faint  "#c4b28a") ;; kanagawa dragon-yellow
      (yellow-intense "#806010")
      (blue         "#96a6c8") ;; gruber-darker niagara
      (blue-warmer  "#8ba4b0") ;; kanagawa dragon-blue-2
      (blue-cooler  "#7E9CD8") ;; kanagawa crystal-blue
      (blue-faint   "#565f73") ;; gruber-darker niagara-1
      (magenta      "#9e95c7") ;; gruber-darker wisteria
      (magenta-warmer "#8992a7") ;; kanagawa dragon-violet
      (magenta-cooler "#a292a3") ;; kanagawa dragon-pink
      (magenta-faint  "#b8b4d0") ;; kanagawa oni-violet-2
      (cyan         "#8ea4a2") ;; kanagawa dragon-aqua
      (cyan-warmer  "#7a8382") ;; kanagawa dragon-gray-3
      (cyan-cooler  "#949fb5") ;; kanagawa dragon-teal
      (cyan-faint   "#9e9b93") ;; kanagawa dragon-gray-2

      ;; Intense Backgrounds
      (bg-red-intense     "#601515")
      (bg-green-intense   "#153015")
      (bg-yellow-intense  "#4a3a10")
      (bg-blue-intense    "#152540")
      (bg-magenta-intense "#302540")
      (bg-cyan-intense    "#153035")

      ;; Subtle Backgrounds
      (bg-red-subtle     "#301010")
      (bg-green-subtle   "#102010")
      (bg-yellow-subtle  "#252010")
      (bg-blue-subtle    "#101525")
      (bg-magenta-subtle "#1a1025")
      (bg-cyan-subtle    "#102025")

      ;; Diff / Git Backgrounds
      (bg-added-faint "#1a2018")
      (bg-added       "#2B3328") ;; kanagawa winter-green
      (bg-added-refine "#3c4a38")
      (fg-added       "#76946A") ;; kanagawa autumn-green

      (bg-changed-faint "#2a251f")
      (bg-changed       "#49443C") ;; kanagawa winter-yellow
      (bg-changed-refine "#5a5040")
      (fg-changed       "#DCA561") ;; kanagawa autumn-yellow

      (bg-removed-faint "#25151a")
      (bg-removed       "#43242B") ;; kanagawa winter-red
      (bg-removed-refine "#5a303a")
      (fg-removed       "#C34043") ;; kanagawa autumn-red

      ;; UI Backgrounds
      (bg-mode-line-active "#282828")
      (fg-mode-line-active "#f4f4ff")
      (bg-mode-line-inactive "#181818")
      (fg-mode-line-inactive "#a0a0a0")
      (bg-completion  "#303540")
      (bg-popup       "#282828")
      (bg-hover       "#453d41")
      (bg-hl-line     "#202020")
      (bg-paren-match "#484848")
      (bg-err         "#301515")
      (bg-warning     "#302515")
      (bg-info        "#153020")
      (bg-region      "#303540")
      (bg-search      "#2D4F67") ;; kanagawa wave-blue-2

      (fg-link        "#7E9CD8")
      (fg-link-visited "#a292a3"))

  (custom-theme-set-faces
   'geka

   ;; Core
   `(default ((,class (:background ,bg-main :foreground ,fg-main))))
   `(cursor ((,class (:background ,cursor :foreground ,bg-main))))
   `(region ((,class (:background ,bg-region :foreground ,fg-main))))
   `(highlight ((,class (:background ,bg-alt :foreground ,fg-main))))
   `(hl-line ((,class (:background ,bg-hl-line))))
   `(fringe ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(shadow ((,class (:foreground ,fg-dim))))
   `(match ((,class (:background ,bg-yellow-intense :foreground ,fg-main))))
   `(link ((,class (:foreground ,fg-link :underline t))))
   `(link-visited ((,class (:foreground ,fg-link-visited :underline t))))
   `(minibuffer-prompt ((,class (:foreground ,cyan :weight bold))))
   `(success ((,class (:foreground ,green))))
   `(warning ((,class (:foreground ,yellow-warmer))))
   `(error ((,class (:foreground ,red-warmer :weight bold))))
   `(escape-glyph ((,class (:foreground ,red))))
   `(vertical-border ((,class (:foreground ,border))))
   `(window-divider ((,class (:background ,border))))
   `(trailing-whitespace ((,class (:background ,bg-red-subtle :foreground ,red-cooler))))

   ;; Font Lock
   `(font-lock-builtin-face ((,class (:foreground ,blue))))
   `(font-lock-comment-face ((,class (:foreground ,yellow-cooler :slant italic))))
   `(font-lock-comment-delimiter-face ((,class (:foreground ,yellow-cooler))))
   `(font-lock-constant-face ((,class (:foreground ,cyan-faint))))
   `(font-lock-number-face ((,class (:foreground ,yellow-warmer))))
   `(font-lock-doc-face ((,class (:foreground ,green :slant italic))))
   `(font-lock-function-name-face ((,class (:foreground ,blue))))
   `(font-lock-keyword-face ((,class (:foreground ,yellow))))
   `(font-lock-negation-char-face ((,class (:foreground ,red))))
   `(font-lock-preprocessor-face ((,class (:foreground ,cyan-faint))))
   `(font-lock-regexp-grouping-backslash ((,class (:foreground ,red))))
   `(font-lock-regexp-grouping-construct ((,class (:foreground ,red))))
   `(font-lock-string-face ((,class (:foreground ,green))))
   `(font-lock-type-face ((,class (:foreground ,cyan-faint))))
   `(font-lock-variable-name-face ((,class (:foreground ,fg-main))))
   `(font-lock-warning-face ((,class (:foreground ,yellow-warmer))))

   ;; UI Elements
   `(mode-line ((,class (:background ,bg-mode-line-active :foreground ,fg-mode-line-active :box (:line-width 1 :color ,border)))))
   `(mode-line-inactive ((,class (:background ,bg-mode-line-inactive :foreground ,fg-mode-line-inactive :box (:line-width 1 :color ,border)))))
   `(header-line ((,class (:background ,bg-mode-line-active :foreground ,fg-mode-line-active :box (:line-width 1 :color ,border)))))
   `(tooltip ((,class (:background ,bg-popup :foreground ,fg-main))))

   ;; Tabs (tab-bar and tab-line)
   `(tab-bar ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(tab-bar-tab ((,class (:background ,bg-dim :foreground ,fg-main :weight bold :box (:line-width 1 :color ,border)))))
   `(tab-bar-tab-inactive ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(tab-line ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(tab-line-tab ((,class (:background ,bg-dim :foreground ,fg-main :weight bold))))
   `(tab-line-tab-inactive ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(tab-line-tab-current ((,class (:background ,bg-dim :foreground ,fg-main :weight bold :box (:line-width 1 :color ,border)))))

   ;; Search
   `(isearch ((,class (:background ,bg-yellow-intense :foreground ,fg-main))))
   `(isearch-fail ((,class (:background ,bg-red-intense :foreground ,fg-main))))
   `(lazy-highlight ((,class (:background ,bg-search :foreground ,fg-main))))

   ;; Parenthesis matching
   `(show-paren-match ((,class (:background ,bg-paren-match))))
   `(show-paren-mismatch ((,class (:background ,red-intense :foreground ,fg-main))))

   ;; Completions (Built-in)
   `(completions-annotations ((,class (:foreground ,cyan-faint :slant italic))))
   `(completions-common-part ((,class (:foreground ,yellow :weight bold))))
   `(completions-first-difference ((,class (:foreground ,yellow-warmer))))

   ;; Whitespace Mode (Subtle)
   `(whitespace-space ((,class (:foreground ,bg-alt))))
   `(whitespace-tab ((,class (:foreground ,bg-alt))))
   `(whitespace-newline ((,class (:foreground ,bg-alt))))
   `(whitespace-indentation ((,class (:background unspecified :foreground ,bg-alt))))
   `(whitespace-trailing ((,class (:background ,bg-red-subtle :foreground ,red-cooler))))
   `(whitespace-empty ((,class (:background ,bg-red-subtle :foreground ,red-cooler))))
   `(whitespace-hspace ((,class (:foreground ,bg-alt))))

;;;;; cape
   `(cape-preview-face ((,class (:background ,bg-popup :foreground ,fg-main))))

;;;;; consult
   `(consult-async-split ((,class (:foreground ,red))))
   `(consult-bookmark ((,class (:foreground ,magenta))))
   `(consult-directory ((,class (:foreground ,blue))))
   `(consult-file ((,class (:foreground ,fg-main))))
   `(consult-grep ((,class (:foreground ,green-cooler))))
   `(consult-line-number ((,class (:foreground ,fg-dim))))
   `(consult-narrow-indicator ((,class (:foreground ,yellow-warmer))))
   `(consult-preview-cursor ((,class (:background ,cursor :foreground ,bg-main))))
   `(consult-preview-line ((,class (:background ,bg-hl-line))))
   `(consult-preview-match ((,class (:background ,bg-yellow-intense :foreground ,fg-main))))
   `(consult-separator ((,class (:foreground ,border))))

;;;;; consult-eglot
   `(consult-eglot-face ((,class (:foreground ,blue-cooler))))

;;;;; corfu
   `(corfu-default ((,class (:background ,bg-popup :foreground ,fg-main))))
   `(corfu-current ((,class (:background ,bg-active :foreground ,fg-main))))
   `(corfu-bar ((,class (:background ,fg-dim))))
   `(corfu-border ((,class (:background ,border))))
   `(corfu-annotations ((,class (:foreground ,cyan-faint :slant italic))))
   `(corfu-deprecated ((,class (:foreground ,fg-dim :strike-through t))))
   `(corfu-popupinfo ((,class (:background ,bg-popup :foreground ,fg-main))))
   `(corfu-popupinfo-separator ((,class (:foreground ,fg-dim :slant italic))))

;;;;; dashboard
   `(dashboard-heading ((,class (:foreground ,blue :weight bold))))
   `(dashboard-banner-logo-title ((,class (:foreground ,yellow :weight bold :height 1.3))))
   `(dashboard-items-face ((,class (:foreground ,fg-main))))
   `(dashboard-no-items-face ((,class (:foreground ,fg-dim))))
   `(dashboard-footer-face ((,class (:foreground ,fg-dim :slant italic))))
   `(dashboard-navigator ((,class (:foreground ,cyan))))

;;;;; diff / magit
   `(diff-added ((,class (:background ,bg-added :foreground ,fg-added))))
   `(diff-changed ((,class (:background ,bg-changed :foreground ,fg-changed))))
   `(diff-removed ((,class (:background ,bg-removed :foreground ,fg-removed))))
   `(diff-refine-added ((,class (:background ,bg-added-refine :foreground ,fg-added))))
   `(diff-refine-removed ((,class (:background ,bg-removed-refine :foreground ,fg-removed))))
   `(magit-branch-current ((,class (:background ,bg-blue-subtle :foreground ,blue-cooler :box t))))
   `(magit-branch-local ((,class (:background ,bg-blue-subtle :foreground ,blue-cooler))))
   `(magit-branch-remote ((,class (:background ,bg-green-subtle :foreground ,green-cooler))))
   `(magit-diff-added ((,class (:background ,bg-added :foreground ,fg-added))))
   `(magit-diff-added-highlight ((,class (:background ,bg-added-refine :foreground ,fg-added))))
   `(magit-diff-context ((,class (:foreground ,fg-dim))))
   `(magit-diff-context-highlight ((,class (:background ,bg-alt :foreground ,fg-main))))
   `(magit-diff-removed ((,class (:background ,bg-removed :foreground ,fg-removed))))
   `(magit-diff-removed-highlight ((,class (:background ,bg-removed-refine :foreground ,fg-removed))))
   `(magit-diff-hunk-heading ((,class (:background ,bg-mode-line-active :foreground ,fg-mode-line-active))))
   `(magit-diff-hunk-heading-highlight ((,class (:background ,bg-active :foreground ,fg-main))))
   `(magit-hash ((,class (:foreground ,fg-dim))))
   `(magit-log-author ((,class (:foreground ,magenta))))
   `(magit-log-date ((,class (:foreground ,cyan-faint))))
   `(magit-log-graph ((,class (:foreground ,fg-dim))))
   `(magit-section-heading ((,class (:foreground ,yellow :weight bold))))
   `(magit-section-highlight ((,class (:background ,bg-dim))))
   `(magit-tag ((,class (:foreground ,yellow-warmer))))

;;;;; magit-todos
   `(magit-todos-item ((,class (:foreground ,fg-main))))
   `(magit-todos-item-note ((,class (:foreground ,yellow-faint :slant italic))))
   `(magit-todos-item-path ((,class (:foreground ,cyan))))
   `(magit-todos-item-position ((,class (:foreground ,fg-dim))))
   `(magit-todos-item-prefix ((,class (:foreground ,red-warmer :weight bold))))

;;;;; marginalia
   `(marginalia-key ((,class (:foreground ,green-cooler))))
   `(marginalia-file-name ((,class (:foreground ,fg-main))))
   `(marginalia-file-priv-read ((,class (:foreground ,green))))
   `(marginalia-file-priv-write ((,class (:foreground ,blue))))
   `(marginalia-file-priv-exec ((,class (:foreground ,yellow))))
   `(marginalia-mode ((,class (:foreground ,cyan-faint))))
   `(marginalia-modified ((,class (:foreground ,yellow-warmer))))
   `(marginalia-null ((,class (:foreground ,fg-dim))))
   `(marginalia-number ((,class (:foreground ,cyan-faint))))
   `(marginalia-string ((,class (:foreground ,green-cooler))))
   `(marginalia-symbol ((,class (:foreground ,blue))))
   `(marginalia-true ((,class (:foreground ,green))))
   `(marginalia-type ((,class (:foreground ,cyan-faint))))
   `(marginalia-value ((,class (:foreground ,fg-dim))))
   `(marginalia-version ((,class (:foreground ,cyan-faint))))
   `(marginalia-on ((,class (:foreground ,green))))
   `(marginalia-off ((,class (:foreground ,red))))

;;;;; posframe
   `(posframe ((,class (:background ,bg-popup :foreground ,fg-main))))
   `(posframe-border ((,class (:background ,border))))

;;;;; smartparens
   `(sp-show-pair-match-face ((,class (:background ,bg-paren-match))))
   `(sp-show-pair-mismatch-face ((,class (:background ,red-intense :foreground ,fg-main))))
   `(sp-pair-overlay-face ((,class (:background ,bg-alt))))

;;;;; speedbar
   `(speedbar-button-face ((,class (:foreground ,cyan))))
   `(speedbar-directory-face ((,class (:foreground ,blue-cooler :weight bold))))
   `(speedbar-file-face ((,class (:foreground ,fg-main))))
   `(speedbar-highlight-face ((,class (:background ,bg-hover :foreground ,fg-main))))
   `(speedbar-selected-face ((,class (:background ,bg-active :foreground ,fg-main :weight bold))))
   `(speedbar-separator-face ((,class (:background ,bg-dim :foreground ,fg-dim :overline ,border))))
   `(speedbar-tag-face ((,class (:foreground ,yellow-faint))))

;;;;; vertico
   `(vertico-current ((,class (:background ,bg-completion :weight bold))))
   `(vertico-group-title ((,class (:foreground ,blue-cooler :slant italic))))
   `(vertico-group-separator ((,class (:foreground ,border :strike-through t))))
   `(vertico-multiline ((,class (:foreground ,fg-dim))))
   `(vertico-index ((,class (:foreground ,fg-dim))))
   `(vertico-count ((,class (:foreground ,fg-dim))))

;;;;; vertico-posframe
   `(vertico-posframe ((,class (:background ,bg-popup :foreground ,fg-main))))
   `(vertico-posframe-border ((,class (:background ,border))))

;;;;; orderless
   `(orderless-match-face-0 ((,class (:foreground ,yellow :weight bold))))
   `(orderless-match-face-1 ((,class (:foreground ,cyan :weight bold))))
   `(orderless-match-face-2 ((,class (:foreground ,magenta :weight bold))))
   `(orderless-match-face-3 ((,class (:foreground ,green :weight bold))))

;;;;; god-mode
   `(god-mode-overlay-face ((,class (:background ,bg-cyan-intense :foreground ,fg-main :box t))))

;;;;; flymake / flycheck
   `(flymake-error ((,class (:underline (:color ,red-warmer :style wave)))))
   `(flymake-warning ((,class (:underline (:color ,yellow-warmer :style wave)))))
   `(flymake-note ((,class (:underline (:color ,cyan :style wave)))))
   `(flycheck-error ((,class (:underline (:color ,red-warmer :style wave)))))
   `(flycheck-warning ((,class (:underline (:color ,yellow-warmer :style wave)))))
   `(flycheck-info ((,class (:underline (:color ,cyan :style wave)))))

;;;;; line numbers
   `(line-number ((,class (:foreground ,fg-dim :background ,bg-dim))))
   `(line-number-current-line ((,class (:foreground ,yellow :background ,bg-dim :weight bold))))

   ) ; end of custom-theme-set-faces

  (custom-theme-set-variables
   'geka
   `(frame-background-mode 'dark)
   `(ansi-color-names-vector
     [,bg-active ,red ,green ,yellow ,blue ,magenta ,cyan ,fg-main])
   `(fci-rule-color ,border)
   `(vc-annotate-color-map
     '((20 . ,red-faint)
       (40 . ,red)
       (60 . ,yellow-cooler)
       (80 . ,yellow)
       (100 . ,green-cooler)
       (120 . ,green)
       (140 . ,cyan)
       (160 . ,blue)
       (180 . ,magenta)
       (200 . ,magenta-cooler)
       (220 . ,fg-main)
       (240 . ,fg-dim)
       (260 . ,bg-alt)
       (280 . ,bg-dim)
       (300 . ,bg-main)
       (320 . ,bg-active)
       (340 . ,border)
       (360 . ,fg-alt))))

  ) ; end of let

;;; Second theme: More Kanagawa colors

(deftheme kage
  "A variant of gruber-kanagawa with more vivid kanagawa colors.")

(let ((class '((class color) (min-colors 89)))
      ;; Same backgrounds as before
      (bg-main      "#181818")
      (bg-dim       "#282828")
      (bg-alt       "#353535")
      (bg-active    "#484848")
      (bg-inactive  "#282828")
      (fg-main      "#e4e4ef")
      (fg-dim       "#a0a0a0")
      (fg-alt       "#95a99f")
      (border       "#453d41")
      (cursor       "#ffdd33")

      ;; More vivid Kanagawa colors
      (red          "#E82424")  ;; kanagawa samurai-red (most vivid red)
      (red-warmer   "#FF6B6B")  ;; custom vivid coral (more saturated than surimi)
      (red-cooler   "#FF5D62")  ;; kanagawa peach-red
      (red-faint    "#c73c3f")
      (red-intense  "#a02020")
      (green        "#98BB6C")  ;; kanagawa spring-green (keep vivid)
      (green-warmer "#76946A")
      (green-cooler "#8a9a7b")
      (green-faint  "#87a987")
      (yellow       "#FFB62B")  ;; custom vivid golden-yellow (more saturated)
      (yellow-warmer "#FF9500")  ;; custom vivid orange-yellow
      (yellow-cooler "#DCA561") ;; kanagawa autumn-yellow
      (yellow-faint  "#c4b28a")
      (yellow-intense "#806010")
      (blue         "#7E9CD8")  ;; kanagawa crystal-blue (vivid)
      (blue-warmer  "#FF6B6B")  ;; custom vivid coral
      (blue-cooler  "#7FB4CA")
      (blue-faint   "#658594")
      (magenta      "#957FB8")  ;; kanagawa oni-violet
      (magenta-warmer "#FF6B6B") ;; custom vivid coral
      (magenta-cooler "#FF69B4") ;; custom vivid hot-pink
      (magenta-faint  "#b8b4d0")
      (cyan         "#7AA89F")  ;; kanagawa wave-aqua-2
      (cyan-warmer  "#FF6B6B")  ;; custom vivid coral
      (cyan-cooler  "#949fb5")
      (cyan-faint   "#9e9b93")

      ;; Keep all the other background variables the same as before
      (bg-red-intense     "#601515")
      (bg-green-intense   "#153015")
      (bg-yellow-intense  "#4a3a10")
      (bg-blue-intense    "#152540")
      (bg-magenta-intense "#302540")
      (bg-cyan-intense    "#153035")
      (bg-red-subtle     "#301010")
      (bg-green-subtle   "#102010")
      (bg-yellow-subtle  "#252010")
      (bg-blue-subtle    "#101525")
      (bg-magenta-subtle "#1a1025")
      (bg-cyan-subtle    "#102025")
      (bg-added-faint "#1a2018")
      (bg-added       "#2B3328")
      (bg-added-refine "#3c4a38")
      (fg-added       "#76946A")
      (bg-changed-faint "#2a251f")
      (bg-changed       "#49443C")
      (bg-changed-refine "#5a5040")
      (fg-changed       "#DCA561")
      (bg-removed-faint "#25151a")
      (bg-removed       "#43242B")
      (bg-removed-refine "#5a303a")
      (fg-removed       "#C34043")
      (bg-mode-line-active "#282828")
      (fg-mode-line-active "#f4f4ff")
      (bg-mode-line-inactive "#181818")
      (fg-mode-line-inactive "#a0a0a0")
      (bg-completion  "#303540")
      (bg-popup       "#282828")
      (bg-hover       "#453d41")
      (bg-hl-line     "#202020")
      (bg-paren-match "#484848")
      (bg-err         "#301515")
      (bg-warning     "#302515")
      (bg-info        "#153020")
      (bg-region      "#303540")
      (bg-search      "#2D4F67")
      (fg-link        "#7E9CD8")
      (fg-link-visited "#a292a3"))

  (custom-theme-set-faces
   'kage

   ;; Core (same as before)
   `(default ((,class (:background ,bg-main :foreground ,fg-main))))
   `(cursor ((,class (:background ,cursor :foreground ,bg-main))))
   `(region ((,class (:background ,bg-region :foreground ,fg-main))))
   `(hl-line ((,class (:background ,bg-hl-line))))
   `(fringe ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(shadow ((,class (:foreground ,fg-dim))))
   `(match ((,class (:background ,bg-yellow-intense :foreground ,fg-main))))
   `(link ((,class (:foreground ,fg-link :underline t))))
   `(link-visited ((,class (:foreground ,fg-link-visited :underline t))))
   `(minibuffer-prompt ((,class (:foreground ,cyan :weight bold))))
   `(success ((,class (:foreground ,green))))
   `(warning ((,class (:foreground ,yellow-warmer))))
   `(error ((,class (:foreground ,red-warmer :weight bold))))
   `(escape-glyph ((,class (:foreground ,yellow-warmer))))
   `(vertical-border ((,class (:foreground ,border))))
   `(window-divider ((,class (:background ,border))))
   `(trailing-whitespace ((,class (:background ,bg-red-subtle :foreground ,red-cooler))))

   ;; Font Lock (more kanagawa colors)
   `(font-lock-builtin-face ((,class (:foreground ,blue))))
   `(font-lock-comment-face ((,class (:foreground ,cyan-faint :slant italic)))) ;; kanagawa ash
   `(font-lock-comment-delimiter-face ((,class (:foreground ,cyan-faint))))
   `(font-lock-constant-face ((,class (:foreground ,magenta-cooler)))) ;; dragon-pink
   `(font-lock-doc-face ((,class (:foreground ,green-warmer :slant italic)))) ;; spring-green
   `(font-lock-function-name-face ((,class (:foreground ,blue)))) ;; crystal-blue
   `(font-lock-keyword-face ((,class (:foreground ,magenta)))) ;; oni-violet
   `(font-lock-negation-char-face ((,class (:foreground ,yellow-warmer))))
   `(font-lock-preprocessor-face ((,class (:foreground ,cyan-warmer)))) ;; wave-aqua-2
   `(font-lock-regexp-grouping-backslash ((,class (:foreground ,yellow-warmer))))
   `(font-lock-regexp-grouping-construct ((,class (:foreground ,yellow-warmer))))
   `(font-lock-string-face ((,class (:foreground ,green)))) ;; autumn-green
   `(font-lock-type-face ((,class (:foreground ,cyan)))) ;; wave-aqua-1
   `(font-lock-variable-name-face ((,class (:foreground ,yellow-warmer)))) ;; carp-yellow
   `(font-lock-warning-face ((,class (:foreground ,yellow-warmer))))
   `(font-lock-number-face ((,class (:foreground ,magenta-cooler)))) ;; dragon-pink

   ;; UI Elements (same as before)
   `(mode-line ((,class (:background ,bg-mode-line-active :foreground ,fg-mode-line-active :box (:line-width 1 :color ,border)))))
   `(mode-line-inactive ((,class (:background ,bg-mode-line-inactive :foreground ,fg-mode-line-inactive :box (:line-width 1 :color ,border)))))
   `(header-line ((,class (:background ,bg-mode-line-active :foreground ,fg-mode-line-active :box (:line-width 1 :color ,border)))))
   `(tooltip ((,class (:background ,bg-popup :foreground ,fg-main))))

   ;; Tabs (same as before)
   `(tab-bar ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(tab-bar-tab ((,class (:background ,bg-dim :foreground ,fg-main :weight bold :box (:line-width 1 :color ,border)))))
   `(tab-bar-tab-inactive ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(tab-line ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(tab-line-tab ((,class (:background ,bg-dim :foreground ,fg-main :weight bold))))
   `(tab-line-tab-inactive ((,class (:background ,bg-main :foreground ,fg-dim))))
   `(tab-line-tab-current ((,class (:background ,bg-dim :foreground ,fg-main :weight bold :box (:line-width 1 :color ,border)))))

   ;; Search (same as before)
   `(isearch ((,class (:background ,bg-yellow-intense :foreground ,fg-main))))
   `(isearch-fail ((,class (:background ,bg-red-intense :foreground ,fg-main))))
   `(lazy-highlight ((,class (:background ,bg-search :foreground ,fg-main))))

   ;; Parenthesis matching (same as before)
   `(show-paren-match ((,class (:background ,bg-paren-match))))
   `(show-paren-mismatch ((,class (:background ,red-intense :foreground ,fg-main))))

   ;; Completions (same as before)
   `(completions-annotations ((,class (:foreground ,cyan-faint :slant italic))))
   `(completions-common-part ((,class (:foreground ,yellow :weight bold))))
   `(completions-first-difference ((,class (:foreground ,yellow-warmer))))

   ;; Whitespace Mode (same as before)
   `(whitespace-space ((,class (:foreground ,bg-alt))))
   `(whitespace-tab ((,class (:foreground ,bg-alt))))
   `(whitespace-newline ((,class (:foreground ,bg-alt))))
   `(whitespace-indentation ((,class (:background unspecified :foreground ,bg-alt))))
   `(whitespace-trailing ((,class (:background ,bg-red-subtle :foreground ,red-cooler))))
   `(whitespace-empty ((,class (:background ,bg-red-subtle :foreground ,red-cooler))))
   `(whitespace-hspace ((,class (:foreground ,bg-alt))))

;;;;; cape
   `(cape-preview-face ((,class (:background ,bg-popup :foreground ,fg-main))))

;;;;; consult
   `(consult-async-split ((,class (:foreground ,yellow-warmer))))
   `(consult-bookmark ((,class (:foreground ,magenta))))
   `(consult-directory ((,class (:foreground ,blue))))
   `(consult-file ((,class (:foreground ,fg-main))))
   `(consult-grep ((,class (:foreground ,green-cooler))))
   `(consult-line-number ((,class (:foreground ,fg-dim))))
   `(consult-narrow-indicator ((,class (:foreground ,yellow-warmer))))
   `(consult-preview-cursor ((,class (:background ,cursor :foreground ,bg-main))))
   `(consult-preview-line ((,class (:background ,bg-hl-line))))
   `(consult-preview-match ((,class (:background ,bg-yellow-intense :foreground ,fg-main))))
   `(consult-separator ((,class (:foreground ,border))))

;;;;; consult-eglot
   `(consult-eglot-face ((,class (:foreground ,blue-cooler))))

;;;;; corfu
   `(corfu-default ((,class (:background ,bg-popup :foreground ,fg-main))))
   `(corfu-current ((,class (:background ,bg-active :foreground ,fg-main))))
   `(corfu-bar ((,class (:background ,fg-dim))))
   `(corfu-border ((,class (:background ,border))))
   `(corfu-annotations ((,class (:foreground ,cyan-faint :slant italic))))
   `(corfu-deprecated ((,class (:foreground ,fg-dim :strike-through t))))
   `(corfu-popupinfo ((,class (:background ,bg-popup :foreground ,fg-main))))
   `(corfu-popupinfo-separator ((,class (:foreground ,fg-dim :slant italic))))

;;;;; dashboard
   `(dashboard-heading ((,class (:foreground ,blue :weight bold))))
   `(dashboard-banner-logo-title ((,class (:foreground ,yellow :weight bold :height 1.3))))
   `(dashboard-items-face ((,class (:foreground ,fg-main))))
   `(dashboard-no-items-face ((,class (:foreground ,fg-dim))))
   `(dashboard-footer-face ((,class (:foreground ,fg-dim :slant italic))))
   `(dashboard-navigator ((,class (:foreground ,cyan))))

;;;;; diff / magit
   `(diff-added ((,class (:background ,bg-added :foreground ,fg-added))))
   `(diff-changed ((,class (:background ,bg-changed :foreground ,fg-changed))))
   `(diff-removed ((,class (:background ,bg-removed :foreground ,fg-removed))))
   `(diff-refine-added ((,class (:background ,bg-added-refine :foreground ,fg-added))))
   `(diff-refine-removed ((,class (:background ,bg-removed-refine :foreground ,fg-removed))))
   `(magit-branch-current ((,class (:background ,bg-blue-subtle :foreground ,blue-cooler :box t))))
   `(magit-branch-local ((,class (:background ,bg-blue-subtle :foreground ,blue-cooler))))
   `(magit-branch-remote ((,class (:background ,bg-green-subtle :foreground ,green-cooler))))
   `(magit-diff-added ((,class (:background ,bg-added :foreground ,fg-added))))
   `(magit-diff-added-highlight ((,class (:background ,bg-added-refine :foreground ,fg-added))))
   `(magit-diff-context ((,class (:foreground ,fg-dim))))
   `(magit-diff-context-highlight ((,class (:background ,bg-alt :foreground ,fg-main))))
   `(magit-diff-removed ((,class (:background ,bg-removed :foreground ,fg-removed))))
   `(magit-diff-removed-highlight ((,class (:background ,bg-removed-refine :foreground ,fg-removed))))
   `(magit-diff-hunk-heading ((,class (:background ,bg-mode-line-active :foreground ,fg-mode-line-active))))
   `(magit-diff-hunk-heading-highlight ((,class (:background ,bg-active :foreground ,fg-main))))
   `(magit-hash ((,class (:foreground ,fg-dim))))
   `(magit-log-author ((,class (:foreground ,magenta))))
   `(magit-log-date ((,class (:foreground ,cyan-faint))))
   `(magit-log-graph ((,class (:foreground ,fg-dim))))
   `(magit-section-heading ((,class (:foreground ,yellow :weight bold))))
   `(magit-section-highlight ((,class (:background ,bg-dim))))
   `(magit-tag ((,class (:foreground ,yellow-warmer))))

;;;;; magit-todos
   `(magit-todos-item ((,class (:foreground ,fg-main))))
   `(magit-todos-item-note ((,class (:foreground ,yellow-faint :slant italic))))
   `(magit-todos-item-path ((,class (:foreground ,cyan))))
   `(magit-todos-item-position ((,class (:foreground ,fg-dim))))
   `(magit-todos-item-prefix ((,class (:foreground ,red-warmer :weight bold))))

;;;;; marginalia
   `(marginalia-key ((,class (:foreground ,green-cooler))))
   `(marginalia-file-name ((,class (:foreground ,fg-main))))
   `(marginalia-file-priv-read ((,class (:foreground ,green))))
   `(marginalia-file-priv-write ((,class (:foreground ,blue))))
   `(marginalia-file-priv-exec ((,class (:foreground ,yellow))))
   `(marginalia-mode ((,class (:foreground ,cyan-faint))))
   `(marginalia-modified ((,class (:foreground ,yellow-warmer))))
   `(marginalia-null ((,class (:foreground ,fg-dim))))
   `(marginalia-number ((,class (:foreground ,cyan-faint))))
   `(marginalia-string ((,class (:foreground ,green-cooler))))
   `(marginalia-symbol ((,class (:foreground ,blue))))
   `(marginalia-true ((,class (:foreground ,green))))
   `(marginalia-type ((,class (:foreground ,cyan-faint))))
   `(marginalia-value ((,class (:foreground ,fg-dim))))
   `(marginalia-version ((,class (:foreground ,cyan-faint))))
   `(marginalia-on ((,class (:foreground ,green))))
   `(marginalia-off ((,class (:foreground ,magenta-cooler))))

;;;;; posframe
   `(posframe ((,class (:background ,bg-popup :foreground ,fg-main))))
   `(posframe-border ((,class (:background ,border))))

;;;;; smartparens
   `(sp-show-pair-match-face ((,class (:background ,bg-paren-match))))
   `(sp-show-pair-mismatch-face ((,class (:background ,red-intense :foreground ,fg-main))))
   `(sp-pair-overlay-face ((,class (:background ,bg-alt))))

;;;;; speedbar
   `(speedbar-button-face ((,class (:foreground ,cyan))))
   `(speedbar-directory-face ((,class (:foreground ,blue-cooler :weight bold))))
   `(speedbar-file-face ((,class (:foreground ,fg-main))))
   `(speedbar-highlight-face ((,class (:background ,bg-hover :foreground ,fg-main))))
   `(speedbar-selected-face ((,class (:background ,bg-active :foreground ,fg-main :weight bold))))
   `(speedbar-separator-face ((,class (:background ,bg-dim :foreground ,fg-dim :overline ,border))))
   `(speedbar-tag-face ((,class (:foreground ,yellow-faint))))

;;;;; vertico
   `(vertico-current ((,class (:background ,bg-completion :weight bold))))
   `(vertico-group-title ((,class (:foreground ,blue-cooler :slant italic))))
   `(vertico-group-separator ((,class (:foreground ,border :strike-through t))))
   `(vertico-multiline ((,class (:foreground ,fg-dim))))
   `(vertico-index ((,class (:foreground ,fg-dim))))
   `(vertico-count ((,class (:foreground ,fg-dim))))

;;;;; vertico-posframe
   `(vertico-posframe ((,class (:background ,bg-popup :foreground ,fg-main))))
   `(vertico-posframe-border ((,class (:background ,border))))

;;;;; orderless
   `(orderless-match-face-0 ((,class (:foreground ,yellow :weight bold))))
   `(orderless-match-face-1 ((,class (:foreground ,cyan :weight bold))))
   `(orderless-match-face-2 ((,class (:foreground ,magenta :weight bold))))
   `(orderless-match-face-3 ((,class (:foreground ,green :weight bold))))

;;;;; god-mode
   `(god-mode-overlay-face ((,class (:background ,bg-cyan-intense :foreground ,fg-main :box t))))

;;;;; flymake / flycheck
   `(flymake-error ((,class (:underline (:color ,red-warmer :style wave)))))
   `(flymake-warning ((,class (:underline (:color ,yellow-warmer :style wave)))))
   `(flymake-note ((,class (:underline (:color ,cyan :style wave)))))
   `(flycheck-error ((,class (:underline (:color ,red-warmer :style wave)))))
   `(flycheck-warning ((,class (:underline (:color ,yellow-warmer :style wave)))))
   `(flycheck-info ((,class (:underline (:color ,cyan :style wave)))))

;;;;; line numbers
   `(line-number ((,class (:foreground ,fg-dim :background ,bg-dim))))
   `(line-number-current-line ((,class (:foreground ,yellow :background ,bg-dim :weight bold))))

   ) ; end of custom-theme-set-faces

  (custom-theme-set-variables
   'kage
   `(frame-background-mode 'dark))
  ) ; end of let

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'geka)
(provide-theme 'kage)

;;; geka-theme.el ends here
