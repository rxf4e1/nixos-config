;;; Package: --- init.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Byte Compile
(eval-when-compile (require 'cl-lib nil t))
(setq auto-save-list-file-prefix nil
      byte-compile-warnings '(not cl-functions obsolete))

;; add paths to the list
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; Start the initial frame maximized
;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'after-init-hook 'toggle-frame-maximized t)

;; Get rid of screen eaters
(unless (and  (display-graphic-p) (eq system-type 'gnu/linux))
  (push '(menu-bar-lines . 0) default-frame-alist))
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; load config file
(require 'ob-tangle)
;; (org-babel-load-file (expand-file-name "~/.config/emacs/config.org"))
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

(provide 'init)
;;; init.el ends here.