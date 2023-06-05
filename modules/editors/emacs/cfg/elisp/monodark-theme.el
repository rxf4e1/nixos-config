;;; monodark-theme.el --- monodark
;;; Version: 1.0
;;; Commentary:
;;; A theme called monodark
;;; Code:

(deftheme monodark "DOCSTRING for monodark")
  (custom-theme-set-faces 'monodark
   '(default ((t (:foreground "#ffffff" :background "#000000" ))))
   '(cursor ((t (:background "#ffd700" ))))
   '(fringe ((t (:background "#000000" ))))
   '(mode-line ((t (:foreground "#151515" :background "#7c6f64" ))))
   '(highlight ((t (:foreground "#ffffff" ))))
   '(hl-line ((t (:background "gray4" ))))
   '(region ((t (:background "gray24" :bold t ))))
   '(secondary-selection ((t (:background "#cacaca" ))))
   '(show-paren-match ((t (:foreground "#ffd700" :bold t ))))
   '(font-lock-builtin-face ((t (:foreground "#fffafa" ))))
   '(font-lock-comment-face ((t (:foreground "gray30" ))))
   '(font-lock-function-name-face ((t (:foreground "#ffffff" ))))
   '(font-lock-keyword-face ((t (:foreground "#ffd700" :bold nil ))))
   '(font-lock-string-face ((t (:foreground "#969696" ))))
   '(font-lock-type-face ((t (:foreground "#969696" ))))
   '(font-lock-constant-face ((t (:foreground "#595959" ))))
   '(font-lock-variable-name-face ((t (:foreground "#595959" ))))
   '(minibuffer-prompt ((t (:foreground "#a0a305" :bold t ))))
   '(font-lock-warning-face ((t (:foreground "#ff0000" :bold t ))))
   )

;;;###autoload
(and load-file-name
    (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory
                  (file-name-directory load-file-name))))
;; Automatically add this theme to the load path

(provide-theme 'monodark)

;;; monodark-theme.el ends here
