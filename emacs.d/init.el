(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;(require 'benchmark-init)
;(add-hook 'after-init-hook 'benchmark-init/deactivate)


(unless(package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require'use-package)

(customize-set-variable 'use-package-always-ensure t)
(customize-set-variable 'use-package-always-defer t)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t
            initial-buffer-choice  nil)

;list the packages you want
;(setq package-list '(dracula-theme py-autopep8  graphene ivy-bibtex ivy-dired-history ivy-explorer ivy-todo graphene backup-walker projectile elpy py-autopep8 py-import-check py-isort go-mode cython-mode company company-c-headers company-statistics tree-sitter tree-sitter-langs))

(customize-set-variable 'load-prefer-newer t)
(use-package auto-compile
  :defer nil
  :config(auto-compile-on-load-mode))

(use-package paradox :defer 5
  :custom
  (paradox-github-token t)
  :config
  (paradox-enable))

(use-package company 
  :defer t
  :custom
  (delete 'company-semantic company-backends)
  (global-company-mode t)
)

(use-package multiple-cursors
  :bind
  (("C-c n" . mc/mark-next-like-this)
   ("C-c p" . mc/mark-previous-like-this)))
(use-package company-statistics :after company)

(use-package dracula-theme)

(use-package projectile)

(use-package py-import-check)

(use-package py-isort)

(use-package go-mode)

(use-package cython-mode)

(use-package graphene)

(use-package tree-sitter
  :config
  (use-package tree-sitter-langs
    :config
    (global-tree-sitter-mode)
    (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  )
)




(use-package ivy-bibtex :after ivy)
(use-package ivy-todo :after ivy)
(use-package ivy-dired-history :after ivy)
(use-package ivy-explorer :after ivy)

(save-place-mode 1)

(use-package ido
  :config
  (ido-mode t)
  (ido-everywhere 1)
  (setq ido-use-virtual-buffers t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point nil)
  (setq ido-auto-merge-work-directories-length -1))

(use-package ido-completing-read+ :config
  (ido-ubiquitous-mode 1))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

(use-package elpy :init
  (advice-add 'python-mode :before 'elpy-enable)
  (setq python-shell-interpreter "jupyter"
	python-shell-interpreter-args "console --simple-prompt"
	python-shell-prompt-detect-failure-warning nil)
  (setq elpy-rpc-python-command "python3")
  (setq python-shell-interpreter "ipython")
  (add-hook 'elpy-mode-hook(lambda ()(highlight-indentation-mode - 1)))
  :custom
  (add-to-list 'python-shell-completion-native-disabled-interpreters
	       "jupyter")
  )


;; (defconst sh-mode--string-interpolated-variable-regexp
;;   "{\\$[^}\n\\\\]*\\(?:\\\\.[^}\n\\\\]*\\)*}\\|\\${\\sw+}\\|\\$\\sw+")

;; (defun sh-mode--string-intepolated-variable-font-lock-find(limit)
;;   (while (re-search-forward sh-mode--string-interpolated-variable-regexp limit t)
;;     (let((quoted-stuff(nth 3 (syntax-ppss))))
;;       (when(and quoted-stuff(member quoted-stuff '(?\" ?`)))
;;         (put-text-property(match-beginning 0)(match-end 0)
;; 			  'face 'font-lock-variable-name-face))))
;;   nil)

;; (eval-after-load 'sh-mode
;;   '(progn
;;      (font-lock-add-keywords
;;       'sh-mode
;;       `((sh-mode--string-intepolated-variable-font-lock-find))
;;       'append)))



(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
    version-control t)       ; use versioned backupsXS


(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 200))

(xterm-mouse-mode 1)


(unless(eq window-system 'ns)
  (menu-bar-mode -1))
(when(fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when(fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when(fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(use-package uniquify :ensure nil
  :defer 0.1
  :custom
  (setq uniquify-buffer-name-style 'forward)
  )


(global-set-key(kbd "C-x C-b") 'ibuffer)
(global-set-key(kbd "C-s") 'isearch-forward-regexp)
(global-set-key(kbd "C-r") 'isearch-backward-regexp)
(global-set-key(kbd "C-M-s") 'isearch-forward)
(global-set-key(kbd "C-M-r") 'isearch-backward)

(global-linum-mode 1)
					;add line numbers on the left
(setq linum-format "%4d \u2502 ")


(setq vc-follow-symlinks t) ; follow symlinks

(cua-mode)
(setq x-select-enable-clipboard t)

(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")

					; Set dired-x global variables here.  For example:

	    (setq dired-guess-shell-gnutar "gtar")

	    (setq dired-x-hands-off-my-keys nil)
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()

					;Set dired-x buffer-local variables here.  For example:

	    (dired-omit-mode 1)
	    ))

(use-package counsel :after ivy
  :config(counsel-mode)
  :bind(
	("M-x" . counsel-M-x)
	("C-x C-f" . counsel-find-file)
	("<f1> f" . counsel-describe-function)
	("<f1> v" . counsel-describe-variable)
	("<f1> l" . counsel-find-library)
	("<f2> i" . counsel-info-lookup-symbol)
	("<f2> u" . counsel-unicode-char)
	("C-c c" . counsel-compile)
	("C-c g" . counsel-git)
	("C-c j" . counsel-git-grep)
	("C-c k" . counsel-ag)
	("C-x l" . counsel-locate)
	("C-S-o" . counsel-rhythmbox)
	)
  )

(use-package ivy :defer 0.1
  :diminish
  :bind
  (
   ("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window)
   )
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  :config(ivy-mode))

(use-package ivy-rich :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
			  ivy-rich-switch-buffer-align-virtual-buffer t
			  ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
			       'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :after ivy
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)))


(use-package good-scroll
  :config
  (good-scroll-mode 1)
)

;;;; Mouse scrolling in terminal emacs
(unless (display-graphic-p)
  ;; activate mouse-based scrolling
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
)


(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\zshrc\\'" . sh-mode))
(setq ring-bell-function 'ignore)

(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-unix-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(good-scroll ivy-rich elpy ivy-explorer ivy-dired-history ivy-todo ivy-bibtex graphene cython-mode go-mode py-isort py-import-check projectile dracula-theme company-statistics multiple-cursors company paradox auto-compile use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


