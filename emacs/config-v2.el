;; --- Package Management
;; Use M-x package-list-packages RET to update packages list
;; Use M-x package-install RET foo
;; List of nice packages: https://github.com/emacs-tw/awesome-emacs

;; On first startup you need to install the following packages:
;; - ido-completing-read+
;; - web-mode
;; - highlight-thing
;; - magit
;; - git-gutter+-mode
;; - solarized-theme
;; - powerline
;; - markdown-mode

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize) ;; You might already have this line

;; --- Hide Init Screen
(setq inhibit-splash-screen t)

;; --- Move backup files to single directory ----
(setq backup-directory-alist `(("." . "~/.emacs.d")))

;; --- Set C Style ---
(setq c-default-style "bsd")
(setq c-basic-offset 2)
(setq-default indent-tabs-mode nil)
(setq default-tab-width 2)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;; --- whitespace http://www.emacswiki.org/emacs/WhiteSpace
; turns on whitespace mode only for tabs
; highlights tabs, 80-Column-Rule, trailing whitespaces
(require 'whitespace)
(setq whitespace-style '(face tab-mark lines-tail trailing))
(global-whitespace-mode t)

(setq show-paren-delay 0)           ; how long to wait?
(show-paren-mode t)                 ; turn paren-mode on
(setq show-paren-style 'parenthesis) ; alternatives are 'parenthesis' and 'mixed 'expression

;; ido makes competing buffers and finding files easier
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(require 'ido-completing-read+) ;;https://github.com/DarwinAwardWinner/ido-ubiquitous
(ido-ubiquitous-mode 1)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

;; highlight thing under cursor
(require 'highlight-thing)
(global-highlight-thing-mode)

;; magit and git-gutter
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-git-gutter+-mode)

;; --- Customize Layout ---
(tool-bar-mode -1) ;; the buttons bar
(menu-bar-mode -1) ;; the text bar (graphical and console)
(toggle-scroll-bar -1)

(require 'solarized)
(setq x-underline-at-descent-line t)
(setq solarized-distinct-fringe-background t)
(setq solarized-high-contrast-mode-line t)
(load-theme 'solarized-dark t)

;; powerline
(require 'powerline)
(powerline-default-theme)

;; --- Auto Modes ---
(add-to-list 'auto-mode-alist '("\.launch$" . nxml-mode))
(add-to-list 'auto-mode-alist '("manifest.xml" . nxml-mode))
(add-to-list 'auto-mode-alist '("\.xacro" . nxml-mode))

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(setq markdown-enable-math t)


;; --- Fix Selection in Terminal Mode ---
(if(equal "xterm" (tty-type))
  (define-key input-decode-map "\e[1;2A" [S-up]))


;; ----------------------------
;; --- Some useful commands ---
;; ----------------------------
;; M-x untabify
;; M-X delete-trailing-whitespace
