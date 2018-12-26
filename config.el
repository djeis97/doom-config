;;; General settings

(setq doom-leader-key "SPC"
      doom-localleader-key ","
      doom-font (font-spec :family "Source Code Pro" :size 9)
      doom-big-font (font-spec :family "Source Code Pro" :size 18)
      user-full-name "Elijah Malaby"
      user-mail-address "qwe12345678910@gmail.com"
      mouse-wheel-scroll-amount '(3)
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse t
      mouse-autoselect-window t
      focus-follows-mouse t
      scroll-step 1
      vc-follow-symlinks t
      browse-url-generic-program "uzbl-browser"
      browse-url-browser-function 'browse-url-generic
      default-input-method "TeX"
      exwm--terminal-command "terminator"
      exwm--locking-command "lock"
      exwm-app-launcher--prompt "$ "
      exwm--hide-tiling-modeline nil
      exwm-workspace-minibuffer-position 'bottom
      exwm-focus-follows-mouse t)

(setq-default fill-column 100
              visual-fill-column-width 100
              persp-add-buffer-on-after-change-major-mode 'free
              langtool-java-classpath "/usr/share/languagetool:/usr/share/java/languagetool/*")

(with-eval-after-load 'dired
  (setq dired-omit-files "^\\.[^.]\\|^#.*#$"))

(with-eval-after-load 'tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (setq tramp-use-ssh-controlmaster-options nil))

(with-eval-after-load 'term
  (setq ansi-term-color-vector
        [term term-color-black term-color-red term-color-green
              term-color-yellow term-color-blue term-color-magenta
              term-color-cyan term-color-white]))

;;; Personal variables

(setq mfiano/lisp-implementations
      '((sbcl-large ("sbcl" "--dynamic-space-size" "6144"))
        (sbcl ("sbcl"))
        (ros ("ros" "run"))
        (ros-local ("ros" "-S" "." "run"))))

;;; Custom minor modes

(defun djeis97-lisp/close-paren ()
  (interactive)
  (ignore-errors
    (let ((next-line-only-close-parens (save-excursion
                                         (next-line)
                                         (beginning-of-line)
                                         (looking-at "\s*\)+\s*$"))))
      (sp-forward-barf-sexp '(4))
      (save-excursion
        (next-line)
        (beginning-of-line)
        (if (and next-line-only-close-parens
                 (looking-at "\s*$"))
            (ignore-errors
              (kill-whole-line))))))
  (right-char))


(define-minor-mode paren-management
  "Bindings to better manage parens."
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "<tab>") 'lisp-indent-adjust-parens)
            (define-key map (kbd "<backtab>") 'lisp-dedent-adjust-parens)
            (define-key map (kbd "(") (lambda ()
                                        (interactive)
                                        (sp-insert-pair "(")
                                        (sp-forward-slurp-sexp '(4))))
            (define-key map (kbd "C-(") (lambda ()
                                          (interactive)
                                          (sp-insert-pair "[")
                                          (sp-forward-slurp-sexp '(4))))
            (define-key map (kbd "s-(") (lambda ()
                                          (interactive)
                                          (sp-insert-pair "{")
                                          (sp-forward-slurp-sexp '(4))))

            (define-key map [remap newline-and-indent] (lambda ()
                                                         (interactive)
                                                         (newline-and-indent)
                                                         (if (char-equal (char-after (point)) ?\))
                                                             (save-excursion
                                                               (newline-and-indent)))
                                                         (indent-according-to-mode)))
            (define-key map (kbd ")") 'djeis97-lisp/close-paren)
            map))

(add-hook! lisp-mode
  (paren-management 1))
(add-hook! emacslisp-mode
  (paren-management 1))
(add-hook! clojure-mode
  (paren-management 1))

;;; Packages

(def-package! all-the-icons-ivy
  :config
  (setq all-the-icons-ivy-file-commands
        '(counsel-find-file counsel-file-jump counsel-recentf counsel-projectile-find-file counsel-projectile-find-dir))
  (all-the-icons-ivy-setup))

(def-package! evil-cleverparens
  :init
  (setq evil-move-beyond-eol t))

(add-hook! (lisp-mode emacs-lisp-mode)
  (evil-cleverparens-mode t))

(def-package! org
  :config
  (setq org-directory (expand-file-name "~/org/")
        +org-dir org-directory
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-refile-targets '((nil :maxlevel . 5)
                             (org-agenda-files :maxlevel . 5))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-capture-templates
        '(("c" "Code Task" entry (file+headline org-default-notes-file "Coding Tasks")
           "* TODO %?\n  Entered on: %U - %a\n")
          ("t" "Task" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %?\n  Entered on: %U")
          ("n" "Note" entry (file+datetree org-default-notes-file)
           "* %?\n\n"))))

(def-package-hook! evil-escape :post-init
  (setq evil-escape-key-sequence "fd"))

(def-package! sly-repl-ansi-color
  :config
  (push 'sly-repl-ansi-color sly-contribs))

(def-package! hungry-delete
  :init
  (add-hook! prog-mode #'hungry-delete-mode))

(add-hook! text-mode #'flyspell-mode)

(after! gist
  (setq gist-view-gist t))

(after! imenu-anywhere
  (setq imenu-anywhere-buffer-filter-functions '(imenu-anywhere-same-project-p)))

(after! ivy
  (setq ivy-re-builders-alist '((t . ivy--regex-plus)))
  (setq ivy-fixed-height-minibuffer nil))

(after! which-key
  (setq which-key-idle-delay 0.25
        which-key-idle-secondary-delay 0.25))

(after! sly
  (evil-set-initial-state 'sly-mrepl-mode 'insert)
  (evil-set-initial-state 'sly-inspector-mode 'emacs)
  (evil-set-initial-state 'sly-db-mode 'emacs)
  (evil-set-initial-state 'sly-xref-mode 'emacs)
  (evil-set-initial-state 'sly-stickers--replay-mode 'emacs)
  (sp-local-pair '(sly-mrepl-mode) "'" "'" :actions nil)
  (sp-local-pair '(sly-mrepl-mode) "`" "`" :actions nil)
  (setq sly-lisp-implementations mfiano/lisp-implementations
        sly-autodoc-use-multiline t
        sly-complete-symbol*-fancy t
        sly-net-coding-system 'utf-8-unix)
  (add-to-list 'company-backends '(company-capf company-files)))

(after! smartparens
  (setq sp-show-pair-from-inside t
        sp-cancel-autoskip-on-backward-movement nil
        sp-highlight-pair-overlay nil
        sp-highlight-wrap-overlay nil
        sp-highlight-wrap-tag-overlay nil)
  (sp-pair "'" nil :actions :rem)
  (sp-pair "`" nil :actions :rem)
  (smartparens-global-strict-mode 1))

(after! magit
  (magit-wip-after-apply-mode)
  (magit-wip-after-save-mode))

(add-hook! prog-mode
  (aggressive-indent-mode 1))

(add-hook! company-mode
  (djeis97-programming-tools/company-tng-configure-default))

(add-hook! prog-mode
  (global-company-mode 1))

(def-package! evil-lisp-state
  :init (setq evil-lisp-state-global t)
  :config (evil-lisp-state-leader "<f20> l"))

(def-package! exwm-edit
  :after exwm)
(def-package! xelb)
(def-package! exwm
  :init
  (add-hook 'exwm-init-hook 'exwm/add-ivy-persp-advice)

  (when exwm-focus-follows-mouse
    (setq mouse-autoselect-window t
          focus-follows-mouse t))
  ;; Disable dialog boxes since they are unusable in EXWM
  (setq use-dialog-box nil)
  ;; Worskpaces please
  (setq exwm-workspace-number 6)
  ;; You may want Emacs to show you the time
  (display-time-mode t)
  (when exwm--hide-tiling-modeline
    (add-hook 'exwm-mode-hook #'hidden-mode-line-mode))
  :config
  (defun exwm-bind-command (key command &rest bindings)
    (while key
      (exwm-input-set-key (kbd key)
                          `(lambda ()
                             (interactive)
                             (start-process-shell-command ,command nil ,command)))
      (setq key     (pop bindings)
            command (pop bindings))))

  (exwm-bind-command
   "<s-return>"  exwm--terminal-command)

  ;; All buffers created in EXWM mode are named "*EXWM*". You may want to change
  ;; it in `exwm-update-class-hook' and `exwm-update-title-hook', which are run
  ;; when a new window class name or title is available. Here's some advice on
  ;; this subject:
  ;; + Always use `exwm-workspace-rename-buffer` to avoid naming conflict.
  ;; + Only renaming buffer in one hook and avoid it in the other. There's no
  ;;   guarantee on the order in which they are run.
  ;; + For applications with multiple windows (e.g. GIMP), the class names of all
  ;;   windows are probably the same. Using window titles for them makes more
  ;;   sense.
  ;; + Some application change its title frequently (e.g. browser, terminal).
  ;;   Its class name may be more suitable for such case.
  ;; In the following example, we use class names for all windows expect for
  ;; Java applications and GIMP.
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                          (string= "gimp" exwm-instance-name))
                (exwm-workspace-rename-buffer exwm-class-name))))
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (when (or (not exwm-instance-name)
                        (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                        (string= "gimp" exwm-instance-name))
                (exwm-workspace-rename-buffer exwm-title))))
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (when (string= "Google-chrome" exwm-class-name)
                (exwm-workspace-rename-buffer exwm-title))))
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (when (string= "Vivaldi-stable" exwm-class-name)
                (exwm-workspace-rename-buffer (format "%s - Vivaldi Stable" exwm-title)))))
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (when (string= "Uzbl-core" exwm-class-name)
                (exwm-workspace-rename-buffer exwm-title))))


  (defvar exwm-workspace-switch-wrap t
    "Whether `spacemacs/exwm-workspace-next' and `spacemacs/exwm-workspace-prev' should wrap.")

  (defun spacemacs/exwm-workspace-next ()
    "Switch to next exwm-workspaceective (to the right)."
    (interactive)
    (let* ((only-workspace? (equal exwm-workspace-number 1))
           (overflow? (= exwm-workspace-current-index
                         (1- exwm-workspace-number))))
      (cond
       (only-workspace? nil)
       (overflow?
        (when exwm-workspace-switch-wrap
          (exwm-workspace-switch 0)))
       (t (exwm-workspace-switch  (1+ exwm-workspace-current-index))))))
  (defun spacemacs/exwm-workspace-prev ()
    "Switch to next exwm-workspaceective (to the right)."
    (interactive)
    (let* ((only-workspace? (equal exwm-workspace-number 1))
           (overflow? (= exwm-workspace-current-index 0)))
      (cond
       (only-workspace? nil)
       (overflow?
        (when exwm-workspace-switch-wrap
          (exwm-workspace-switch (1- exwm-workspace-number))))
       (t (exwm-workspace-switch  (1- exwm-workspace-current-index))))))
  (defun spacemacs/exwm-layout-toggle-fullscreen ()
    "Togggles full screen for Emacs and X windows"
    (interactive)
    (if exwm--id
        (exwm-layout-toggle-fullscreen exwm--id)
      (spacemacs/toggle-maximize-buffer)))

  ;; Quick swtiching between workspaces
  (defvar exwm-toggle-workspace 0
    "Previously selected workspace. Used with `exwm-jump-to-last-exwm'.")
  (defun exwm-jump-to-last-exwm ()
    (interactive)
    (exwm-workspace-switch exwm-toggle-workspace))
  (defadvice exwm-workspace-switch (before save-toggle-workspace activate)
    (setq exwm-toggle-workspace exwm-workspace-current-index))

  (defun spacemacs/exwm-app-launcher (command)
    "Launches an application in your PATH.
Can show completions at point for COMMAND using helm or ido"
    (interactive (list (read-shell-command exwm-app-launcher--prompt)))
    (start-process-shell-command command nil command))

  ;; `exwm-input-set-key' allows you to set a global key binding (available in
  ;; any case). Following are a few examples.
  ;; + We always need a way to go back to line-mode from char-mode
  (exwm-input-set-key (kbd "s-r") 'exwm-reset)
  (exwm-input-set-key (kbd "s-c") 'exwm-input-release-keyboard)

  (exwm-input-set-key (kbd "s-f") #'spacemacs/exwm-layout-toggle-fullscreen)
  (exwm-input-set-key (kbd "<s-tab>") #'exwm-jump-to-last-exwm)
  ;; + Bind a key to switch workspace interactively
  (exwm-input-set-key (kbd "s-w") 'exwm-workspace-switch)
  ;; + Set shortcuts to switch to a certain workspace.
  (exwm-input-set-key (kbd "s-1")
                      (lambda () (interactive) (exwm-workspace-switch 0)))
  (exwm-input-set-key (kbd "s-2")
                      (lambda () (interactive) (exwm-workspace-switch 1)))
  (exwm-input-set-key (kbd "s-3")
                      (lambda () (interactive) (exwm-workspace-switch 2)))
  (exwm-input-set-key (kbd "s-4")
                      (lambda () (interactive) (exwm-workspace-switch 3)))
  (exwm-input-set-key (kbd "s-5")
                      (lambda () (interactive) (exwm-workspace-switch 4)))
  (exwm-input-set-key (kbd "s-6")
                      (lambda () (interactive) (exwm-workspace-switch 5)))
  (exwm-input-set-key (kbd "s-7")
                      (lambda () (interactive) (exwm-workspace-switch 6)))
  (exwm-input-set-key (kbd "s-8")
                      (lambda () (interactive) (exwm-workspace-switch 7)))
  (exwm-input-set-key (kbd "s-9")
                      (lambda () (interactive) (exwm-workspace-switch 8)))
  (exwm-input-set-key (kbd "s-0")
                      (lambda () (interactive) (exwm-workspace-switch 9)))
  ;; + Application launcher ('M-&' also works if the output buffer does not
  ;;   bother you). Note that there is no need for processes to be created by
  ;;   Emacs.
  (exwm-input-set-key (kbd "s-SPC") #'spacemacs/exwm-app-launcher)
  ;; + 'slock' is a simple X display locker provided by suckless tools. 'i3lock'
  ;;   is a more feature-rich alternative.
  (exwm-input-set-key (kbd "<s-escape>")
                      (lambda () (interactive) (start-process "" nil exwm--locking-command)))
(exwm-input-set-key (kbd "<f20>") (lookup-key evil-normal-state-map (kbd "<f20>")))
  ;; The following example demonstrates how to set a key binding only available
  ;; in line mode. It's simply done by first push the prefix key to
  ;; `exwm-input-prefix-keys' and then add the key sequence to `exwm-mode-map'.
  ;; The example shorten 'C-c q' to 'C-q'.
  (push ?\C-q exwm-input-prefix-keys)
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)



  ;; C-c, C-x are needed for copying and pasting
  (delete ?\C-x exwm-input-prefix-keys)
  (delete ?\C-c exwm-input-prefix-keys)
  ;; We can use `M-m h' to access help
  (delete ?\C-h exwm-input-prefix-keys)

  ;; Preserve the habit
  (exwm-input-set-key (kbd "s-:") 'counsel-M-x)
  (exwm-input-set-key (kbd "s-;") 'evil-ex)
  ;; Shell (not a real one for the moment)
  (exwm-input-set-key (kbd "C-'") #'spacemacs/default-pop-shell)
  ;; Undo window configurations
  (exwm-input-set-key (kbd "s-u") #'winner-undo)
  (exwm-input-set-key (kbd "S-s-U") #'winner-redo)
  ;; Change buffers
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (setq exwm-workspace-show-all-buffers nil)
  ;; The following example demonstrates how to use simulation keys to mimic the
  ;; behavior of Emacs. The argument to `exwm-input-set-simulation-keys' is a
  ;; list of cons cells (SRC . DEST), where SRC is the key sequence you press and
  ;; DEST is what EXWM actually sends to application. Note that SRC must be a key
  ;; sequence (of type vector or string), while DEST can also be a single key.

  ;; (exwm-input-set-simulation-keys
  ;;  '(([?\C-b] . left)
  ;;    ([?\C-f] . right)
  ;;    ([?\C-p] . up)
  ;;    ([?\C-n] . down)
  ;;    ([?\M-v] . prior)
  ;;    ))

  ;; Do not forget to enable EXWM. It will start by itself when things are ready.
  ;; (exwm-enable)
  (setq exwm-systemtray-height 11)
  (setq exwm-workspace-number 1)
  (require 'exwm-randr)
  (setq exwm-randr-workspace-output-plist '(0 "LVDS" 1 "HDMI-1"))
  (exwm-randr-enable)
  (add-hook! exwm-init (start-process "Dropbox" "*Dropbox*" "dropbox"))
  (add-hook! exwm-init (start-process-shell-command "polybar" () "polybar main")))

(def-package! exim
  :after exwm
  :init
  (add-hook! exwm-init (exim-start))
  :config
  (push ?\C-\\ exwm-input-prefix-keys))

;; (after! evil
;;   (add-hook! exwm-mode 'evil-emacs-state))

(after! proof-general
  (setq proof-three-window-mode-policy 'hybrid))

;;; Functions

(defun mfiano/smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun +popup/buffer ()
  "Open current buffer in a popup window."
  (interactive)
  (let ((+popup-default-display-buffer-actions '(+popup-display-buffer-stacked-side-window))
        (display-buffer-alist +popup--display-buffer-alist))
    (push (+popup--make "." +popup-defaults) display-buffer-alist)
    (pop-to-buffer (current-buffer))))

(defun djeis97-programming-tools/company-tng-configure-default ()
  "Applies the default configuration to enable company-tng."
  (setq company-require-match nil)
  (setq company-idle-delay 0.4)
  (setq company-frontends '(company-tng-frontend
                            company-pseudo-tooltip-frontend
                            company-echo-metadata-frontend)))

(defun djeis97/ivy-complete-ivy-action ()
  (interactive)
  (let* ((actions (cdr (ivy-state-action ivy-last)))
         (enable-recursive-minibuffers t)
         (action (ido-completing-read "Action:" (mapcar #'third actions))))
    (ivy-exit-with-action (second (find action actions :key #'third :test #'string=)))))

(defun exwm-passthrough (orig-fun keymap on-exit &optional foreign-keys)
  (setq exwm-input-line-mode-passthrough t)
  (let ((on-exit (lexical-let ((on-exit on-exit))
                   (lambda ()
                     (setq exwm-input-line-mode-passthrough nil)
                     (when on-exit (funcall on-exit))))))
    (funcall orig-fun keymap on-exit foreign-keys)))

(advice-add 'hydra-set-transient-map :around #'exwm-passthrough)

(cl-defun exwm/get-current-persp (orig-fun &optional frame window)
  (funcall orig-fun
           (if (eq (or frame (selected-frame)) exwm-workspace--minibuffer)
               exwm-workspace--current
             frame)
           window))

(defun exwm/add-ivy-persp-advice ()
  (advice-add 'get-current-persp :around #'exwm/get-current-persp))

(defun djeis97/exwm-buffer-p (buffer)
  (with-current-buffer buffer
    (derived-mode-p 'exwm-mode)))

(add-to-list 'doom-real-buffer-functions 'djeis97/exwm-buffer-p)

;;; Included files")

(load! "+bindings")
(load! "+adjust-parens")
