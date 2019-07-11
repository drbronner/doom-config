;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Unicode font configuration

(def-package! unicode-fonts
              :config
              (unicode-fonts-setup)
              )


;; default GUI font

(set-default-font "IBM Plex Mono")
(set-face-attribute 'default nil :height 140)

;; evil configuration

(setq evil-cross-lines t)

;; org-mode setup

;; Setting this via custom messes up org-brain.
;; Evidently custom is called after this config.el is eval'ed.
(setq org-directory "~/Dropbox/docs/archive/2019/drafts")
(setq org-id-link-to-org-use-id t)

;; org-brain setup

;; For some reason flycheck gets confused
;; if I don't specify the .el file here,
;; even though emacs loads 'org-brain just fine.
;; Flycheck's confusion makes emacs hang for a good 30 seconds
;; so I'm listing the file here to placate it.
(add-to-list 'load-path "~/gits/org-brain")
(require 'org-brain)
(evil-set-initial-state 'org-brain-visualize-mode 'emacs)

;; Key bindings

(map! :leader

      (:prefix "b"
        :desc "Open subtree in new buffer" "s"    (lambda ()
                                                    (interactive)
                                                    (clone-indirect-buffer nil 1)
                                                    (org-narrow-to-subtree))) ;;  #'eval-region)

      (:prefix ("e" . "eval")
        :desc "Eval region" "r" #'eval-region)

      (:prefix "i"
        :desc "Indent region" "r" #'indent-region)

      (:prefix "o"
        :desc "org-brain-visualize" "b" #'org-brain-visualize
        :desc "org-store-link"      "y" #'org-store-link)

      :desc "counsel-M-x"           "x" #'counsel-M-x

      )

(define-key org-brain-visualize-mode-map "/" 'counsel-brain)

(setq display-buffer-alist nil)
