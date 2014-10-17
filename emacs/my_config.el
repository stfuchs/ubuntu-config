(add-to-list 'load-path "~/git/ubuntu_config/emacs/")

;; --- Hide Init Screen
(setq inhibit-splash-screen t)

;; --- Move backup files to single directory ----
(setq backup-directory-alist `(("." . "~/.emacs_backup_files")))

;; --- Set C Style ---
(setq c-default-style "bsd")
(setq c-basic-offset 2)
(setq-default indent-tabs-mode nil)
(setq default-tab-width 2)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; --- show/hide code blocks ---
(add-hook 'c-mode-common-hook
  (lambda()
    (require 'doxymacs)
    (doxymacs-mode t)
    (doxymacs-font-lock)
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)
    (hs-hide-all)
    (c-toggle-auto-state 1) ; new line after certain char
    (c-toggle-hungry-state 1))) ; eat all whitespace until first char

(setq display-time-day-and-date t
  display-time-24hr-format t)
(display-time)

;; --- whitespace http://www.emacswiki.org/emacs/WhiteSpace
; turns on whitespace mode only for tabs
; highlights tabs, 80-Column-Rule, trailing whitespaces
;(require 'whitespace)
;(setq whitespace-style '(face tab-mark lines-tail trailing))
;(global-whitespace-mode t)

(setq show-paren-delay 0)           ; how long to wait?
(show-paren-mode t)                 ; turn paren-mode on
(setq show-paren-style 'parenthesis) ; alternatives are 'parenthesis' and 'mixed 'expression



;; ido makes competing buffers and finding files easier
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(require 'ido)
(ido-mode 'both) ;; for buffers and files
(setq
  ido-save-directory-list-file "~/.emacs.d/cache/ido.last"

  ido-ignore-buffers ;; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
     "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
  ido-work-directory-list '("~/git/care-o-bot/cob_environment_perception_intern"
                            "~/git/care-o-bot/cob_environment_perception/cob_3d_mapping_common")
  ido-case-fold  t                 ; be case-insensitive

  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 30   ; should be enough
  ido-max-work-file-list      50   ; remember many
  ido-use-filename-at-point nil    ; don't use filename at point (annoying)
  ido-use-url-at-point nil         ; don't use url at point (annoying)

  ido-enable-flex-matching nil     ; don't try to be too smart
  ido-max-prospects 8              ; don't spam my minibuffer
  ido-confirm-unique-completion t) ; wait for RET, even with unique completion

;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

;; --- activate ALT+Arrows to move between visible buffers ---
(require 'windmove)
(windmove-default-keybindings 'meta)

;; --- Fullscreen Mode ---
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
      (if (equal 'fullboth current-value)
         (if (boundp 'old-fullscreen) old-fullscreen nil)
            (progn (setq old-fullscreen current-value) 'fullboth)))))

(global-set-key [f11] 'toggle-fullscreen)

;; --- Custom Keybindings ---
(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))

(global-set-key (kbd "C-x f") 'rename-this-buffer-and-file)

(defun get-above-makefile ()
  (loop as d = default-directory then
        (expand-file-name ".." d) if (file-exists-p (expand-file-name "CMakeLists.txt" d)) return d))

;; bind compiling with get-above-makefile to f5
(global-set-key (kbd "C-x m") (lambda () (interactive) (compile (format "make -j 8 -C %s" (get-above-makefile)))))
;;(global-set-key (kbd "C-x c") 'compile)


;; --- Customize Layout ---
(tool-bar-mode -1) ;; the buttons bar
;;(menu-bar-mode -1) ;; the text bar (graphical and console)
(toggle-scroll-bar -1)
(require 'color-theme)
(color-theme-initialize)
(if window-system
    (color-theme-midnight-mod)
  )
(set-face-attribute 'default nil :height 80)

;(color-theme-midnight-mod)
;

;; highlight the current line; set a custom face, so we can
;; recognize from the normal marking (selection)
(defface curr-line '((t (:background "gray5")))
  "Face to use for `hl-line-face'." :group 'curr-line)
(setq hl-line-face 'curr-line)
(global-hl-line-mode t) ; turn it on for all modes by default


;; --- ROS stuff ---
(add-to-list 'load-path "/opt/ros/diamondback/ros/tools/rosemacs")
;;(require 'rosemacs)
;;(invoke-rosemacs)
;;(global-set-key "\C-x\C-r" ros-keymap)
;;(require 'rng-loc)
;;(condition-case nil ;; error e.g. when running as root
;;    (push (concat (ros-package-path "rosemacs") "/rng-schemas.xml") rng-schema-locating-files)
;;  (error nil))


;; --- Auto Modes ---
(add-to-list 'auto-mode-alist '("\.launch$" . nxml-mode))
(add-to-list 'auto-mode-alist '("manifest.xml" . nxml-mode))
(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-mode))
(add-to-list 'auto-mode-alist '("\.cmake$" . cmake-mode))
(add-to-list 'auto-mode-alist '("\.m$" . octave-mode))

;; --- Git stuff ---
(add-to-list 'load-path "~/git/git-emacs")
;(require 'git-emacs)
;(add-to-list 'load-path "~/.emacs.d")
;(require 'git)
;(global-set-key (kbd "M-g s") 'git-status)
;(global-set-key (kbd "M-g b") 'git-branch)

;; --- Latex stuff ---
;;(load "auctex.el" nil t t)
;;(setq TeX-auto-save t)
;;(setq TeX-parse-self t)
(setq TeX-PDF-mode t) ;; .pdf statt .dvi per default
;;(global-auto-revert-mode t) ;; auto refresh when files change

;;direkte Rechtschreib Korrektur:
;;(add-hook ’LaTeX-mode-hook ’flyspell-mode)
;;(setq-default ispell-program-name "aspell") ;; aspell ist besser als ispell.
;; Deutsche Rechtschreibung falls \usepackage{ngerman}
;; oder german benutzt wird
;;(add-hook ’TeX-language-de-hook
;;  (function (lambda () (ispell-change-dictionary "german8"))))


;; --- Fix Selection in Terminal Mode ---
(if(equal "xterm" (tty-type))
  (define-key input-decode-map "\e[1;2A" [S-up]))

;; --- quickly switch between h/hpp/cpp ---
;(setq cc-other-file-alist
;  '(("\\.c"   (".h"))
;    ("\\.cpp"   (".h"))
;    ("\\.hpp"   (".h"))
;    ("\\.h"   (".hpp"".cpp"".c"))))
;(setq ff-search-directories '("." "../src" "../include"))
;(global-set-key (kbd "C-c o") 'ff-find-other-file)
(provide 'my_config)


;; ----------------------------
;; --- Some useful commands ---
;; ----------------------------
;; M-x untabify
;; M-X delete-trailing-whitespace
