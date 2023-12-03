;;; .gnus.el --- GNUS Configuration -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Miguel Suarez
;;
;; Author: Miguel Suarez <suarezmiguelc@icloud.com>
;; Maintainer: Miguel Suarez <suarezmiguelc@icloud.com>
;; Created: October 10, 2023
;; Modified: October 10, 2023
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/MinallW/.gnus
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  GNUS Configuration
;;
;;; Code:
;;; RSS Servers
;; Reading Mail

(add-to-list 'gnus-secondary-select-methods
             '(nnimap "imap.mail.me.com"
               (nnimap-inbox "INBOX")
               (nnimap-user "suarezmiguelc@icloud.com")
               (nnimap-server-port "imaps")
               ))

(add-to-list 'gnus-secondary-select-methods
             '(nnimap "imap.gmail.com"
               (nnimap-inbox "INBOX")
               (nnimap-user "suarezmiguelc23@gmail.com")
               (nnimap-server-port "imaps")
               ))

;; Specify msmtp since OMG how can't one define different smtp servers in the library?
(setq gnus-posting-styles
      '((".*"
         (signature "Miguel Suárez."))))

;; Sending mail
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(require 'smtpmail-multi)

(add-to-list 'smtpmail-multi-accounts
             '(icloud . ("suarezmiguelc@icloud.com"
                         "smtp.mail.me.com"
                         587
                         "suarezmiguelc@icloud.com"
                         starttls nil nil nil)))

(add-to-list 'smtpmail-multi-accounts
             '(gmail . ("suarezmiguelc23@gmail.com"
                        "smtp.gmail.com"
                        587
                        "suarezmiguelc23@gmail.com"
                        starttls nil nil nil)))

(add-to-list 'smtpmail-multi-associations '("suarezmiguelc@icloud.com" icloud))
(add-to-list 'smtpmail-multi-associations '("suarezmiguelc23@gmail.com" gmail))

(setq smtpmail-servers-requiring-authorization "\\.com")

(setq nnfolder-directory "/Users/niguelalgelsuarezcalles/Library/Mobile Documents/com~apple~CloudDocs/メール")

;; More Sending configurations
(require 'org-mime)
(setq org-mime-library 'mml)
(add-hook 'message-send-hook 'org-mime-confirm-when-no-multipart)
(setq gnus-dribble-ignore t)

;; Notify and scan every 2 minutes
;; Done by doom modeline
;; (gnus-demon-add-handler 'gnus-demon-scan-news 2 t)
;; (require 'gnus-desktop-notify)
;; (setq gnus-desktop-notify-function 'gnus-desktop-notify-exec
;;       gnus-desktop-notify-exec-program "growlnotify -a Emacs.app -m")
;; (gnus-desktop-notify-mode)
;; (gnus-demon-add-scanmail)


(provide '.gnus)
;;; .gnus.el ends here
