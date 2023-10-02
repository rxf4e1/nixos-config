;;; Package: --- init.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-hook 'elpaca-after-init-hook
          (lambda ()
            (message "Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract (current-time) before-init-time)))
                     gcs-done)))

(defvar elpaca-installer-version 0.5)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; (profiler-start 'cpu+mem)
;; (add-hook 'elpaca-after-init-hook (lambda () (profiler-stop) (profiler-report)))

;; Some basic settings
(setq frame-title-format '("%b"))
(setq ring-bell-function 'ignore)
(setq use-short-answers t)
(setq native-comp-async-report-warnings-errors 'silent) ; EMACS 28 WITH NATIVE COMPILATION
(setq native-compile-prune-cache t) ; Emacs 29
(setq make-backup-files nil)
(setq backup-inhibited nil) ; Not sure if needed, given `make-backup-files'
(setq create-lockfiles nil)

;; Always start with *scratch*
(setq initial-buffer-choice t)

;; load config file
(require 'ob-tangle)
;; (org-babel-load-file (expand-file-name "./config.org" user-emacs-directory))
;; (add-hook 'elpaca-after-init-hook (lambda () (load-file "./config.el")))

(let ((config-dot-el (concat user-emacs-directory "config.el"))
      (config-dot-org (concat user-emacs-directory "config.org")))
  (if (not (file-exists-p config-dot-el))
      (org-babel-tangle-file config-dot-org))
  (load-file config-dot-el))

;;END OF INIT FILE
;; (setq elpaca-after-init-time (current-time)) ;; prevents `elpaca-after-init-hook` from running later.

(provide 'init)
;;; init.el ends here.
