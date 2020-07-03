;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(let* ((org-dir (expand-file-name
                 "lisp" (expand-file-name
                         "org" (expand-file-name
                                "src" dotfiles-dir))))
       (org-contrib-dir (expand-file-name
                         "lisp" (expand-file-name
                                 "contrib" (expand-file-name
                                            ".." org-dir))))
       (load-path (append (list org-dir org-contrib-dir)
                          (or load-path nil))))
  ;; load up Org-mode and Org-babel
  (require 'org-install)
  (require 'ob-tangle))

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))

;;; init.el ends here

(defun load-directory (dir)
  (let ((load-it (lambda (f)
		   (load-file (concat (file-name-as-directory dir) f)))
		 ))
    (mapc load-it (directory-files dir nil "\\.el$"))))




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
 '(package-selected-packages
   (quote
    (rvm web-mode use-package ruby-test-mode ruby-electric rubocop robe powerline memoize lua-mode impatient-mode gruvbox-theme ercn erc-hl-nicks emmet-mode company-web ace-window)))
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
