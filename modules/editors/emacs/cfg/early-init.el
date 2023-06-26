;;; Package: --- early-init.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq package-enable-at-startup nil)
(setq inhibit-default-init nil)

(setq native-comp-async-report-warnings-errors nil)

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

(with-eval-after-load 'elpaca
  (add-hook 'elpaca-after-init-hook '+reset-init-values))

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

;; (push '(font . "Source Code Pro") default-frame-alist)
;; (set-face-font 'default "Source Code Pro")
;; (set-face-font 'variable-pitch "DejaVu Sans")
;; (copy-face 'default 'fixed-pitch)

(setq server-client-instructions nil)
(setq frame-inhibit-implied-resize t)

(advice-add #'x-apply-session-resources :override #'ignore)

(setq desktop-restore-forces-onscreen nil)

(setq ring-bell-function #'ignore
      inhibit-startup-screen t)

(provide 'early-init)
;;; early-init.el ends here
