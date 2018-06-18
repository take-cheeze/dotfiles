;; Added by Package.el.  This must come before configurations of
;; Installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(defmacro append-to-list (to lst)
  `(setq-default ,to (append ,lst , to)))

(set-default-coding-systems 'utf-8)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq-default default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get-bundle git-modeline
  (setq-default git-state-modeline-decoration 'git-state-decoration-colored-letter))

;; indent setting
(defun indent-buffer ()
  "Indent whole buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defun my-c-mode-common-hook ()
  "Customize indent on C mode."
  (c-set-offset 'case-label 0)
  (c-set-offset 'inextern-lang 0))
(add-hook 'c-mode-common-hook #'my-c-mode-common-hook)
(add-hook 'c-mode-common-hook #'google-set-c-style)

(savehist-mode t)

;; whitespace setting
(global-whitespace-mode t)

;; transient-mark-mode
(transient-mark-mode t)

;; emacs server
(server-start)

;; don't remind me with down/upcase-region
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

;; mouse
(require 'mouse)
(xterm-mouse-mode t)
(require 'mwheel)
(mouse-wheel-mode t)

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

;; window configurations
(desktop-save-mode 1)

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
  "Run compilation with last command."
  (interactive)
  (when compile-history
      (setq compile-command '(first compile-history)))
  (recompile))
(global-set-key (kbd "C-c c") 'run-last-compile)
(global-set-key (kbd "C-c n") 'next-error)
(global-set-key (kbd "C-c p") 'previous-error)
(require 'ansi-color)
(add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)
(defun my-compilation-filter-hook ()
  "Apply ansi colors to compilation buffer."
  (ansi-color-apply-on-region (point-min) (point-max)))
(add-hook 'compilation-filter-hook #'my-compilation-filter-hook)

;; eshell
(require 'eshell)
(defun my-eshell-prompt ()
  "Custom eshell prompt."
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

;; window
(defun my-next-window ()
  "Search next window."
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
  "Disable linum mode in specific modes."
  (linum-mode 0))
(dolist (h '(eshell-mode-hook
             message-mode magit-status-mode-hook magit-mode-hook
             erc-mode-hook term-mode-hook compilation-mode-hook Man-mode-hook
             eww-mode-hook))
  (add-hook h #'my-linum-disable-hook))
(set-face-foreground 'linum "cyan")

(global-eldoc-mode -1)

;; eww
(require 'eww)
(defun my-eww-mode-hook ()
  "Workaround of eww views."
  (linum-mode 0)
  (setq show-trailing-whitespace nil))
(add-hook 'eww-mode-hook #'my-eww-mode-hook)
(add-hook 'eww-bookmark-mode-hook #'my-eww-mode-hook)
(defun eww-new ()
  "Open new eww buffer."
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

;; vc-mode
(global-set-key (kbd "C-c g g") #'vc-git-grep)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 2)
 '(c-tab-always-indent t)
 '(coffee-tab-width 2)
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-semantic company-capf company-files
                  (company-dabbrev-code company-gtags company-etags company-keywords)
                  company-oddmuse company-dabbrev company-abbrev company-ansible company-inf-ruby company-bibtex company-c-headers company-dict company-emoji company-erlang company-go company-lua company-math-symbols-latex company-math-symbols-unicode company-ngram-backend
                  (company-shell company-shell-env company-fish-shell)
                  company-web-html company-web-jade company-web-slim company-terraform)))
 '(company-idle-delay 0.2)
 '(compilation-scroll-output t)
 '(desktop-restore-frames t)
 '(eww-search-prefix "https://www.google.com/search?hl=en&q=")
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(magit-auto-revert-mode nil)
 '(magit-diff-section-arguments (quote ("--no-ext-diff")))
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1))))
 '(next-screen-context-lines 3)
 '(package-selected-packages
   (quote
    (flycheck-elm twittering-mode company helm-git-grep cider helm web-mode typescript-mode elm-mode wandbox xterm-color editorconfig apache-mode tablist ruby-mode magit inf-ruby haskell-mode gh emmet-mode auto-complete yari yaml-mode wgrep undohist undo-tree toml-mode switch-window smart-cursor-color sane-term rust-mode ruby-electric php-mode pdf-tools pbcopy paredit org-ac open-junk-file nlinum multi-term minibuf-isearch milkode magit-gitflow magit-gh-pulls magit-filenotify lua-mode json-mode js2-mode highlight-indentation google-c-style go-mode glsl-mode git-gutter git-blamed gist ghc flycheck-rust flycheck-haskell express dtrt-indent d-mode csv cssh coffee-mode cmake-mode clang-format alert company-ansible company-bibtex company-c-headers company-dict company-emoji company-erlang company-glsl company-go company-inf-ruby company-lua company-math company-nginx company-ngram company-quickhelp company-shell company-terraform company-web)))
 '(read-buffer-completion-ignore-case nil)
 '(read-file-name-completion-ignore-case nil)
 '(ruby-indent-level 2)
 '(ruby-indent-tabs-mode nil)
 '(ruby-insert-encoding-magic-comment nil)
 '(rust-indent-offset 2)
 '(scroll-conservatively 1)
 '(scroll-step 1)
 '(select-enable-clipboard t)
 '(show-trailing-whitespace t)
 '(tab-width 8)
 '(term-scroll-show-maximum-output t)
 '(term-scroll-to-bottom-on-output t)
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil)
 '(vc-follow-symlinks t)
 '(visible-bell t)
 '(web-mode-markup-indent-offset 2)
 '(whitespace-display-mappings (quote ((space-mark 12288 [187 32]) (tab-mark 9 [187 9]))))
 '(whitespace-space-regexp "\\([　	]+\\)")
 '(whitespace-style (quote (tabs tab-mark spaces space-mark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(package-install-selected-packages)

(use-package multi-term
  :config
  ;; terminal setting
  (require 'multi-term)
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

(use-package twittering-mode
  :config
  (add-hook 'twittering-mode-hook #'my-eww-mode-hook))

(use-package flycheck-elm
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

(use-package dtrt-indent
  :config
  (dtrt-indent-mode t))

(use-package git-gutter
  :config
  (git-gutter:linum-setup)
  (global-git-gutter-mode t))

(use-package pbcopy
  :config
  (turn-on-pbcopy))

(use-package smart-cursor-color
  :config
  (global-hl-line-mode t)
  (smart-cursor-color-mode t))

(use-package company
  :config
  (global-company-mode t)
  (global-set-key (kbd "C-TAB") #'company-complete))

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package editorconfig
  :config
   (editorconfig-mode 1))

(use-package flycheck
  :config
  (global-flycheck-mode t))

(use-package ruby-mode
  :config
  (append-to-list auto-mode-alist '(("Rakefile" . ruby-mode)
                                    ("\\.rake$" . ruby-mode)
                                    ("\\.gembox$" . ruby-mode)
                                    ("Gemfile" . ruby-mode)))
  (add-hook 'ruby-mode-hook
       '(lambda()
             (when (>= emacs-major-version 24)
                  (set (make-local-variable 'electric-pair-mode) nil))
             (ruby-electric-mode t))))

(use-package elm-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.elm\.erb$" . elm-mode)))

(use-package company-nginx
  :ensure t
  :config
  (eval-after-load 'nginx-mode
    '(add-hook 'nginx-mode-hook #'company-nginx-keywords)))
