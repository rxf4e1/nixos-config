;;; monodark-theme.el --- monodark
;;; Version: 1.0
;;; Commentary:
;;; A theme called monodark
;;; Code:

(deftheme monodark "DOCSTRING for monodark")

(custom-theme-set-variables
 'monodark
 '(frame-background-mode (quote dark)))

;;; Color Palette
;; under development - can change!
(defvar monodark-default-colors-alist
  '(("mono-white-fg"  . "#FFFFFF")
    ("mono-black-bg"  . "#000000")
    ("mono-gold"      . "#FFD700")
    ("mono-gold+1"    . "#DAA520")
    ("mono-gray-1"    . "#595959")
    ("mono-gray"      . "#808080")
    ("mono-gray+1"    . "#4D4D4D")))

(custom-theme-set-faces
 'monodark
 
 ;; Built-in
 `(default ((t (:foreground "#ffffff" :background "#000000" ))))
 `(border ((t (:foreground "#0f0f0f" :background "#333333"))))
 `(button ((t (:underline t))))
 `(cursor ((t (:background "#ffd700"))))
 `(fringe ((t (:background "#000000"))))
 `(parenthesis ((t (:foreground "#ffffff"))))
 `(region ((t (:background "#1a1a1a" :bold t))))
 `(secondary-selection ((t (:background "#cacaca"))))
 `(lazy-highlight ((t (:inherit highlight))))
 `(minibuffer-prompt ((t (:foreground "#ffd700" :bold t))))
 `(menu ((t (:foreground "#ffd700" :inherit (default fixed-pitch)))))
 `(trailing-whitespace ((t (:foreground "#8b0000" :background "#000000"))))
 `(tooltip ((t (:foreground "#ffffff" :background "#333333"))))
 `(shadow ((t (:foreground "#0a0a0a"))))
 `(success ((t (:foreground "#ffffff" :bold t))))
 `(warning ((t (:foreground "#ff8c00" :bold t))))
 `(error ((t (:foreground "#ff0000" :bold t))))
 ;; Font-Lock
 `(font-lock-builtin-face ((t (:foreground "#fffafa"))))
 `(font-lock-comment-face ((t (:foreground "#303030"))))
 `(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face))))
 `(font-lock-doc-face ((t (:foreground "#ffffff"))))
 `(font-lock-function-name-face ((t (:foreground "#ffffff"))))
 `(font-lock-keyword-face ((t (:foreground "#ffd700"))))
 `(font-lock-string-face ((t (:foreground "#969696"))))
 `(font-lock-type-face ((t (:foreground "#969696"))))
 `(font-lock-constant-face ((t (:foreground "#595959"))))
 `(font-lock-variable-name-face ((t (:foreground "#595959"))))
 `(font-lock-warning-face ((t (:foreground "#ff0000" :bold t))))
 ;; Compilation
 `(compilation-info ((t (:foreground "#008000"))))
 `(compilation-warning ((t (:foreground "#8b0000"))))
 `(compilation-error ((t (:foreground "#ff0000"))))
 ;; Custom
 `(custom-state ((t (:foreground "#006400"))))
 ;; Dired
 `(dired-directory ((t (:foreground "#ffffff"))))
 `(diredp-file-name ((t (:foreground "#969696"))))
 `(diredp-file-suffix ((t (:foreground "#969696" :bold t))))
 ;; Eshell
 ;; Flymake/Flycheck/Flyspell
 ;; Icomplete/Ido
 ;; Info
 `(info-xref ((t (:foreground "#7fffd4"))))
 ;; iSearch
 ;; Line Highlighting
 `(highlight ((t (:foreground unspecified))))
 ;; `(highlight-current-line-face ((t (:background "#0a0a0a" :foreground unspecified))))
 `(hl-line ((t (:background "#0a0a0a" :foreground unspecified))))
 ;; Line Numbers
 `(line-number ((t (:inherit default :foreground "#333333"))))
 `(line-number-current-line ((t (:inherit line-number :foreground "#ffd700"))))
 ;; Mode-Line
 `(mode-line ((t (:foreground "#cccccc" :background "#0a0a0a"))))
 `(mode-line-buffer-id ((t (:foreground unspecified :background unspecified :bold t))))
 `(mode-line-inactive ((t (:foreground "#999999" :background "#0a0a0a"))))
 ;; Show-Paren
 `(show-paren-mismatch-face ((t (:foreground "#8b0000" :bold t))))
 `(show-paren-match ((t (:foreground "#ffd700" :bold t))))
 ;; Ansi-Term/VTerm
 `(term-color-black ((t (:foreground "#484848" :background "#52494e"))))
 `(term-color-white ((t (:foreground "#e4e4ef" :background "#ffffff"))))
 `(term-color-red ((t (:foreground "#ee6363" :background "#ee6363"))))
 `(term-color-green ((t (:foreground "#458b00" :background "#458b00"))))
 `(term-color-blue ((t (:foreground "#00688b" :background "#00688b"))))
 `(term-color-yellow ((t (:foreground "#cd8500" :background "#cd8500"))))
 `(term-color-magenta ((t (:foreground "#cd00cd" :background "#cd00cd"))))
 `(term-color-cyan ((t (:foreground "#00868b" :background "#00868b"))))
 ;; Whitespace
 ;; Org-mode
 `(org-document-title ((t (:foreground "#daa520"))))
 `(org-document-info ((t (:foreground "#ffffff"))))
 `(org-document-info-keyword ((t (:foreground "#daa520"))))
 `(org-block ((t (:foreground "#ffffff" :background "#080808"))))
 `(org-block-begin-line ((t (:foreground "#333333" :bold t))))
 `(org-block-end-line   ((t (:inherit org-block-begin-line))))
 `(org-code ((t (:inherit (shadow fixed-pitch)))))
 `(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 `(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 `(org-property-value ((t (:inherit fixed-pitch))) t)
 `(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 `(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 `(org-tag ((t (:foreground "#ffd700" :height 0.8 :bold t))))
 `(org-heading
   ((t (:weight normal :foreground "#ffd700" :variable-pitch t :inherit variable-pitch))))
 `(org-level-1 ((t (:height 1.2 :inherit outline-3))))
 `(org-level-2 ((t (:height 1.1 :inherit outline-2))))
 `(org-level-3 ((t (:height 1.0 :inherit outline-1))))
 `(org-level-4 ((t (:height 1.0 :inherit outline-4))))
 `(org-level-5 ((t (:height 1.0 :inherit outline-4))))
 `(org-level-6 ((t (:height 1.0 :inherit outline-4))))
 `(org-level-7 ((t (:height 1.0 :inherit outline-4))))
 `(org-level-8 ((t (:height 1.0 :inherit outline-4))))
 )

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;; Automatically add this theme to the load path

(provide-theme 'monodark)

;;; monodark-theme.el ends here
