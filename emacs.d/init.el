(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "marmalade" (concat proto "://marmalade-repo.org/packages/")) t)
  (add-to-list 'package-archives (cons "elpa" (concat proto "://tromey.com/elpa/")) t)

  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
      


; list the packages you want
(setq package-list '(dracula-theme py-autopep8  graphene ivy-bibtex itasca ivy-dired-history ivy-explorer ivy-todo company-tabnine graphene backup-walker projectile elpy py-autopep8 py-import-check py-isort go-mode cython-mode company company-c-headers company-statistics))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))




(save-place-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-rpc-python-command "python3")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (ivy-bibtex itasca ivy-dired-history ivy-explorer ivy-todo company-tabnine graphene backup-walker projectile elpy py-autopep8 py-import-check py-isort go-mode cython-mode company company-c-headers company-statistics dracula-theme)))
 '(split-height-threshold nil)
 '(split-width-threshold 1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

(elpy-enable)
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))

(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--aggressive --aggressive"))

(defconst sh-mode--string-interpolated-variable-regexp
  "{\\$[^}\n\\\\]*\\(?:\\\\.[^}\n\\\\]*\\)*}\\|\\${\\sw+}\\|\\$\\sw+")

(defun sh-mode--string-intepolated-variable-font-lock-find (limit)
  (while (re-search-forward sh-mode--string-interpolated-variable-regexp limit t)
    (let ((quoted-stuff (nth 3 (syntax-ppss))))
      (when (and quoted-stuff (member quoted-stuff '(?\" ?`)))
        (put-text-property (match-beginning 0) (match-end 0)
                           'face 'font-lock-variable-name-face))))
  nil)

(eval-after-load 'sh-mode
  '(progn
     (font-lock-add-keywords
      'sh-mode
      `((sh-mode--string-intepolated-variable-font-lock-find))
      'append)))

(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends #'company-tabnine)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 50
   kept-old-versions 50
   version-control t)       ; use versioned backups



(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 200))

(xterm-mouse-mode 1)

(unless (fboundp 'helm-mode)
    (ido-mode t)
    (setq ido-enable-flex-matching t))

(unless (eq window-system 'ns)
    (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-linum-mode 1) ; add line numbers on the left

(cua-mode)
(setq x-select-enable-clipboard t)

(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

(require 'dired-x)
(require 'graphene)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
