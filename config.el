;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Packages
;; ========

;; PUT THIS FIRST IN THE CONFIG!
;; This needs to load before any other packages,
;; which might do things with unicode fonts that will make emacs hang
;; if this package isn't loaded and set up.
(def-package! unicode-fonts
              :config
              (unicode-fonts-setup))

;; If we don't declare this, flycheck won't find flycheck-ledger.
;; Not sure why this or an explicit ~require~ is needed
(def-package! flycheck-ledger)

(def-package! ledger-mode)

(def-package! org-ref
  :config
  (setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))
  (setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
        org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
        org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/"))

;; Doom package customization
;; ==========================

;; Disable snipe's default =s= keybinding
(after! evil-snipe (evil-snipe-mode -1))

;; Don't consider the org-brain buffer to be a popup
(set-popup-rule! "^\\*org-brain" :ignore t)

(after! org
  ;; Doom restricts tab cycling to only cycle the current subtree.
  ;; This restores default behavior.
  (remove-hook 'org-tab-first-hook #'+org|cycle-only-current-subtree)
  (setq org-directory "~/Dropbox/docs/archive/2019/drafts")
  (setq org-id-link-to-org-use-id t)
  (setq org-cycle-emulate-tab nil))

(after! evil
  (setq evil-cross-lines t))

;; org-brain setup
;; ===============

;; For some reason flycheck gets confused
;; if I don't specify the .el file here,
;; even though emacs loads 'org-brain just fine.
;; Flycheck's confusion makes emacs hang for a good 30 seconds
;; so I'm listing the file here to placate it.
(add-to-list 'load-path "~/gits/org-brain")
(require 'org-brain)
;; (evil-set-initial-state 'org-brain-visualize-mode 'emacs)

;; General emacs configuration
;; ===========================

(set-default-font "IBM Plex Mono")
(set-face-attribute 'default nil :height 140)

;; Key bindings
;; ============

(map! (:leader
        "br" #'revert-buffer
        "bs" #'org-tree-to-indirect-buffer
        "er" #'eval-region
        "ir" #'indent-region
        "ob" #'org-brain-visualize
        "x"  #'counsel-M-x)

      (:mode org-mode
        :mnv "[o" #'org-previous-visible-heading
        :mnv "]o" #'org-next-visible-heading
        :mnv "[*" #'outline-up-heading
        :mni [(shift meta return)] 'org-insert-subheading

        "s-0" (lambda () (interactive) (show-all))
        "s-1" (lambda () (interactive) (org-global-cycle 1))
        "s-2" (lambda () (interactive) (org-global-cycle 2))
        "s-3" (lambda () (interactive) (org-global-cycle 3))
        "s-4" (lambda () (interactive) (org-global-cycle 4))
        "s-5" (lambda () (interactive) (org-global-cycle 5))
        "s-6" (lambda () (interactive) (org-global-cycle 6))
        "s-7" (lambda () (interactive) (org-global-cycle 7))
        "s-8" (lambda () (interactive) (org-global-cycle 8))
        "s-9" (lambda () (interactive) (org-global-cycle 9)))

      (:mode ledger-mode
        "s-0"     (lambda () (interactive) (set-selective-display (* tab-width 0)))
        "s-1"     (lambda () (interactive) (set-selective-display (* tab-width 1)))
        "s-2"     (lambda () (interactive) (set-selective-display (* tab-width 2)))
        "s-3"     (lambda () (interactive) (set-selective-display (* tab-width 3)))
        "s-4"     (lambda () (interactive) (set-selective-display (* tab-width 4)))
        "s-5"     (lambda () (interactive) (set-selective-display (* tab-width 5)))
        "s-6"     (lambda () (interactive) (set-selective-display (* tab-width 6)))
        "s-7"     (lambda () (interactive) (set-selective-display (* tab-width 7)))
        "s-8"     (lambda () (interactive) (set-selective-display (* tab-width 8)))
        "s-9"     (lambda () (interactive) (set-selective-display (* tab-width 9))))

      (:mode org-brain-visualize-mode
        :n "/"   #'counsel-brain
        :n "TAB" #'forward-button
        :n "C-j" #'forward-button
        :n "C-k" #'backward-button
        :n "o"   #'org-brain-goto-current
        :n "gp"  #'org-brain-goto-parent
        :n "gc"  #'org-brain-goto-child
        :n "gr"  #'revert-buffer
        :n "p"   #'org-brain-add-parent
        :n "P"   #'org-brain-remove-parent
        :n "c"   #'org-brain-add-child
        :n "C"   #'org-brain-remove-child
        :n "f"   #'org-brain-add-friendship
        :n "F"   #'org-brain-remove-friendship
        :n ";"   #'org-brain-select
        :n ":"   #'org-brain-clear-selected
        :n "n"   #'org-brain-pin))
