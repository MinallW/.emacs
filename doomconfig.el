;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Miguel Suarez"
      user-mail-address "suarezmiguelc@icloud.com")

(setq doom-font (font-spec :family "Iosevka" :size 13 :weight 'regular))
(setq doom-theme 'doom-gruvbox)
(setq display-line-numbers-type 'visual)
(setq org-directory "~/Library/Mobile Documents/com~apple~CloudDocs/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).

;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(after! org-mode
  (setq org-babel-default-header-args
        '((:results . "output code replace")
          (:noweb . "yes")
          (:eval . "never-export")
          (:exports . "both")))

  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (global-org-modern-mode)

  (setq
   ;; Edit settings
   ;; org-auto-align-tags nil
   ;; org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-insert-heading-respect-content t

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
         (or ">>" "->>"))))


  )


(add-hook 'gnus-select-article-hook '+zen/toggle-fullscreen)
(defun some-gnus-article-hook ()
  (message "Testing this AAAAAAAAAAAAAAAAA"))

(add-hook 'gnus-part-display-hook '+zen/toggle)
(setq gnus-article-prepare-hook
      '(+zen/toggle))
(setq company-idle-delay 0.7)


(add-to-list 'auto-mode-alist '("\\.tsx\\'" . js-jsx-mode))

(setq org-journal-file-type 'weekly)

(require 'org-roam-export)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (ledger . t)         ;this is the important one for this tutorial
   (sh . t)
   (js . t)
   ))

(setq org-log-done nil)
(require 'tramp)

(setq shell-file-name "/bin/bash")

(setq vterm-shell "/bin/bash")

(setq auth-sources '("~/.authinfo.gpg"))
(defun my-fetch-password (&rest params)
  (require 'auth-source)
  (let ((match (car (apply #'auth-source-search params))))
    (if match
        (let ((secret (plist-get match :secret)))
          (if (functionp secret)
              (funcall secret)
            secret))
      (error "Password not found for %S" params))))

(defun my-nickserv-password (server)
  (my-fetch-password :user "Minall" :host "irc.libera.chat"))

(set-irc-server! "irc.libera.chat"
  `(:tls t
         :port 6697
         :sasl-username "Minall"
         :sasl-password my-nickserv-password
         :nick "Minall"))

(setq circe-reduce-lurker-spam t)
(require 'lui-autopaste)
(add-hook 'circe-channel-mode-hook 'enable-lui-autopaste)
(setq circe-format-say "{nick:-16s} {body}")
(load "lui-logging" nil t)
(enable-lui-logging-globally)
(setq lui-logging-directory '"/Users/Minall/Library/Mobile Documents/com~apple~CloudDocs/メール/IRC")
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
(setq org-latex-toc-command "\\tableofcontents \\clearpage")

(require 'epa-file)
(custom-set-variables '(epg-gpg-program  "/opt/homebrew/opt/gnupg@2.2/bin/gpg"))
(epa-file-enable)
(org-clock-persistence-insinuate)

(setq org-timestamp-formats '("%Y-%m-%d %a %H:%M" . "%Y-%m-%d %a %H:%M"))
(setq doom-modeline-buffer-encoding t)
(setq doom-modeline-gnus t)
(setq doom-modeline-time t)
(setq doom-modeline-always-visible-segments '(gnus irc))
(setq gnus-asynchronous t)
(setq doom-modeline-gnus-timer 5)


