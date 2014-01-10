;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Package helpers
(defun require-package (package)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-list '(ace-jump-mode
                     ag
                     auctex
                     auto-complete
                     base16-theme
                     epl
                     evil-leader
                     evil
                     expand-region
                     haskell-mode
                     helm
                     helm-swoop
                     json
		     js2-mode
                     key-chord
                     flx
                     flx-ido
                     ido-ubiquitous
                     markdown-mode
                     melpa
                     pkg-info
                     dash
                     popup
                     popwin
                     projectile
                     s
                     smart-mode-line
                     smex
                     surround
                     undo-tree))

;; Activate all the packages (in particular autoloads)
(package-initialize)

;; package-initialize normally gets executed twice, stop it for slightly faster startup
(setq package-enable-at-startup nil)

;; Fetch the list of packages available
(when (not package-archive-contents)
  (package-refresh-contents))

;; Install the missing packages
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; Custom Configuration
(setq custom-file "~/.emacs.d/custom.el")
(defun loadCustomFile()
  (unless (not (file-exists-p custom-file))
    (load custom-file)))
(add-hook 'after-init-hook 'loadCustomFile)

;; Personal Configuration
(setq config-file "~/.emacs.d/config.el")
(defun loadConfigFile()
  (load config-file))
(add-hook 'after-init-hook 'loadConfigFile)

;; Time Startup
(defun getUptime()
  (message "Time needed to load: %s seconds."
           (emacs-uptime "%s")))
(add-hook 'emacs-startup-hook 'getUptime 'append)
