;;; .gnus.el --- GNUS Configuration -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Miguel Suarez
;;
;; Author: Miguel Suarez <suarezmiguelc@icloud.com>
;; Maintainer: Miguel Suarez <suarezmiguelc@icloud.com>
;; Created: October 10, 2023
;; Modified: October 10, 2023
;; Version: 0.0.1
;; Keywords: Symbol窶冱 value as variable is void: finder-known-keywords
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
;; Both IMAP and SMTP configuration require Application Passwords
;;
;; IMAP, Fetching Mail

(setq gnus-select-method
      '(nnimap "Icloud Personal"
        (nnimap-address "imap.mail.me.com")
        (nnimap-inbox "INBOX")
        (nnimap-user "suarezmiguelc@icloud.com")
        (nnimap-server-port "imaps")))

(setq my-email-accounts
      '(
        ("Gmail Personal"
         (nnimap-address "imap.gmail.com")
         (nnimap-inbox "INBOX")
         (nnimap-user "suarezmiguelc23@gmail.com")
         (nnimap-server-port "imaps"))

        ("Gmail Immune"
         (nnimap-address "imap.gmail.com")
         (nnimap-inbox "INBOX")
         (nnimap-user "miguel.suarez.cso@immune.institute")
         (nnimap-server-port "imaps"))

        ("Moveecar"
         (nnimap-address "imap.gmail.com")
         (nnimap-inbox "INBOX")
         (nnimap-user "miguelangel.suarezcalles@moveecar.com")
         (nnimap-server-port "imaps"))

        ("DimaticaSoftware"
         (nnimap-address "imap.gmail.com")
         (nnimap-inbox "INBOX")
         (nnimap-user "masuarezcalles@dimaticasoftware.com")
         (nnimap-server-port "imaps"))
        ))

(cl-loop for (account-name . account-details) in my-email-accounts
         do (add-to-list 'gnus-secondary-select-methods
                         `(nnimap ,account-name ,@account-details)))

;; SMTP, Sending Mail

(setq send-mail-function (quote smtpmail-multi-send-it))
(setq message-send-mail-function (quote smtpmail-multi-send-it))

;; Gmail headers
(setq gnus-extra-headers
      '(To Newsgroups X-GM-LABELS))

;; Allows us to Reply with the email where we received said message

(setq gnus-posting-styles
      '((".*"
         (signature "Miguel Suárez."))
        ((header "to" "masuarezcalles@dimaticasoftware.com")
         (address "masuarezcalles@dimaticasoftware.com"))
        ((header "to" "suarezmiguelc@icloud.com")
         (address "suarezmiguelc@icloud.com"))
        ((header "to" "suarezmiguelc23@gmail.com")
         (address "suarezmiguelc23@gmail.com"))
        ((header "to" "miguel.suarez.cso@immune.institute")
         (address "miguel.suarez.cso@immune.institute"))
        ((header "to" "miguelangel.suarezcalles@moveecar.com")
         (address "miguelangel.suarezcalles@moveecar.com"))
        ))

;; SMTP-multi for separating allowing SMTP separation

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(require 'smtpmail-multi)

(setq my-smtp-accounts
      '(
        (icloud . ("suarezmiguelc@icloud.com"
                   "smtp.mail.me.com"
                   587
                   "suarezmiguelc@icloud.com"
                   starttls nil nil nil))

        (gmailPersonal . ("suarezmiguelc23@gmail.com"
                          "smtp.gmail.com"
                          587
                          "suarezmiguelc23@gmail.com"
                          starttls nil nil nil))

        (gmailImmune . ("miguel.suarez.cso@immune.institute"
                        "smtp.gmail.com"
                        587
                        "miguel.suarez.cso@immune.institute"
                        starttls nil nil nil))

        (gmailDimatica . ("masuarezcalles@dimaticasoftware.com"
                          "smtp.gmail.com"
                          587
                          starttls nil nil nil))

        (gmailMoveecar . ("miguelangel.suarezcalles@moveecar.com"
                          "smtp.gmail.com"
                          587
                          starttls nil nil nil))))

(cl-loop for (account-name . account-details) in my-smtp-accounts
         do (add-to-list 'smtpmail-multi-accounts
                         `(,account-name . ,account-details)))

(cl-loop for (email-address . account-name) in '(("masuarezcalles@dimaticasoftware.com" . gmailDimatica)
                                                 ("miguelangel.suarezcalles@moveecar.com" . gmailMoveecar)
                                                 ("suarezmiguelc@icloud.com" . icloud)
                                                 ("suarezmiguelc23@gmail.com" . gmailPersonal)
                                                 ("miguel.suarez.cso@immune.institute" . gmailImmune))
         do (add-to-list 'smtpmail-multi-associations `(,email-address ,account-name)))


(setq smtpmail-servers-requiring-authorization "\\.com")

(setq nnfolder-directory "/Users/niguelalgelsuarezcalles/Library/Mobile Documents/com~apple~CloudDocs/メール")

;; More Sending configurations
(require 'org-mime)
(setq org-mime-library 'mml)
(add-hook 'message-send-hook 'org-mime-confirm-when-no-multipart)
(setq gnus-dribble-ignore t)



;; Notify and scan every 2 minutes
;; Done by doom modeline
(gnus-demon-add-handler 'gnus-demon-scan-news 2 t)
(require 'gnus-desktop-notify)
(setq gnus-desktop-notify-function 'gnus-desktop-notify-exec
      gnus-desktop-notify-exec-program "growlnotify -a Emacs.app -m")
(gnus-desktop-notify-mode)
(gnus-demon-add-scanmail)


(provide '.gnus)
;;; .gnus.el ends here
