(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)

(require 'ido)
(ido-mode t)


(fset 'yes-or-no-p 'y-or-n-p) ;; allow y/n answer to prompt

(tooltip-mode -1) ;; tooltips in echo area
(setq tooltip-use-echo-area t)

;; disable vc-git
(setq vc-handled-backends ())


;; go fmt before save
(add-hook 'before-save-hook #'gofmt-before-save)
(setq delete-old-versions t)
