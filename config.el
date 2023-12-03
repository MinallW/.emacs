;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light))
;; Easy on the eyes
(setq doom-theme 'doom-gruvbox)
(setq display-line-numbers-type 'visual)
;; Some Globals
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . js-jsx-mode))
(setq auth-sources '("~/.authinfo"))
(require 'epa-file)
(custom-set-variables '(epg-gpg-program  "~/.nix-profile/bin/gpg"))
(epa-file-enable)
;; Fix macos gnupg bug

(fset 'epg-wait-for-status 'ignore)
(setq doom-modeline-buffer-encoding t)
(setq doom-modeline-gnus t)
(setq doom-modeline-time t)
(setq doom-modeline-always-visible-segments '(gnus irc))
(setq doom-modeline-gnus-timer 5)
(global-subword-mode)

;; Do not interrupt typing
(setq company-idle-delay 0.7)

(setq org-directory "~/Library/Mobile Documents/com~apple~CloudDocs/org/")

(after! ellama
  (setq ellama-language "English")
  (setq ellama-user-nick "みなる")
  (setq ellama-assistant-nick "Eーらま")
  (require 'llm-ollama)
  (setq ellama-provider
          (make-llm-ollama
           :chat-model "codellama" :embedding-model "codellama")))

(after! org
  (setq org-babel-default-header-args
        '((:results . "output code replace")
          (:noweb . "yes")
          (:eval . "never-export")
          (:exports . "both")))

  (org-clock-persistence-insinuate)
  (setq org-timestamp-formats '("%Y-%m-%d %a %H:%M" . "%Y-%m-%d %a %H:%M"))
  (org-babel-do-load-languages
    'org-babel-load-languages
    '(
    (emacs-lisp . t)
    (ledger . t)         ;this is the important one for this tutorial
    (sh . t)
    (js . t)
    ))

  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (global-org-modern-mode)

  (setq
   ;; Edit settings
   ;; org-auto-align-tags nil
   ;; org-tags-column 0
   org-log-done nil
   org-catch-invisible-edits 'show-and-error
   org-insert-heading-respect-content t
   org-journal-file-type 'weekly

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t
   org-ellipsis "…"

   ;; Agenda styling
   org-agenda-block-separator ?─)

  (setq org-startup-folded t)

  (add-to-list 'org-src-lang-modes (cons "jsx" 'rjsx-mode))
  (defun org-babel-noweb-wrap (&optional regexp)
    "Return regexp matching a Noweb reference.

   Match any reference, or only those matching REGEXP, if non-nil.

   When matching, reference is stored in match group 1."

    (rx-to-string
     `(and (or "<<" "<<-")
           (group
            (not (or " " "\t" "\n"))
            (? (*? any) (not (or " " "\t" "\n"))))
           (or ">>" "->>")))))

(add-hook 'gnus-part-display-hook '+zen/toggle)
(setq gnus-asynchronous t)

(defun my-fetch-password (&rest params)
  (require 'auth-source)
  (let ((match (car (apply 'auth-source-search params))))
    (if match
        (let ((secret (plist-get match :secret)))
          (if (functionp secret)
              (funcall secret)
            secret))
      (error "Password not found for %S" params))))

(defun my-nickserv-password (server)
  (my-fetch-password :user "Minall" :host "irc.libera.chat"))

(setq circe-network-options
      '(("Libera Chat"
         :nick "Minall"
         :nickserv-password my-nickserv-password)))

  (setq circe-reduce-lurker-spam t)
  (require 'lui-autopaste)
  (add-hook 'circe-channel-mode-hook 'enable-lui-autopaste)
  (setq circe-format-say "{nick:-16s} {body}")
  (load "lui-logging" nil t)
  (enable-lui-logging-globally)
  (setq lui-logging-directory '"/Users/niguelalgelsuarezcalles/Library/Mobile Documents/com~apple~CloudDocs/メール/IRC")
  (setq circe-format-self-say "<{nick}> {body}")
  (setq
   lui-time-stamp-position 'right-margin
   lui-time-stamp-format "%H:%M")

  (add-hook 'lui-mode-hook 'my-circe-set-margin)
  (defun my-circe-set-margin ()
    (setq right-margin-width 5))

  (setq
   lui-time-stamp-position 'right-margin
   lui-fill-type nil)

  (add-hook 'lui-mode-hook 'my-lui-setup)
  (defun my-lui-setup ()
    (setq
     fringes-outside-margins t
     right-margin-width 5
     word-wrap t
     wrap-prefix "    "))

  (setq lui-track-bar-behavior 'before-switch-to-buffer)
  (enable-lui-track-bar)
