(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)



(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Install packages if they are not installed
(ensure-package-installed 'smex 'company 'gruvbox-theme 'helm)

(package-initialize)

;; Standard configs
(setq inhibit-splash-screen 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 0)
(show-paren-mode 0)

(setq backup-directory-alist '(("~/.emacs_saves")))

(cond
 ((eq system-type 'windows-nt) (add-to-list 'default-frame-alist '(font . "Consolas-12" )
			      (set-face-attribute 'default t :font "Consolas-12" ))
 )
)

(global-set-key (kbd "M-DEL") 'undo)
(global-set-key (kbd "C-x M-DEL") 'undo) 
 	     
;; packages n stuff

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'ido)
(ido-mode t)



(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-idle-delay 1.0)
(global-set-key (kbd "C-<tab>")
                (lambda ()
                  (interactive)
                  (let ((company-tooltip-idle-delay 0.0))
                    (company-complete)
                    (and company-candidates
                         (company-call-frontends 'post-command)))))
(setq company-tooltip-align-annotations t)

;;(eval-after-load 'company
;;  '(add-to-list 'company-backends 'company-irony))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-idle-delay 0.25)
 '(custom-enabled-themes '(gruvbox-dark-soft))
 '(custom-safe-themes
   '("585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "8f97d5ec8a774485296e366fdde6ff5589cf9e319a584b845b6f7fa788c9fa9a" default))
 '(global-company-mode t)
 '(package-selected-packages
   '(company helm gruvbox-theme smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

