(package-initialize)

(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(use-package gruvbox-theme
  :ensure t)

(use-package ace-window
  :ensure t
  :bind ("M-o" . ace-window))


(use-package powerline
  :ensure t
  :init (powerline-center-theme))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(confirm-kill-processes nil)
 '(custom-enabled-themes (quote (gruvbox)))
 '(custom-safe-themes
   (quote
    ("1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" "b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" default)))
 '(display-line-numbers-type (quote visual))
 '(display-time-mode t)
 '(electric-pair-mode t)
 '(erc-autojoin-channels-alist (quote (("hyperbola"))))
 '(erc-autojoin-mode t)
 '(erc-away-nickname nil)
 '(erc-modules
   (quote
    (autojoin button completion log notifications services sound stamp spelling hl-nicks ercn netsplit fill match track readonly networks ring noncommands irccontrols move-to-prompt menu list)))
 '(erc-nick "minall")
 '(erc-port 6667)
 '(erc-prompt-for-password nil)
 '(erc-server "irc.freenode.net")
 '(fringe-mode 0 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(menu-bar-mode nil)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (lisp . t) (C . t) (ruby . t))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(web-mode-code-indent-offset 2 t)
 '(web-mode-enable-current-column-highlight t t)
 '(web-mode-markup-indent-offset 2 t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 98 :width normal)))))

(use-package company
  :ensure t
  :init (global-company-mode))

(use-package emmet-mode
  :ensure t
  :init
  (setq emmet-indentation 2)
  (setq emmet-move-cursor-between-quotes t)
  :hook ((css-mode) (sgml-mode)))

(use-package company-web
  :ensure t
  :config
  (add-to-list 'company-backends 'company-web-html)
  (add-to-list 'company-backends 'company-web-jade)
  (add-to-list 'company-backends 'company-web-slim)
  :hook company)

(use-package impatient-mode
  :ensure t)

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ;; Also handle undocumented (<active> <inactive>) form.
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 '(95 . 95) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(use-package ruby-electric 
:ensure t
:hook (ruby-mode . ruby-electric-mode))

(use-package ruby-mode
:ensure t)
