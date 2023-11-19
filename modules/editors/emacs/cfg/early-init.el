;;; Package: --- early-init.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq package-enable-at-startup nil)
(setq inhibit-default-init nil)

(setq native-comp-async-report-warnings-errors nil)

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name ".local/var/eln-cache/" user-emacs-directory))))

;; (unless (string-empty-p file)
;;   (eval-after-load file
;;     '(debug)))

;; (setq debug-on-message "")
;; (add-variable-watcher 'org-capture-after-finalize-hook
;;                       (lambda (symbol newval operation where)
;;                         (debug)
;;                         (message "%s set to %s" symbol newval)))
;; (setq debug-on-error t)


(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 1)

(defun +gc-after-focus-change ()
  "Run GC when frame loses focus."
  (run-with-idle-timer
   5 nil
   (lambda () (unless (frame-focus-state) (garbage-collect)))))

(defun +reset-init-values ()
  (run-with-idle-timer
   1 nil
   (lambda ()
     (setq file-name-handler-alist default-file-name-handler-alist
           gc-cons-percentage 0.1
           gc-cons-threshold 100000000)
     (message "gc-cons-threshold & file-name-handler-alist restored")
     (when (boundp 'after-focus-change-function)
       (add-function :after after-focus-change-function #'+gc-after-focus-change)))))

(add-hook 'elpaca-after-init-hook '+reset-init-values)

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      use-dialog-box t ; only for mouse events, which I seldom use
      use-file-dialog nil
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-echo-area-message user-login-name ; read the docstring
      inhibit-startup-buffer-menu t)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; (push '(font . "Cozette-11") default-frame-alist)
;; (set-face-font 'default "Cozette-11")
;; (set-face-font 'variable-pitch "Cozette-11")
(push '(font . "JetBrains Mono-8") default-frame-alist)
(set-face-font 'default "JetBrains Mono-8")
(set-face-font 'variable-pitch "JetBrains Mono-8")
(copy-face 'default 'fixed-pitch)

(setq server-client-instructions nil)
(setq frame-inhibit-implied-resize t)

(advice-add #'x-apply-session-resources :override #'ignore)

(setq desktop-restore-forces-onscreen nil)

(setq ring-bell-function #'ignore
      inhibit-startup-screen t)

(provide 'early-init)
;;; early-init.el ends here
