;; Added by Package.el.  This must come before configurations of
;; Installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(defmacro append-to-list (to lst) `(setq-default ,to (append ,lst , to)))

(setq-default tab-width 8
              default-tab-width 8
              c-basic-offset 2
              c-tab-offset tab-width
              c-auto-newline nil
              c-tab-always-indent t
              indent-tabs-mode nil
              rust-indent-offset 2)
(set-default-coding-systems 'utf-8)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq-default default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; indent setting
(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))
(setq-default web-mode-markup-indent-offset 2)
;; (setq-default display-buffer-function 'popwin:display-buffer)

(defun my-c-mode-common-hook ()
  (c-set-offset 'case-label 0)
  (c-set-offset 'inextern-lang 0))
(add-hook 'c-mode-common-hook #'my-c-mode-common-hook)
(add-hook 'c-mode-common-hook #'google-set-c-style)

(savehist-mode t)

;; whitespace setting
(setq-default show-trailing-whitespace t)
(setq-default whitespace-style '(tabs tab-mark spaces space-mark))
(setq-default whitespace-space-regexp "\\([\x3000\t]+\\)")
(setq-default whitespace-display-mappings
              '((space-mark ?\x3000 [?\xBB ?\x20])
                (tab-mark   ?\t     [?\xBB ?\t])
                ))
(global-whitespace-mode t)

;; window system setting
(cond (window-system
       (tool-bar-mode -1)
       (scroll-bar-mode -1)
       (setq-default default-frame-alist
                     '((width . 200) (height . 148)
                       (top . 0) (left . 0)))
       (set-default-font "IPAGothic-9:spacing=0")))

;; transient-mark-mode
(transient-mark-mode t)

;; inhibit-startup-screen
(setq-default inhibit-startup-screen t)

;; emacs server
(server-start)

;; don't remind me with down/upcase-region
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; mouse
(require 'mouse)
(xterm-mouse-mode t)
(setq-default x-select-enable-clipboard t)
(require 'mwheel)
(mouse-wheel-mode t)
(setq-default mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; scroll
(setq-default scroll-conservatively 1)
(setq-default scroll-step 1)
(setq-default next-screen-context-lines 3)

;; mode line
(column-number-mode t)
(display-time-mode t)
(require 'battery)
(when (and battery-status-function
           (not (string-match-p
                 "N/A"
                 (battery-format
                  "%B"
                  (funcall battery-status-function)))))
  (display-battery-mode 1))
(line-number-mode t)
(setq-default git-state-modeline-decoration 'git-state-decoration-colored-letter)

;; menu bar
(menu-bar-mode 0)

;; delete-selection-mode
(delete-selection-mode t)

;; modes
(append-to-list auto-mode-alist
                '(("emacs" . emacs-lisp-mode)
                  ("\\.yml$" . yaml-mode)
                  ("\\.command$" . shell-mode)
                  ("zshrc" . shell-script-mode)
                  ("\\.js$" . js2-mode)
                  ("\\.h$" . c++-mode)
                  ("\\.html\\.erb$" . web-mode)
                  ("\\.json_schema$" . json-mode)))

;; compilation buffer
(defun run-last-compile ()
  (interactive)
  (if compile-history
      (setq compile-command '(first compile-history)))
  (recompile))
(setq-default compilation-scroll-output t)
(global-set-key (kbd "C-c c") 'run-last-compile)
(global-set-key (kbd "C-c n") 'next-error)
(global-set-key (kbd "C-c p") 'previous-error)
(require 'ansi-color)
(add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)
(defun my-compilation-filter-hook ()
  (ansi-color-apply-on-region (point-min) (point-max)))
(add-hook 'compilation-filter-hook #'my-compilation-filter-hook)

;; eshell
(require 'eshell)
(defun my-eshell-prompt ()
  (concat
   (user-login-name) "@" (system-name) " "
   "(" (vc-mode-line (eshell/pwd)) ") "
   (eshell/pwd) " "
   (if (= (user-uid) 0) "#" "$")
   " "
   ))
(setq-default eshell-hist-ignoredups t eshell-history-size 1000
              eshell-output-filter-functions (list
                                              'eshell-handle-ansi-color
                                              'eshell-handle-control-codes
                                              'eshell-watch-for-password-prompt)
              eshell-prompt-function #'my-eshell-prompt
              )
              ;; system-uses-terminfo nil)
(add-hook 'eshell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'term-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-output-filter-functions #'comint-truncate-buffer)

(setq-default read-file-name-completion-ignore-case nil
              read-buffer-completion-ignore-case nil)

;; visible bell
(setq-default visible-bell t)

(setq-default truncate-partial-width-windows nil)
(setq-default truncate-lines nil)

;; window
(defun my-next-window ()
  (interactive)
  (when (one-window-p) (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-t") #'my-next-window)
(global-set-key (kbd "C-c <up>") #'windmove-up)
(global-set-key (kbd "C-c <down>") #'windmove-down)
(global-set-key (kbd "C-c <right>") #'windmove-right)
(global-set-key (kbd "C-c <left>") #'windmove-left)

;; C-r replace-regexp
(global-unset-key (kbd "C-r"))
(global-set-key (kbd "C-r") 'replace-regexp)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)

;; ruby
(setq-default ruby-indent-level 2 ruby-indent-tabs-mode nil)
(append-to-list auto-mode-alist '(("Rakefile" . ruby-mode)
                                  ("\\.rake$" . ruby-mode)
                                  ("\\.gembox$" . ruby-mode)
                                  ("Gemfile" . ruby-mode)))
(add-hook 'ruby-mode-hook
          '(lambda()
             (when (>= emacs-major-version 24)
               (set (make-local-variable 'electric-pair-mode) nil))
             (ruby-electric-mode t)))

;; recentf
(require 'recentf)
(recentf-mode t)

;; electric
(require 'electric)
(electric-pair-mode t)
(electric-indent-mode t)

;; linum-mode
(require 'linum)
(global-linum-mode t)
(defun my-linum-disable-hook ()
  (linum-mode 0))
(dolist (h '(eshell-mode-hook
             message-mode magit-status-mode-hook magit-mode-hook
             erc-mode-hook term-mode-hook compilation-mode-hook Man-mode-hook
             eww-mode-hook))
  (add-hook h #'my-linum-disable-hook))

;; eww
(require 'eww)
(setq eww-search-prefix "https://www.google.com/search?hl=en&q=")
(defun my-eww-mode-hook ()
  (linum-mode 0)
  (setq show-trailing-whitespace nil))
(add-hook 'eww-mode-hook #'my-eww-mode-hook)
(defun eww-new ()
  (interactive)
  (let ((url (read-from-minibuffer "Enter URL or keywords: ")))
    (switch-to-buffer (generate-new-buffer "*eww*"))
    (eww-mode)
    (eww url)))
(global-set-key (kbd "C-c e") #'eww-new)

;; log setting
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))

;; turnip setting
(add-to-list 'auto-mode-alist '("\\.feature\\'" . yaml-mode))

;; helm-git-grep
(global-set-key (kbd "C-c g g") #'helm-git-grep)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(company-idle-delay 0.2)
 '(js-indent-level 2)
 '(magit-diff-section-arguments (quote ("--no-ext-diff")))
 '(package-selected-packages
   (quote
    (twittering-mode company helm-git-grep cider helm web-mode typescript-mode elm-mode wandbox xterm-color editorconfig apache-mode tablist ruby-mode magit inf-ruby haskell-mode gh emmet-mode auto-complete yari yaml-mode workgroups2 wgrep undohist undo-tree toml-mode switch-window smart-cursor-color sane-term rust-mode ruby-electric php-mode pdf-tools pbcopy paredit org-ac open-junk-file nlinum multi-term minibuf-isearch milkode markdown-mode magit-gitflow magit-gh-pulls magit-filenotify lua-mode json-mode js2-mode highlight-indentation google-c-style go-mode glsl-mode git-gutter git-blamed gist ghc flymake-ruby flymake-lua flymake-coffee flycheck-rust flycheck-haskell express dtrt-indent d-mode csv cssh coffee-mode cmake-mode clang-format alert ac-math ac-inf-ruby ac-etags ac-emmet))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)

(dolist (elem package-selected-packages) (package-install elem))

(use-package multi-term
  :init
  ;; terminal setting
  (require 'multi-term)
  (setq-default term-scroll-to-bottom-on-output t)
  (setq-default term-scroll-show-maximum-output t)
  (append-to-list term-bind-key-alist
                  '(("M-<right>" . term-send-forward-word)
                    ("C-<right>" . term-send-forward-word)
                    ("M-<left>" . term-send-backward-word)
                    ("C-<left>" . term-send-backward-word)
                    ("C-c C-c" . 'term-interrupt-subjob)
                    ("M-f" . 'term-send-forward-word)
                    ("M-b" . 'term-send-backward-word)
                    ("C-c C-j" . 'term-line-mode)
                    ("C-c C-k" . 'term-char-mode)
                    ("M-DEL" . 'term-send-backward-kill-word)
                    ("M-d" . 'term-send-forward-kill-word)
                    ("C-r" . 'term-send-reverse-search-history)
                    ("M-p" . 'term-send-raw-meta)
                    ("M-y" . 'term-send-raw-meta)
                    ("C-y" . 'term-send-raw)
                    ))
  (append-to-list term-unbind-key-list '("C-r"))
  (defun my-term-mode-hook ()
    (setq show-trailing-whitespace nil))
  (add-hook 'term-mode-hook #'my-term-mode-hook)
  (defun comint-fix-window-size ()
    "Change process window size."
    (when (derived-mode-p 'comint-mode)
      (let ((process (get-buffer-process (current-buffer))))
        (unless (eq nil process)
          (set-process-window-size process (window-height) (window-width))))))
  (defun my-shell-mode-hook ()
    ;; add this hook as buffer local, so it runs once per window.
    (add-hook 'window-configuration-change-hook 'comint-fix-window-size nil t))
  (add-hook 'shell-mode-hook 'my-shell-mode-hook)
  )

(use-package dtrt-indent
  :init
  (dtrt-indent-mode t))

;; git-gutter
(use-package git-gutter
  :init
  (git-gutter:linum-setup)
  (global-git-gutter-mode t))

;; pbcopy
(use-package pbcopy
  :init
  (turn-on-pbcopy))

(use-package desktop
  :init
  (desktop-save-mode t))
(use-package workgroups2
  :init
  (workgroups-mode t))

;; smart-cursor-color
(use-package smart-cursor-color
  :init
  (global-hl-line-mode t)
  (smart-cursor-color-mode t))

;; company
(use-package company
  :init
  (global-company-mode t)
  (global-set-key (kbd "C-TAB") #'company-complete))

;; magit
(use-package magit
  :init
  (global-set-key (kbd "C-x g") 'magit-status)
  (setq magit-auto-revert-mode nil))

(use-package flymake-ruby
  :init
  (add-hook 'ruby-mode-hook 'flymake-ruby-load)
  (setq-default ruby-insert-encoding-magic-comment nil))

;; editorconfig
(use-package editorconfig
  :init
  (editorconfig-mode 1))

;; flycheck
(use-package flycheck
  :init
  (global-flycheck-mode t))
