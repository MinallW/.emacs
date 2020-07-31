;;; wallpaper-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "wallpaper" "wallpaper.el" (0 0 0 0))
;;; Generated autoloads from wallpaper.el

(autoload 'wallpaper-set-wallpaper "wallpaper" "\
Set the wallpaper.

This function will either choose a random wallpaper from
`wallpaper-cycle-directory' or use the wallpapers listed in
`wallpaper-static-wallpapers'.

\(fn)" t nil)

(defvar wallpaper-cycle-mode nil "\
Non-nil if Wallpaper-Cycle mode is enabled.
See the `wallpaper-cycle-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `wallpaper-cycle-mode'.")

(custom-autoload 'wallpaper-cycle-mode "wallpaper" nil)

(autoload 'wallpaper-cycle-mode "wallpaper" "\
Toggle Wallpaper Cycle mode.

This mode will activate a timer which will call `wallpaper-set-wallpaper'
at the interval defined by `wallpaper-cycle-interval'.  See function
`wallpaper--toggle-cycle' for more information.

\(fn &optional ARG)" t nil)

(defvar wallpaper-per-workspace-mode nil "\
Non-nil if Wallpaper-Per-Workspace mode is enabled.
See the `wallpaper-per-workspace-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `wallpaper-per-workspace-mode'.")

(custom-autoload 'wallpaper-per-workspace-mode "wallpaper" nil)

(autoload 'wallpaper-per-workspace-mode "wallpaper" "\
Toggle Wallpaper Per Workspace mode.

This mode will set specific wallpapers based on the current workspace.
See `wallpaper-per-workspace-alist' and `wallpaper-per-workspace-get'.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "wallpaper" '("wallpaper-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; wallpaper-autoloads.el ends here
