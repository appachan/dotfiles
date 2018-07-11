;;; init.el --- Spacemacs Initialization File
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; Increase gc-cons-threshold, depending on your system you may set it back to a
;; lower value in your dotfile (function `dotspacemacs/user-config')
(setq gc-cons-threshold 100000000)

(defconst spacemacs-version          "0.200.7" "Spacemacs version.")
(defconst spacemacs-emacs-min-version   "24.4" "Minimal version of Emacs.")

(if (not (version<= spacemacs-emacs-min-version emacs-version))
    (message (concat "Your version of Emacs (%s) is too old. "
                     "Spacemacs requires Emacs version %s or above.")
             emacs-version spacemacs-emacs-min-version)
  (load-file (concat (file-name-directory load-file-name)
                     "core/core-load-paths.el"))
  (require 'core-spacemacs)
  (spacemacs/init)
  ;(spacemacs/maybe-install-dotfile)
  (configuration-layer/sync)
  ;(spacemacs-buffer/display-info-box)
  (spacemacs/setup-startup-hook)
  (require 'server)
  (unless (server-running-p) (server-start)))


;; my settings
;; evil keymap
(defun evil-escape-or-quit (&optional prompt)
  (interactive)
  (cond
   ((or (evil-normal-state-p) (evil-insert-state-p) (evil-visual-state-p) (evil-replace-state-p) (evil-motion-state-p)) [escape])
   (t (kbd "C-g"))))
(define-key key-translation-map (kbd "C-j") 'evil-escape-or-quit)

;; tab-width.
(setq go-tab-width 2) ;; Tab-width 2 in go-mode.
(setq typescript-tab-width 2) ;; Tab-width 2 in typescript-mode.
(setq js-indent-level 2) ;; Tab-width 2 in js-mode.

;; apply tex-mode extnsions to *.tex.erb.
(add-to-list 'auto-mode-alist '("\\.tex.erb\\'" . tex-mode))
;; change comment font color.
(set-face-foreground 'font-lock-comment-face "#999")
;; in tex-mode
(defun latex-mode-extensions()
  (set-face-foreground 'font-lock-comment-face "#aaffaa"))
(add-hook 'LaTeX-mode-hook 'latex-mode-extensions)

;; load go-autocomplete
(load (substitute-in-file-name "$GOPATH/src/github.com/nsf/gocode/emacs/go-autocomplete"))

;; enable share system clipboard.
(setq x-select-enable-clipboard t)
(defun paste-to-osx (text &optional push)
   (let ((process-connection-type nil))
          (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
                   (process-send-string proc text)
                          (process-send-eof proc))))
(setq interprogram-cut-function 'paste-to-osx)
