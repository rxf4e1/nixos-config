;;; config.el --- -*- lexical-binding: t -*-

(elpaca no-littering
  (require 'no-littering))

(require 'savehist)
(require 'saveplace)
(require 'recentf)

(custom-set-variables
 '(savehist-save-minibuffer-history t)
 '(savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
 '(recentf-max-menu-items 10)
 '(recentf-max-saved-items 20)
 '(recentf-auto-cleanup 100)
 '(history-length 25)
 '(savehist-mode t)
 '(save-place nil)
 '(recentf-mode t))

;; text properties severely bloat the history so delete them (courtesy of PythonNut)
(defun unpropertize-savehist ()
  (mapc (lambda (list)
          (with-demoted-errors
              (when (boundp list)
                (set list (mapcar #'substring-no-properties (eval list))))))
        '(kill-ring minibuffer-history helm-grep-history helm-ff-history file-name-history
                    read-expression-history extended-command-history)))
(add-hook 'kill-emacs-hook    #'unpropertize-savehist)
(add-hook 'savehist-save-hook #'unpropertize-savehist)

;; For my "settings" I prefer to use custom-set-variables, which does a bunch of neat stuff.
;; First, it calls a variable's "setter" function, if it has one.
;; Second, it can activate modes as well as set variables.
;; Third, it takes care of setting the default for buffer-local variables correctly.
;; https://with-emacs.com/posts/tutorials/almost-all-you-need-to-know-about-variables/#_user_options
;; https://old.reddit.com/r/emacs/comments/exnxha/withemacs_almost_all_you_need_to_know_about/fgadihl/
(custom-set-variables
 '(apropos-do-all t)
 '(echo-keystrokes 0.02)
 '(global-auto-revert-mode t)
 '(global-auto-revert-non-file-buffers t)
 '(mouse-yank-at-point t)
 '(track-eol t))

;; Allow some things that emacs would otherwise confirm.
(dolist (cmd
         '(eval-expression
           downcase-region
           upcase-region
           narrow-to-region
           set-goal-column
           dired-find-alternate-file))
  (put cmd 'disabled nil))

;; Make some buffers immortal
(defun my/immortal-buffers ()
  (if (or (eq (current-buffer) (get-buffer "*scratch*"))
          (eq (current-buffer) (get-buffer "*Messages*")))
      (progn (bury-buffer)
             nil)
    t))
(add-hook 'kill-buffer-query-functions 'my/immortal-buffers)

(elpaca general
  (require 'general)
  (general-override-mode)
  (general-auto-unbind-keys))

(elpaca-wait)

;; Unset annoying keys
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "<kp-insert>"))
(global-unset-key (kbd "<insert>"))

;; for frequently used prefix keys, the user can create a custom definer with a
;; default :prefix
;; using a variable is not necessary, but it may be useful if you want to
;; experiment with different prefix keys and aren't using `general-create-definer'
(defconst my-leader "C-c")
(general-create-definer my-leader-def :prefix my-leader)

(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
  URL `http://xahlee.info/emacs/emacs/emacs_CSS_colors.html'
  Version 2017-03-12"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[[:xdigit:]]\\{3\\}"
      (0 (put-text-property
	  (match-beginning 0)
	  (match-end 0)
	  'face (list :background
		      (let* (
			     (ms (match-string-no-properties 0))
			     (r (substring ms 1 2))
			     (g (substring ms 2 3))
			     (b (substring ms 3 4)))
			(concat "#" r r g g b b))))))
     ("#[[:xdigit:]]\\{6\\}"
      (0 (put-text-property
	  (match-beginning 0)
	  (match-end 0)
	  'face (list :background (match-string-no-properties 0)))))))
  (font-lock-flush))

(defun xah-syntax-color-hsl ()
  "Syntax color CSS's HSL color spec eg 「hsl(0,90%,41%)」 in current buffer.
  URL `http://xahlee.info/emacs/emacs/emacs_CSS_colors.html'
  Version 2017-02-02"
  (interactive)
  (require 'color)
  (font-lock-add-keywords
   nil
   '(("hsl( *\\([0-9]\\{1,3\\}\\) *, *\\([0-9]\\{1,3\\}\\)% *, *\\([0-9]\\{1,3\\}\\)% *)"
      (0 (put-text-property
	  (+ (match-beginning 0) 3)
	  (match-end 0)
	  'face
	  (list
	   :background
	   (concat
	    "#"
	    (mapconcat
	     'identity
	     (mapcar
	      (lambda (x) (format "%02x" (round (* x 255))))
	      (color-hsl-to-rgb
	       (/ (string-to-number (match-string-no-properties 1)) 360.0)
	       (/ (string-to-number (match-string-no-properties 2)) 100.0)
	       (/ (string-to-number (match-string-no-properties 3)) 100.0)))
	     "" )) ;  "#00aa00"
	   ))))))
  (font-lock-flush))

(dolist (modes
	 '(css-mode-hook
	   emacs-lisp-mode-hook
	   php-mode-hook
	   html-mode-hook))
  (add-hook modes (lambda ()
		    (xah-syntax-color-hex)
		    (xah-syntax-color-hsl))))

(custom-set-variables
 ;; Cursor
 '(cursor-type 'box)
 '(hl-line-mode t)
 ;; Mouse
 '(blink-cursor-mode nil)
 '(mouse-avoidance-mode 'banish)
 '(mouse-wheel-scroll-amount
   '(1
     ((shift) . 5)
     ((meta) . 0.5)
     ((control) . text-scale)))
 '(mouse-drag-copy-region nil)
 '(make-pointer-invisible t)
 '(mouse-wheel-progressive-speed t)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-mode t)
 ;; Scrolling behaviour
 '(scroll-preserve-screen-position t)
 '(scroll-conservatively 1) ; affects `scroll-step'
 '(scroll-margin 8)
 '(next-screen-context-lines 0))

(elpaca fontify-face
  (fontify-face-mode))

;; Default Font
(set-face-attribute 'default nil :font "Fira Code" :height 80)
;; (set-face-attribute 'default nil :font "Cozette" :height 100)
;; Fixed Font Pitch
(set-face-attribute 'fixed-pitch nil :font "Fira Code" :height 80)
;; (set-face-attribute 'fixed-pitch nil :font "Cozette" :height 100)
;; Variable Font Pitch
(set-face-attribute 'variable-pitch nil :font "Fira Code" :height 80 :weight 'regular)
;; (set-face-attribute 'variable-pitch nil :font "Cozette" :height 100 :weight 'regular)

(elpaca all-the-icons)
(elpaca all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(elpaca keycast
  (keycast-mode-line-mode))

(custom-set-variables
 '(column-number-mode t)
 '(mode-line-percent-position '(-3 "%p"))
 '(mode-line-position-column-line-format '(" [%l , %c] "))
 '(mode-line-compact t)
 '(mode-line-format
   '("%e"
     mode-line-front-space
     mode-line-mule-info
     mode-line-client
     mode-line-modified
     mode-line-remote
     mode-line-frame-identification
     mode-line-buffer-identification
     "  "
     mode-line-position
     "  "
     (vc-mode vc-mode)
     ;; mode-line-modes
     mode-line-misc-info
     mode-line-end-spaces))
 ;; Keycast
 '(keycast-separator-width 2)
 '(keycast-mode-line-remove-tail-elements nil)
 '(keycast-mode-line-insert-after 'mode-line-end-spaces))

(with-eval-after-load 'keycast
  (dolist (input '(self-insert-command org-self-insert-command))
    (add-to-list 'keycast-substitute-alist `(,input "." "Typing…"))))

(elpaca gruber-darker-theme
  (load-theme 'gruber-darker t))

(elpaca orderless)

(custom-set-variables
 '(orderless-component-separator " +")
 '(completion-category-defaults nil)
 '(completion-styles '(orderless flex initials partial-completion substring basic))
 '(completion-category-overrides '((file (styles basic substring)))))

(icomplete-mode 1)
(custom-set-variables
 '(icomplete-separator " • ")
 '(icomplete-vertical-mode nil)
 '(icomplete-delay-completions-threshold 0)
 '(icomplete-max-delay-chars 0)
 '(icomplete-compute-delay 0)
 '(icomplete-show-matches-on-no-input t)
 '(icomplete-hide-common-prefix nil)
 '(icomplete-in-buffer nil)
 '(icomplete-prospects-height 1)
 '(icomplete-with-completion-tables t)
 '(icomplete-tidy-shadowed-file-names nil)
 '(completions-format 'one-column)
 ;; '(completion-styles '(orderless partial-completion substring flex))
 ;; '(completion-category-overrides '((file (styles basic substring))
 ;;                                   (buffer (styles partial-completion initials flex)
 ;;                                           (cycle . 3))))
 )
(custom-set-faces
 `(icomplete-first-match ((t (:foreground "Green" :weight bold)))))

(general-define-key
 :keymaps 'icomplete-minibuffer-map
 "C-v" 'icomplete-vertical-mode
 "C-p" 'icomplete-backward-completions
 "C-n" 'icomplete-forward-completions
 "<tab>" 'icomplete-force-complete)

(elpaca (marginalia
	 :repo      "minad/marginalia"
	 :fetcher   github
	 :files    
	 (:defaults))
  (marginalia-mode))

(custom-set-variables
 '(marginalia-max-relative-age 0)
 '(marginalia-align 'left))

(elpaca (consult
         :repo      "minad/consult"
         :fetcher   github
         :files    
         (:defaults)))

(custom-set-variables
 '(register-preview-delay 0.5)
 '(register-preview-function #'consult-register-format)
 '(xref-show-xrefs-function #'consult-xref)
 '(xref-show-definitions-function #'consult-xref))

(with-eval-after-load 'consult
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))
  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  (add-to-list 'consult-preview-allowed-hooks 'global-org-modern-mode-check-buffers)
  (add-to-list 'consult-preview-allowed-hooks 'global-hl-todo-mode-check-buffers)
  (add-hook 'completion-list-mode-hook #'consult-preview-at-point-mode))

;; Optionally tweak the register preview window.
;; This adds thin lines, sorting and hides the mode line of the window.
(advice-add #'register-preview :override #'consult-register-window)

(general-def global-map
 "C-x b" #'consult-buffer
 "M-g g" #'consult-line
 "C-M-l" #'consult-imenu)
(general-def minibuffer-local-map
 "C-r" #'consult-history)

(elpaca (embark
           :repo "oantolin/embark"
           :fetcher github
           :files (:defaults "embark.el" "embark-org.el" "embark.texi")))
(elpaca (embark-consult
           :repo "oantolin/embark"
           :fetcher github
           :files (:defaults "embark-consult.el")))

(setq embark-action-indicator
            (lambda (map &optional _target)
              (which-key--show-keymap "Embark" map nil nil 'no-paging)
              #'which-key--hide-popup-ignore-command)
            embark-become-indicator embark-action-indicator)
      ;; Hide the mode line of the Embark live/completions buffers
      (add-to-list 'display-buffer-alist
                   '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                     nil
                     (window-parameters (mode-line-format . none))))
(defun embark-which-key-indicator ()
    "An embark indicator that displays keymaps using which-key.
  The which-key help message will show the type and value of the
  current target followed by an ellipsis if there are further
  targets."
    (lambda (&optional keymap targets prefix)
      (if (null keymap)
          (which-key--hide-popup-ignore-command)
        (which-key--show-keymap
         (if (eq (plist-get (car targets) :type) 'embark-become)
             "Become"
           (format "Act on %s '%s'%s"
                   (plist-get (car targets) :type)
                   (embark--truncate-target (plist-get (car targets) :target))
                   (if (cdr targets) "…" "")))
         (if prefix
             (pcase (lookup-key keymap prefix 'accept-default)
               ((and (pred keymapp) km) km)
               (_ (key-binding prefix 'accept-default)))
           keymap)
         nil nil t (lambda (binding)
                     (not (string-suffix-p "-argument" (cdr binding))))))))

(setq embark-indicators
    '(embark-which-key-indicator
      embark-highlight-indicator
      embark-isearch-highlight-indicator))

  (defun embark-hide-which-key-indicator (fn &rest args)
    "Hide the which-key indicator immediately when using the completing-read prompter."
    (which-key--hide-popup-ignore-command)
    (let ((embark-indicators
           (remq #'embark-which-key-indicator embark-indicators)))
        (apply fn args)))

  (advice-add #'embark-completing-read-prompter
              :around #'embark-hide-which-key-indicator)

(with-eval-after-load 'embark
  (add-hook 'embark-collect-mode-hook 'consult-preview-at-point-mode))

(general-def global-map
 "M-]" #'embark-act
 "C-h b" #'embark-bindings)

(elpaca (corfu
         :protocol  https
         :inherit   t
         :depth     1
         :host      github
         :repo      "minad/corfu"
         :files     "extensions/*")
  (global-corfu-mode))

(elpaca (cape
         :repo      "minad/cape"
         :fetcher   github
         :files    
         (:defaults)
         :protocol  https
         :inherit   t
         :depth     1))

(custom-set-variables
 '(completion-cycle-threshold 2)
 '(tab-always-indent 'complete)
 '(corfu-auto t)
 '(corfu-auto-delay 1)
 '(corfu-auto-prefix 3)
 '(corfu-cycle t)
 '(corfu-echo-documentation t)
 '(corfu-popupinfo-delay 1)
 '(corfu-quit-at-boundary t)
 '(corfu-quit-no-match t)
 '(corfu-separator ?_))

(with-eval-after-load 'corfu
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-symbol))

(general-define-key
 :keymaps 'corfu-map
 "C-s" #'corfu-quit
 "M-t" #'corfu-popupinfo-toggle
 "M-p" #'corfu-popupinfo-scroll-up
 "M-n" #'corfu-popupinfo-scroll-down)

(custom-set-variables
 '(hippie-expand-try-functions-list
   '(yas-hippie-try-expand
     try-expand-all-abbrevs
     try-expand-dabbrev
     try-expand-dabbrev-visible
     try-completion
     try-expand-line
     try-expand-list
     try-complete-file-name
     try-complete-file-name-partially
     try-complete-lisp-symbol
     try-complete-lisp-symbol-partially)))

(general-def global-map "M-/" #'hippie-expand)

(define-skeleton src-block-el
  "Define emacs-lisp source block in org-mode."
  >"#+begin_src emacs-lisp :tangle yes"\n
  >""_ \n
  >"#+end_src"\n
  >"")

(my-leader-def "s e" #'src-block-el)

(elpaca (yasnippet
	 :repo      "joaotavora/yasnippet"
	 :fetcher   github
	 :files    
	 (:defaults "yasnippet.el" "snippets")))

(elpaca yasnippet-snippets)

(add-hook 'prog-mode-hook 'yas-minor-mode)

(elpaca anzu
  (global-anzu-mode))

(custom-set-variables
 '(anzu-modelighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => "))

(my-leader-def global-map
  "a q" #'anzu-query-replace
  "a r" #'anzu-query-replace-regexp
  "a c" #'anzu-query-replace-at-cursor)

(custom-set-variables
 '(uniquify-buffer-name-style 'reverse)
 '(uniquify-separator " • ")
 '(uniquify-after-kill-buffer-p t)
 '(uniquify-ignore-buffers-re "^\\*")
 '(ibuffer-show-empty-filter-groups nil)
 '(ibuffer-expert t)
 '(ibuffer-saved-filter-groups
   '(("default"
      ("EMACS CONFIG"
       (filename . ".emacs.d/config"))
      ("EMACS LISP"
       (mode . emacs-lisp-mode))
      ("DIRED"
       (mode . dired-mode))
      ("ORG"
       (mode . org-mode))
      ("WEBDEV"
       (or
        (mode . html-mode)
        (mode . css-mode)
        (mode . js-mode)
        (mode . ts-mode)))
      ("EPUB/PDF"
       (or
        (mode . pdf-view-mode)
        (mode . nov-mode)))
      ("EWW"
       (mode . eww-mode))
      ("HELM"
       (mode . helm-major-mode))
      ("HELP"
       (or
        (name . "\*Help\*")
        (name . "\*Apropos\*")
        (name . "\*info\*")
        (name . "\*Warnings\*")))
      ("SPECIAL BUFFERS"
       (or
        (name . "\*scratch\*")
        (name . "\*Messages\*")
        (name . "\*straight-process\*")
        (name . "\*direnv\*")))))))

(add-hook 'ibuffer-mode-hook (lambda ()
                                (ibuffer-auto-mode t)
                                (ibuffer-switch-to-saved-filter-groups "default")))

(general-define-key
 :keymaps 'global-map
 "C-x C-b" #'ibuffer)

(elpaca crux)

(with-eval-after-load 'crux
  (crux-with-region-or-buffer indent-region)
  (crux-with-region-or-buffer untabify)
  (crux-with-region-or-point-to-eol kill-ring-save)
  (defalias 'rename-file-and-buffer 'crux-rename-file-and-buffer))

(general-def global-map
  "C-a" #'crux-move-beginning-of-line
  "C-x 4 t" #'crux-transpose-windows
  "C-k" #'crux-kill-whole-line)
(my-leader-def global-map
  "c ;" #'crux-duplicate-and-comment-current-line-or-region
  "c c" #'crux-cleanup-buffer-or-region
  "c d" #'crux-duplicate-current-line-or-region
  "c f" #'crux-recentf-find-file
  "c F" #'crux-recentf-find-directory
  "c k" #'crux-kill-other-buffers
  "c r" #'crux-reopen-as-root-mode
  "c o" #'crux-smart-open-line-above)

(elpaca dired-subtree
  (require 'dired-subtree))
(elpaca diredfl
  (require 'diredfl))
(elpaca dired-sidebar
  (require 'dired-x))

(custom-set-variables
 ;; '(dired-listing-switches "-lGhA1vDpX --group-directories-first")
 '(dired-listing-switches "-alh --group-directories-first")
 '(dired-kill-when-opening-new-dired-buffer t)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always)
 '(delete-by-moving-to-trash t)
 '(dired-dwim-target t)
 '(dired-subtree-use-backgrounds nil))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)
(add-hook 'dired-mode-hook #'hl-line-mode)

(global-unset-key (kbd "C-x d"))
(general-def
  :keymaps 'global-map
 "C-x d d" #'dired
 "C-x d f" #'dired-x-find-file
 "C-x d s" #'dired-sidebar-toggle-sidebar)
(general-def
  :keymaps 'dired-mode-map
  "<tab>" #'dired-subtree-toggle
  "<backtab>" #'dired-subtree-remove
  "C-TAB" #'dired-subtree-cycle
  "M-RET" #'dired-open-file)

(defun dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (message "Opening %s..." file)
    (call-process "xdg-open" nil 0 nil file)
    (message "Opening %s done" file)))

(defun sidebar-toggle ()
  "Toggle both `dired-sidebar’ and `ibuffer-sidebar’"
  (interactive)
  (dired-sidebar-toggle-sidebar))

(elpaca exec-path-from-shell)
(elpaca envrc
  (envrc-global-mode))

(custom-set-variables
 '(direnv-always-show-summary nil)
 '(direnv-show-paths-in-summary nil)
 '(exec-path-from-shell-variables
   '("PATH" "MANPATH" "NIX_PATH" "NIX_SSL_CERT_FILE")))

(with-eval-after-load 'envrc
  (my-leader-def envrc-mode-map
    "e" #'envrc-command-map))

(elpaca expand-region)

(custom-set-variables
 '(expand-region-fast-keys-enabled nil)
 '(er--show-expansion-message t))

(general-def global-map
 "C-=" #'er/expand-region
 "C-+" #'er/contract-region)

(elpaca magit)
(my-leader-def
 :keymaps 'global-map
 "g s" #'magit-status)

(custom-set-variables
 '(search-highlight t)
 '(search-whitespace-regexp ".*?")
 '(isearch-lax-whitespace t)
 '(isearch-regexp-lax-whitespace nil)
 '(isearch-lazy-highlight t)
 '(isearch-lazy-count t)
 '(lazy-count-prefix-format nil)
 '(lazy-count-suffix-format " (%s/%s)")
 '(isearch-yank-on-move 'shift)
 '(isearch-allow-scroll 'unlimited)
 '(isearch-repeat-on-direction-change t)
 '(lazy-highlight-initial-delay 0.5)
 '(lazy-highlight-no-delay-length 3)
 '(isearch-wrap-pause t))

(general-def global-map
  "C-s" #'isearch-forward-regexp
  "C-M-s" #'isearch-forward
  "C-r" #'isearch-backward-regexp
  "C-M-r" #'isearch-backward)

(elpaca god-mode
  (god-mode))

;; (custom-set-variables
;;  '(god-exempt-major-modes nil)
;;  '(god-exempt-predicates nil))

(defun my/update-cursor-type ()
  "Change cursor type and color according to minor mode."
  (cond
   (god-local-mode
    (set-cursor-color "red")
    (setq cursor-type 'box))
   (buffer-read-only
    (set-cursor-color "gray")
    (setq cursor-type 'box))
   (t
    (set-cursor-color "green")
    (setq cursor-type '(hbar . 2)))))
(add-hook 'post-command-hook #'my/update-cursor-type)

(general-def global-map "<escape>" #'god-local-mode)
(general-def god-local-mode-map
  "." #'repeat
  "i" #'god-local-mode)

(elpaca rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(elpaca smartparens
  (require 'smartparens-config)
  (smartparens-global-mode 1))
(custom-set-variables
 '(smartparens-strict-mode nil))

(setenv "PAGER" "cat")

;; Save command history when commands are entered
(add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

(add-hook 'eshell-before-prompt-hook
	  (lambda ()
	    (setq xterm-color-preserve-properties t)))

(setq eshell-prompt-function
      (lambda ()
	(concat (format-time-string "%Y-%m-%d %H:%M" (current-time))
		(if (= (user-uid) 0) " # " " λ "))))

(setq eshell-aliases-file   (concat eshell-directory-name "aliases"))

(custom-set-variables
 '(eshell-prompt-regexp                    "^[^λ]+ λ ")
 '(eshell-history-size                     1024)
 '(eshell-buffer-maximum-lines             10000)
 '(eshell-hist-ignoredups                  t)
 '(eshell-highlight-prompt                 t)
 '(eshell-prefer-lisp-functions            nil)
 '(eshell-scroll-to-bottom-on-input        'all)
 '(eshell-error-if-no-glob                 t)
 '(eshell-destroy-buffer-when-process-dies t))

(defun rx/eshell-clear ()
  "Clear the eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(add-hook 'eshell-mode-hook
	  (lambda ()
	    (add-to-list 'eshell-visual-commands "ssh")
	    (add-to-list 'eshell-visual-commands "tail")
	    (add-to-list 'eshell-visual-commands "top")
	    ;; Aliases
	    (eshell/alias "clear" "rx/eshell-clear")))

(add-hook 'eshell-mode-hook 'eshell-fringe-status-mode)

(elpaca vterm)
(general-def global-map
  "C-M-<return>" #'vterm-other-window)

(elpaca vundo)

(with-eval-after-load 'vundo
    (setq vundo-glyph-alist vundo-unicode-symbols)
    (set-face-attribute 'vundo-default nil :family "Symbola"))

(general-def global-map "C-x u" #'vundo)

(elpaca which-key
  (which-key-mode t))

(custom-set-variables
 '(which-key-idle-delay 3)
 '(which-key-enable-extended-define-key t)
 '(which-key-side-window-max-width 0.33)
 '(which-key-show-early-on-C-h t)
 '(which-key-show-major-mode t)
 '(which-key-popup-type 'minibuffer)
 '(which-key-side-window-location 'bottom)
 ;; '(which-key-sort-order 'which-key-local-then-key-order)
 '(which-key-sort-order 'which-key-key-order-alpha))

(elpaca ace-window)

(setq aw-keys '(?1 ?2 ?3 ?4 ?5))
(general-define-key
 :keymaps 'global-map
 [remap other-window] #'ace-window
 "s-o" #'ace-window
 "C-;" #'avy-goto-char
 "C-:" #'avy-goto-word-or-subword-1)

(elpaca windresize)
(my-leader-def global-map
  "r" #'windresize)

(defun split-and-follow-horizontally ()
    (interactive)
    (split-window-below)
    (balance-windows)
    (other-window 1))

  (defun split-and-follow-vertically ()
    (interactive)
    (split-window-right)
    (balance-windows)
    (other-window 1))

(general-def global-map
  "C-x C-2" #'split-and-follow-horizontally
  "C-x C-3" #'split-and-follow-vertically
  "C-x K" #'kill-buffer-and-window)

(customize-set-variable
 'display-buffer-alist
 '(("\\*e?shell\\*"
    (display-buffer-in-side-window)
    (window-height . 0.3)
    (side . bottom)
    (slot . 1))
   ("\\*\\(ansi-term\\|vterm\\)\\*"
    (display-buffer-in-side-window)
    (window-width . 0.45)
    (side . right)
    (slot . 1))
   ("\\*[Hh]elp\\|[Mm]etahelp\\*"
    (display-buffer-in-side-window)
    (window-height . 0.25)
    (side . bottom)
    (slot . 1))
   ("\\*\\(Backtrace\\|Warnings\\|Compile-Log\\|Messages\\)\\*"
    (display-buffer-in-side-window)
    (window-height . 0.25)
    (side . bottom)
    (slot . 0))
   ("\\*Faces\\*"
    (display-buffer-in-side-window)
    (window-height . 0.25)
    (side . bottom)
    (slot . 1))
   ("\\*contents\\*"
    (display-buffer-in-side-window)
    (window-height . 0.25)
    (side . bottom)
    (slot . 2))))

(elpaca rustic)
(custom-set-variables
 '(rustic-lsp-client 'eglot)
 '(rust-format-on-save t))
(add-hook 'rustic-mode-hook 'eglot-ensure)

(elpaca zig-mode)
(add-to-list 'auto-mode-alist '("\\.zig\\’" . zig-mode))
(add-hook 'zig-mode-hook 'eglot-ensure)

(add-to-list 'auto-mode-alist '("\\.sh\\’" . sh-mode))
(add-hook 'sh-mode-hook 'eglot-ensure)

(elpaca json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

(elpaca markdown-mode)

(add-to-list 'auto-mode-alist '("\\.\\(?:md\\|markdown\\|mkd\\)\\'" . markdown-mode))

(elpaca nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\’" . nix-mode))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(nix-mode . ("nil"))))
(add-hook 'nix-mode-hook 'eglot-ensure)

(elpaca toml-mode)
(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-mode))

(elpaca yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

(elpaca org-contrib)
(custom-set-variables
 '(org-directory "~/doc/org/")
 '(org-startup-with-inline-images (display-graphic-p))
 '(org-startup-align-all-tables t)
 '(org-use-speed-commands t)
 '(org-use-fast-todo-selection 'expert)
 '(org-fast-tag-selection-single-key 'expert)
 '(org-hide-emphasis-markers t)
 '(org-adapt-indentation t)
 '(org-confirm-babel-evaluate t)
 '(org-pretty-entities t)
 '(org-support-shift-select t)
 '(org-edit-src-content-indentation 2)
 '(org-src-tab-acts-natively t)
 '(org-src-fontify-natively t)
 '(org-src-preserve-indentation nil)
 '(org-src-window-setup 'current-window)
 '(org-src-strip-leading-and-trailing-blank-lines t)
 '(org-todo-keywords
   '((sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")
     (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)"))))

(add-hook 'org-mode-hook (lambda ()
                           (org-indent-mode)
                           (auto-fill-mode)
                           (org-superstar-mode)))

(elpaca org-superstar)
(custom-set-variables
 '(org-superstar-headline-bullets-list
   ;; '("☰" "☷" "☵" "☲"  "☳" "☴"  "☶"  "☱")
   '("◉" "●" "○" "○" "○" "○" "○"))
 '(org-superstar-leading-bullet " "))

(elpaca denote)

(custom-set-variables
 '(denote-directory "~/doc/denote")
 '(denote-rename-buffer-mode t)
 '(denote-infer-keywords t)
 '(denote-sort-keywords t)
 '(denote-backlinks-show-context t)
 '(denote-known-keywords '("nixos" "code" "work"))
 '(denote-file-type nil))

(add-hook 'find-file-hook 'denote-link-buttonize-buffer)
(add-hook 'dired-mode-hook 'denote-dired-mode)

(my-leader-def
  :keymaps 'global-map
  "n j" #'my-denote-journal
  "n n" #'denote
  "n z" #'denote-signature 		;zettelkasten mnemonic
  "n t" #'denote-template
  "n N" #'denote-type
  "n d" #'denote-date
  "n s" #'denote-subdirectory
  "n i" #'denote-link
  "n I" #'denote-link-add-links
  "n f f" #'denote-link-find-file
  "n f b" #'denote-link-find-backlink
  "n r" #'denote-rename-file
  "n R" #'denote-rename-file-using-front-matter)

(defun my-denote-journal ()
  "Create an entry tagged 'journal' with the date as its title.
If a journal for the current day exists, visit it.  If multiple
entries exist, prompt with completion for a choice between them.
Else create a new file."
  (interactive)
  (let* ((today (format-time-string "%A %e %B %Y"))
         (string (denote-sluggify today))
         (files (denote-directory-files-matching-regexp string)))
    (cond
     ((> (length files) 1)
      (find-file (completing-read "Select file: " files nil :require-match)))
     (files
      (find-file (car files)))
     (t
      (denote
       today
       '("journal"))))))

(setq custom-file (expand-file-name "customs.el" user-emacs-directory))
;; (add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

;;; config.el ends here.
