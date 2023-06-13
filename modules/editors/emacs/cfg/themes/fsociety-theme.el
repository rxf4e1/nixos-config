;;; fsociety-theme.el --- fsociety
;;; Version: 1.0
;;; Commentary:
;;; A theme called fsociety
;;; Code:

(deftheme fsociety "fsociety theme.")

;; (custom-theme-set-variables
;;  'fsociety
;;  '(frame-background-mode (quote dark)))

;;; Color Palette
;; under development - can change!

;; #0f0e0f
;; #abaeac

;; #101010
;; #2525252
;; #464646
;; #525252
;; #2a2a2a
;; #b9b9b9
;; #e3e3e3
;; #f7f7f7
;; #7c7c7c
;; #999999
;; #a0a0a0
;; #8e8e8e
;; #333333
;; #686868
;; #747474
;; #5e5e5e

(let ((class '((class color) (min-colors 89)))
      (fg         "#ABAEAC")
      (bg         "#0F0E0F")
      (err        "#FF0000")
      (warning    "#FF8C00")
      (success    "#FF00FF")
      (shadow     "#0A0A0A")
      (dark-red   "#8B0000")
      (gold       "#FFD700")
      (gold1      "#DAA520")
      (green      "#008000")
      (black      "#000000")
      (gray       "#1A1A1A")
      (gray1      "#303030")
      (gray2      "#696969")
      (gray3      "#A9A9A9")
      (gray4      "#BEBEBE")
      (gray5      "#D3D3D3")
      (gray6      "#DCDCDC")
      (gray7      "#F5F5F5")
      (white      "#FFFFFF")
      )
  
  (custom-theme-set-faces
   'fsociety
   
   ;; Built-in
   `(button              ((,class (:underline t))))
   `(default             ((,class (:foreground ,fg :background ,bg))))
   `(border              ((,class (:foreground ,gray4 :background ,gray2))))
   `(cursor              ((,class (:background ,gold))))
   `(fringe              ((,class (:background ,bg))))
   `(parenthesis         ((,class (:foreground ,fg))))
   `(region              ((,class (:background ,black :bold t))))
   `(secondary-selection ((,class (:background ,gray6))))
   `(minibuffer-prompt   ((,class (:foreground ,gold :bold t))))
   `(menu                ((,class (:foreground ,gold :inherit (default fixed-pitch)))))
   `(trailing-whitespace ((,class (:foreground ,dark-red :background ,black))))
   `(tooltip             ((,class (:foreground ,white :background ,gray))))
   `(shadow              ((,class (:foreground ,shadow))))
   `(success             ((,class (:foreground ,success :bold t))))
   `(warning             ((,class (:foreground ,warning :bold t))))
   `(error               ((,class (:foreground ,err :bold t))))
   
   ;; Font-Lock
   `(font-lock-builtin-face           ((,class (:foreground ,gray7))))
   `(font-lock-comment-face           ((,class (:foreground ,gray1))))
   `(font-lock-comment-delimiter-face ((,class (:foreground ,gray1))))
   `(font-lock-doc-face               ((,class (:foreground ,white))))
   `(font-lock-function-name-face     ((,class (:foreground ,white))))
   `(font-lock-keyword-face           ((,class (:foreground ,gold))))
   `(font-lock-string-face            ((,class (:foreground ,gray3))))
   `(font-lock-type-face              ((,class (:foreground ,gray3))))
   `(font-lock-constant-face          ((,class (:foreground ,gray2))))
   `(font-lock-variable-name-face     ((,class (:foreground ,gray2))))
   `(font-lock-warning-face           ((,class (:foreground ,err :bold t))))

   ;; Compilation
   `(compilation-info    ((,class (:foreground ,green))))
   `(compilation-warning ((,class (:foreground ,dark-red))))
   `(compilation-error   ((,class (:foreground ,err))))

   ;; Custom
   `(custom-state ((,class (:foreground ,green))))

   ;; Dired
   `(dired-directory    ((,class (:foreground ,white))))
   `(diredp-file-name   ((,class (:foreground ,gray2))))
   `(diredp-file-suffix ((,class (:foreground ,gray2 :bold t))))

   ;; Eshell
   ;; Flymake/Flycheck/Flyspell
   ;; Icomplete/Ido

   ;; Info
   `(info-xref ((,class (:foreground "#7fffd4"))))

   ;; iSearch
   ;; Line Highlighting
   `(highlight      ((,class (:foreground unspecified))))
   `(lazy-highlight ((,class (:inherit highlight))))
   `(hl-line        ((,class (:background ,shadow :foreground unspecified))))
   ;; `(highlight-current-line-face ((,class (:background ,shadow :foreground unspecified))))

   ;; Line Numbers
   `(line-number ((,class (:inherit default :foreground ,gray1))))
   `(line-number-current-line ((,class (:inherit line-number :foreground ,gold))))

   ;; Mode-Line
   `(mode-line           ((,class (:foreground ,dark-red :background ,black))))
   `(mode-line-buffer-id ((,class (:foreground unspecified :background unspecified :bold t))))
   `(mode-line-inactive  ((,class (:foreground ,gray :background ,black))))

   ;; Show-Paren
   `(show-paren-mismatch-face ((,class (:foreground ,dark-red :bold t))))
   `(show-paren-match         ((,class (:foreground ,gold :bold t))))

   ;; Ansi-Term/VTerm
   `(term-color-black   ((,class (:foreground "#484848" :background "#52494e"))))
   `(term-color-white   ((,class (:foreground "#e4e4ef" :background "#ffffff"))))
   `(term-color-red     ((,class (:foreground "#ee6363" :background "#ee6363"))))
   `(term-color-green   ((,class (:foreground "#458b00" :background "#458b00"))))
   `(term-color-blue    ((,class (:foreground "#00688b" :background "#00688b"))))
   `(term-color-yellow  ((,class (:foreground "#cd8500" :background "#cd8500"))))
   `(term-color-magenta ((,class (:foreground "#cd00cd" :background "#cd00cd"))))
   `(term-color-cyan    ((,class (:foreground "#00868b" :background "#00868b"))))
   ;; Whitespace

   ;; Org-mode
   `(org-document-title        ((,class (:foreground ,gold1))))
   `(org-document-info         ((,class (:foreground ,white))))
   `(org-document-info-keyword ((,class (:foreground ,gold1))))
   `(org-block                 ((,class (:foreground ,white :background ,shadow))))
   `(org-block-begin-line      ((,class (:foreground ,gray1 :bold t))))
   `(org-block-end-line        ((,class (:inherit org-block-begin-line))))
   `(org-code                  ((,class (:inherit (shadow fixed-pitch)))))
   `(org-indent                ((,class (:inherit (org-hide fixed-pitch)))))
   `(org-special-keyword       ((,class (:inherit (font-lock-comment-face fixed-pitch)))))
   `(org-property-value        ((,class (:inherit fixed-pitch))) t)
   `(org-verbatim              ((,class (:inherit (shadow fixed-pitch)))))
   `(org-meta-line             ((,class (:inherit (font-lock-comment-face fixed-pitch)))))
   `(org-tag                   ((,class (:foreground ,gold :height 0.8 :bold t))))
   `(org-heading               ((,class (:foreground ,gold :weight normal :variable-pitch t :inherit variable-pitch))))
   `(org-level-1 ((,class (:height 1.2 :inherit outline-3))))
   `(org-level-2 ((,class (:height 1.1 :inherit outline-1))))
   `(org-level-3 ((,class (:height 1.0 :inherit outline-2))))
   `(org-level-4 ((,class (:height 1.0 :inherit outline-4))))
   `(org-level-5 ((,class (:height 1.0 :inherit outline-4))))
   `(org-level-6 ((,class (:height 1.0 :inherit outline-4))))
   `(org-level-7 ((,class (:height 1.0 :inherit outline-4))))
   `(org-level-8 ((,class (:height 1.0 :inherit outline-4))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'fsociety)
;;; fsociety-theme.el ends here
