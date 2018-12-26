(map! [remap evil-jump-to-tag] #'projectile-find-tag
      [remap find-tag]         #'projectile-find-tag
      [remap move-beginning-of-line] #'mfiano/smarter-move-beginning-of-line
      :i [remap newline] #'newline-and-indent
      :i "C-j" #'+default/newline
      :gnvime "M-x" #'execute-extended-command
      :gnvime "M-;" #'eval-expression
      :n "M-="   (λ! (text-scale-set 0))
      :n "M-+"   #'text-scale-increase
      :n "M--"   #'text-scale-decrease
      :n "M-t"   #'+workspace/new
      :n "M-1"   (λ! (+workspace/switch-to 0))
      :n "M-2"   (λ! (+workspace/switch-to 1))
      :n "M-3"   (λ! (+workspace/switch-to 2))
      :n "M-4"   (λ! (+workspace/switch-to 3))
      :n "M-5"   (λ! (+workspace/switch-to 4))
      :n "M-6"   (λ! (+workspace/switch-to 5))
      :n "M-7"   (λ! (+workspace/switch-to 6))
      :n "M-8"   (λ! (+workspace/switch-to 7))
      :n "M-9"   (λ! (+workspace/switch-to 8))
      (:when (featurep! :completion ivy)
        :n "M-f" #'swiper)
      :n  "zx" #'kill-this-buffer
      :n  "ZX" #'bury-buffer
      :n  "]b" #'next-buffer
      :n  "[b" #'previous-buffer
      :n  "]w" #'+workspace/switch-right
      :n  "[w" #'+workspace/switch-left
      :m  "gt" #'+workspace/switch-right
      :m  "gT" #'+workspace/switch-left
      :n  "gf" #'+lookup/file
      :v  "."  #'evil-repeat
      :nv "C-a"   #'evil-numbers/inc-at-pt
      :nv "C-S-a" #'evil-numbers/dec-at-pt
      (:after company
        (:map company-active-map
          "TAB"     #'company-indent-or-complete-common)
        (:map company-active-map
          "C-w"     nil
          "C-h"     #'company-show-doc-buffer
          "C-j"     #'company-select-next
          "C-k"     #'company-select-previous
          [return]  nil
          [tab]     #'company-complete))
      (:when (featurep! :completion ivy)
        (:after counsel
          (:map counsel-ag-map
            [backtab]  #'+ivy/wgrep-occur
            "C-SPC"    #'ivy-call-and-recenter
            "M-RET"    (+ivy-do-action! #'+ivy-git-grep-other-window-action))))
      :m "gs" #'+evil/easymotion  ; lazy-load `evil-easymotion'
      (:after evil
        :textobj "x" #'evil-inner-xml-attr               #'evil-outer-xml-attr
        :textobj "a" #'evil-inner-arg                    #'evil-outer-arg
        :textobj "B" #'evil-textobj-anyblock-inner-block #'evil-textobj-anyblock-a-block
        :textobj "i" #'evil-indent-plus-i-indent         #'evil-indent-plus-a-indent
        :textobj "k" #'evil-indent-plus-i-indent-up      #'evil-indent-plus-a-indent-up
        :textobj "j" #'evil-indent-plus-i-indent-up-down #'evil-indent-plus-a-indent-up-down
        (:map evil-window-map
          "s"   #'ace-swap-window
          "u"   #'winner-undo
          "C-r" #'winner-redo
          "g"   #'doom/window-enlargen
          "c"   #'+workspace/close-window-or-workspace
          "|"   #'evil-window-vsplit
          "/"   #'evil-window-vsplit
          "-"   #'evil-window-split
          "d"   #'evil-window-delete))
      :n  "gc"  #'evil-commentary
      (:after sly-mrepl
        :map sly-mrepl-mode-map
        :nvi [up]   #'sly-mrepl-previous-input-or-button
        :nvi [down] #'sly-mrepl-next-input-or-button
        :nvi "C-r" #'isearch-backward)
      (:after evil-magit
        :map (magit-status-mode-map magit-revision-mode-map)
        :n "C-j" nil
        :n "C-k" nil)
      :v  "S"  #'evil-surround-region
      :o  "s"  #'evil-surround-edit
      :o  "S"  #'evil-Surround-edit
      :v  "v"  #'er/expand-region
      :v  "V"  #'er/contract-region
      :m  "]e" #'next-error
      :m  "[e" #'previous-error
      (:after flycheck
        :map flycheck-error-list-mode-map
        :n "C-n" #'flycheck-error-list-next-error
        :n "C-p" #'flycheck-error-list-previous-error
        :n "j"   #'flycheck-error-list-next-error
        :n "k"   #'flycheck-error-list-previous-error
        :n "RET" #'flycheck-error-list-goto-error)
      :m  "]S" #'flyspell-correct-word-generic
      :m  "[S" #'flyspell-correct-previous-word-generic
      (:after flyspell
        (:map flyspell-mouse-map
          "RET" #'flyspell-correct-word-generic
          "<mouse-1>" #'flyspell-correct-word-generic))
      :m  "]d" #'git-gutter:next-hunk
      :m  "[d" #'git-gutter:previous-hunk
      (:after git-timemachine
        (:map git-timemachine-mode-map
          :n "[["  #'git-timemachine-show-previous-revision
          :n "]]"  #'git-timemachine-show-next-revision
          :n "q"   #'git-timemachine-quit
          :n "gb"  #'git-timemachine-blame))
      :m  "]t" #'hl-todo-next
      :m  "[t" #'hl-todo-previous
      (:after ivy
        :map ivy-minibuffer-map
        "C-SPC" #'ivy-call-and-recenter
        "C-l"   #'ivy-alt-done
        "M-z"   #'undo
        "M-v"   #'yank
        "C-v"   #'yank
        "<f20>"   #'djeis97/ivy-complete-ivy-action)
      (:after swiper
        (:map swiper-map
          [backtab]  #'+ivy/wgrep-occur))
      (:after markdown-mode
        (:map markdown-mode-map
          "<backspace>" nil
          "<M-left>"    nil
          "<M-right>"   nil))
      (:when (featurep! :completion company)
        (:after comint
          :map comint-mode-map [tab] #'company-complete))
      (:map* (help-mode-map helpful-mode-map)
        :n "o"  #'ace-link-help
        :n "q"  #'quit-window
        :n "Q"  #'ivy-resume
        :n "]l" #'forward-button
        :n "[l" #'backward-button)
      (:after vc-annotate
        :map vc-annotate-mode-map
        [remap quit-window] #'kill-this-buffer)
      (:after smartparens
        :i "<M-backspace>" #'sp-backward-delete-word))

;;; Leader keybindings

(map! :leader
      :desc "Run Command"               :n "SPC" #'spacemacs/exwm-app-launcher
      :desc "M-x"                       :n "<f20>" #'execute-extended-command
      :desc "Toggle last popup"         :n "`"    #'+popup/toggle
      :desc "Universal Argument"        :n "u" #'universal-argument
      (:when (featurep! :completion ivy)
        :desc "Resume last search"      :n "'"    #'ivy-resume)
      :desc "window"                    :n "w"    evil-window-map
      (:desc "previous..." :prefix "["
        :desc "Buffer"              :nv "b" #'previous-buffer
        :desc "Diff Hunk"           :nv "d" #'git-gutter:previous-hunk
        :desc "Error"               :nv "e" #'previous-error
        :desc "Spelling error"      :nv "s" #'evil-prev-flyspell-error
        :desc "Spelling correction" :n  "S" #'flyspell-correct-previous-word-generic
        :desc "Todo"                :nv "t" #'hl-todo-previous
        :desc "Workspace"           :nv "w" #'+workspace/switch-left
        :desc "Text size"           :nv "[" #'text-scale-decrease)
      (:desc "next..." :prefix "]"
        :desc "Buffer"              :nv "b" #'next-buffer
        :desc "Diff Hunk"           :nv "d" #'git-gutter:next-hunk
        :desc "Error"               :nv "e" #'next-error
        :desc "Todo"                :nv "t" #'hl-todo-next
        :desc "Spelling error"      :nv "s" #'evil-next-flyspell-error
        :desc "Spelling correction" :n  "S" #'flyspell-correct-word-generic
        :desc "Workspace"           :nv "w" #'+workspace/switch-right
        :desc "Text size"           :nv "]" #'text-scale-increase)
      (:desc "workspace" :prefix [tab]
        :desc "Display tab bar"          :n [tab] #'+workspace/display
        :desc "Delete this workspace"    :n "d"   #'+workspace/delete
        :desc "Load workspace from file" :n "l"   #'+workspace/load
        :desc "Load a past session"      :n "L"   #'+workspace/load-session
        :desc "New workspace"            :n "n"   #'+workspace/new
        :desc "Rename workspace"         :n "r"   #'+workspace/rename
        :desc "Restore last session"     :n "R"   #'+workspace/load-last-session
        :desc "Save workspace to file"   :n "s"   #'+workspace/save
        :desc "Autosave current session" :n "S"   #'+workspace/save-session
        :desc "Kill all buffers"         :n "x"   #'doom/kill-all-buffers
        :desc "Delete session"           :n "X"   #'+workspace/kill-session
        :desc "Switch to 1st workspace"  :n "1"   (λ! (+workspace/switch-to 0))
        :desc "Switch to 2nd workspace"  :n "2"   (λ! (+workspace/switch-to 1))
        :desc "Switch to 3rd workspace"  :n "3"   (λ! (+workspace/switch-to 2))
        :desc "Switch to 4th workspace"  :n "4"   (λ! (+workspace/switch-to 3))
        :desc "Switch to 5th workspace"  :n "5"   (λ! (+workspace/switch-to 4))
        :desc "Switch to 6th workspace"  :n "6"   (λ! (+workspace/switch-to 5))
        :desc "Switch to 7th workspace"  :n "7"   (λ! (+workspace/switch-to 6))
        :desc "Switch to 8th workspace"  :n "8"   (λ! (+workspace/switch-to 7))
        :desc "Switch to 9th workspace"  :n "9"   (λ! (+workspace/switch-to 8))
        :desc "Switch workspace"         :n "."   #'+workspace/switch-to
        :desc "Next workspace"           :n "]"   #'+workspace/switch-right
        :desc "Previous workspace"       :n "["   #'+workspace/switch-left)
      (:desc "apps" :prefix "a"
        :desc "Apps"              :n "a" #'counsel-linux-app
        (:desc "Org" :prefix "o"
          :desc "Org agenda"      :n "a" #'org-agenda)
        :desc "REPL"              :n "r" #'+eval/open-repl :v "r" #'+eval:repl
        :desc "Terminal"          :n "t" #'+term/open
        :desc "Terminal in popup" :n "T" #'+term/open-popup-in-project
        :desc "Dired"             :n "-" #'dired-jump)
      (:desc "buffer" :prefix "b"
        :desc "Switch buffer"             :n "b" #'switch-to-buffer
        :desc "Kill buffer"               :n "d" #'kill-this-buffer
        :desc "New empty buffer"          :n "n" #'evil-buffer-new
        :desc "Kill other buffers"        :n "o" #'doom/kill-other-buffers
        :desc "Pop scratch buffer"        :n "s" #'doom/open-scratch-buffer
        :desc "Sudo edit this file"       :n "S" #'doom/sudo-this-file
        (:when (featurep! :feature workspaces)
          :desc "Switch workspace buffer" :n "w" #'persp-switch-to-buffer)
        :desc "Bury buffer"               :n "z" #'bury-buffer
        :desc "Next buffer"               :n "]" #'next-buffer
        :desc "Previous buffer"           :n "[" #'previous-buffer)
      (:desc "code" :prefix "c"
        :desc "Jump to definition" :n "g" #'+lookup/definition
        :desc "Open REPL"          :n "r" #'+eval/open-repl
        :v "r" #'+eval:repl)
      (:desc "file" :prefix "f"
        :desc "Find file"                   :n "f" #'find-file
        :desc "Find directory"              :n "d" #'dired
        :desc "Delete this file"            :n "D" #'doom/delete-this-file
        :desc "Find file in emacs.d"        :n "e" (λ! (doom-project-find-file doom-emacs-dir))
        :desc "Browse emacs.d"              :n "E" (λ! (doom-project-browse doom-emacs-dir))
        :desc "Find file in private config" :n "p" (λ! (doom-project-find-file doom-private-dir))
        :desc "Browse private config"       :n "P" (λ! (doom-project-browse doom-private-dir))
        :desc "Recent files"                :n "r" #'recentf-open-files
        :desc "Rename file"                 :n "R" #'rename-file
        :desc "Save file"                   :n "s" #'save-buffer)
      (:desc "git" :prefix "g"
        :desc "Gist"                  :n "g" #'gist-region-or-buffer
        :desc "Gist (private)"        :n "G" #'gist-region-or-buffer-private
        :desc "Browse issues tracker" :n "i" #'+vc/git-browse-issues
        :desc "Magit buffer log"      :n "l" #'magit-log-buffer-file
        :desc "Browse remote"         :n "o" #'+vc/git-browse
        :desc "Git revert hunk"       :n "r" #'git-gutter:revert-hunk
        :desc "Git revert file"       :n "R" #'vc-revert
        :desc "Magit status"          :n "s" #'magit-status
        :desc "Git time machine"      :n "t" #'git-timemachine-toggle)
      (:desc "help" :prefix "h"
        :n "h" help-map
        :desc "Apropos"               :n "a" #'apropos
        :desc "Describe char"         :n "c" #'describe-char
        :desc "Describe function"     :n "f" #'describe-function
        :desc "Describe face"         :n "F" #'describe-face
        :desc "Info"                  :n "i" #'info-lookup-symbol
        :desc "Describe key"          :n "k" #'describe-key
        :desc "Find library"          :n "l" #'find-library
        :desc "Command log"           :n "L" #'clm/toggle-command-log-buffer
        :desc "Describe mode"         :n "M" #'describe-mode
        :desc "Toggle profiler"       :n "p" #'doom/toggle-profiler
        :desc "Reload theme"          :n "r" #'doom/reload-theme
        :desc "Reload private config" :n "R" #'doom/reload
        :desc "Describe variable"     :n "v" #'describe-variable
        :desc "Describe at point"     :n "." #'helpful-at-point
        :desc "What face"             :n "'" #'doom/what-face
        :desc "What minor modes"      :n ";" #'doom/describe-active-minor-mode)
      (:desc "insert" :prefix "i"
        (:when (featurep! :completion ivy)
          :desc "From evil registers" :nv "r" #'counsel-evil-registers
          :desc "From kill-ring"      :nv "y" #'counsel-yank-pop))
      (:desc "org" :prefix "o"
        :desc "Agenda"               :n "a" #'org-agenda
        :desc "Add file to agenda"   :n "A" #'org-agenda-file-to-front
        :desc "Capture"              :n "c" #'org-capture
        :desc "Copy"                 :n "C" #'org-copy
        :desc "Find org file"        :n "f" #'+default/find-in-notes
        :desc "Browse org directory" :n "d" #'+default/browse-notes
        :desc "Refile"               :n "r" #'org-refile)
      (:desc "project" :prefix "p"
        :desc "Find file in project"   :n "f" #'projectile-find-file
        :desc "Kill buffers"           :n "k" #'projectile-kill-buffers
        :desc "Switch project"         :n "p" #'projectile-switch-project
        :desc "Recent project files"   :n "r" #'projectile-recentf
        :desc "Replace text"           :n "R" #'projectile-replace
        :desc "Search project symbols" :n "s" #'imenu-anywhere
        :desc "List project tasks"     :n "t" #'+ivy/tasks
        :desc "Invalidate cache"       :n "x" #'projectile-invalidate-cache)
      (:desc "quit" :prefix "q"
        :desc "Quit Emacs"            :n "q" #'evil-quit-all
        :desc "Save and quit"         :n "Q" #'evil-save-and-quit
        :desc "Restart Emacs"         :n "R" #'restart-emacs
        :desc "Quit (forget session)" :n "X" #'+workspace/kill-session-and-quit)
      (:desc "search" :prefix "s"
        (:when (featurep! :completion ivy)
          :desc "Buffer"               :nv "b" #'swiper
          :desc "Directory"            :nv "d" #'+ivy/project-search-from-cwd
          :desc "Project"              :nv "p" #'+ivy/project-search)
        :desc "Multi-edit"             :nv "m" #'evil-multiedit-match-all
        :desc "Online providers"       :nv "o" #'+lookup/online-select
        :desc "Tags"                   :nv "t" #'imenu
        :desc "Tags across buffers"    :nv "T" #'imenu-anywhere)
      (:desc "toggle" :prefix "t"
        :desc "Big font mode"     :n "b" #'doom-big-font-mode
        :desc "Flycheck"          :n "f" #'flycheck-mode
        :desc "Frame fullscreen"  :n "F" #'toggle-frame-fullscreen
        :desc "Line numbers"      :n "l" #'doom/toggle-line-numbers
        :desc "Flyspell"          :n "s" #'flyspell-mode))

;;; Local application keybindings

(map!
 (:after sly
   :map sly-mode-map
   :localleader
   :desc "Start Sly"                       :n "'" #'sly
   (:desc "help" :prefix "h"
     :desc "Apropos"                        :n "a" #'sly-apropos
     :desc "Who binds"                      :n "b" #'sly-who-binds
     :desc "Disassemble symbol"             :n "d" #'sly-disassemble-symbol
     :desc "Describe symbol"                :n "h" #'sly-describe-symbol
     :desc "HyperSpec lookup"               :n "H" #'sly-hyperspec-lookup
     :desc "Who macroexpands"               :n "m" #'sly-who-macroexpands
     :desc "Apropos package"                :n "p" #'sly-apropos-package
     :desc "Who references"                 :n "r" #'sly-who-references
     :desc "Who specializes"                :n "s" #'sly-who-specializes
     :desc "Who sets"                       :n "S" #'sly-who-sets
     :desc "Who calls"                      :n "<" #'sly-who-calls
     :desc "Calls who"                      :n ">" #'sly-calls-who)
   (:desc "compile" :prefix "c"
     :desc "Compile file"                   :n "c" #'sly-compile-file
     :desc "Compile/load file"              :n "C" #'sly-compile-and-load-file
     :desc "Compile defun"                  :n "f" #'sly-compile-defun
     :desc "Load file"                      :n "l" #'sly-load-file
     :desc "Remove notes"                   :n "n" #'sly-remove-notes
     :desc "Compile region"                 :n "r" #'sly-compile-region)
   (:desc "evaluate" :prefix "e"
     :desc "Evaluate buffer"                :n "b" #'sly-eval-buffer
     :desc "Evaluate last expression"       :n "e" #'sly-eval-last-expression
     :desc "Evaluate/print last expression" :n "E" #'sly-eval-print-last-expression
     :desc "Evaluate defun"                 :n "f" #'sly-eval-defun
     :desc "Undefine function"              :n "F" #'sly-undefine-function
     :desc "Evaluate region"                :n "r" #'sly-eval-region)
   (:desc "go"                             :n "g" #'mfiano/lisp-navigation/body)
   (:desc "macro" :prefix "m"
     :desc "Macro-expand 1 level"           :n "e" #'sly-macroexpand-1
     :desc "Macro-expand all"               :n "E" #'sly-macroexpand-all
     :desc "Macro stepper"                  :n "s" #'mfiano/lisp-macrostep/body)
   (:desc "repl" :prefix "r"
     :desc "Clear REPL"                     :n "c" #'sly-mrepl-clear-repl
     :desc "Quit Lisp"                      :n "q" #'sly-quit-lisp
     :desc "Restart Lisp"                   :n "r" #'sly-restart-inferior-lisp
     :desc "Sync REPL"                      :n "s" #'sly-mrepl-sync)
   (:desc "stickers" :prefix "s"
     :desc "Toggle break on sticker"        :n "b" #'sly-stickers-toggle-break-on-stickers
     :desc "Clear defun stickers"           :n "c" #'sly-stickers-clear-defun-stickers
     :desc "Clear buffer stickers"          :n "C" #'sly-stickers-clear-buffer-stickers
     :desc "Fetch sticker recordings"       :n "f" #'sly-stickers-fetch
     :desc "Replay sticker recordings"      :n "r" #'sly-stickers-replay
     :desc "Add/remove stickers"            :n "s" #'sly-stickers-dwim)
   (:desc "trace" :prefix "t"
     :desc "Toggle tracing"                 :n "t" #'sly-toggle-trace-fdefinition
     :desc "Toggle fancy tracing"           :n "T" #'sly-toggle-fancy-trace
     :desc "Un-trace all"                   :n "u" #'sly-untrace-all)))

(after! hydra
  (after! sly
    (defhydra mfiano/lisp-navigation (:exit nil :hint nil :foreign-keys run)
      "
^^Definitions                           ^^Compiler Notes             ^^Stickers
^^^^^^─────────────────────────────────────────────────────────────────────────────────────
[_g_] Jump to definition                [_n_] Next compiler note     [_s_] Next sticker
[_G_] Jump to definition (other window) [_N_] Previous compiler note [_S_] Previous sticker
[_b_] Pop from definition
[_q_] Exit
"
      ("g" sly-edit-definition)
      ("G" sly-edit-definition-other-window)
      ("b" sly-pop-find-definition-stack)
      ("n" sly-next-note)
      ("N" sly-previous-note)
      ("s" sly-stickers-next-sticker)
      ("S" sly-stickers-prev-sticker)
      ("q" nil :exit t)))

  (after! sly-macrostep
    (defhydra mfiano/lisp-macrostep (:exit nil :hint nil :foreign-keys run)
      "
Macro Expansion
^^Definitions                           ^^Compiler Notes             ^^Stickers
^^^^^^─────────────────────────────────────────────────────────────────────────────────────
[_e_] Expand
[_c_] Collapse
[_n_] Next level
[_N_] Previous level
[_q_] Exit
"
      ("e" macrostep-expand)
      ("c" macrostep-collapse)
      ("n" macrostep-next-macro)
      ("N" macrostep-prev-macro)
      ("q" macrostep-collapse-all :exit t))))

;;; Keybinding fixes

(define-key universal-argument-map
  (kbd (concat doom-leader-key " u")) #'universal-argument-more)

(defun +default|setup-input-decode-map ()
  (define-key input-decode-map (kbd "TAB") [tab]))
(add-hook 'tty-setup-hook #'+default|setup-input-decode-map)

(after! tabulated-list
  (define-key tabulated-list-mode-map "q" #'quit-window))

(when (featurep! :feature evil +everywhere)
  (define-key! evil-ex-completion-map
    "\C-s" (if (featurep! :completion ivy)
               #'counsel-minibuffer-history
             #'helm-minibuffer-history)
    "\C-a" #'move-beginning-of-line
    "\C-b" #'backward-word
    "\C-f" #'forward-word)

  (after! view
    (define-key view-mode-map [escape] #'View-quit-all)))

(defun +default|fix-minibuffer-in-map (map)
  (define-key! map
    "\C-s" (if (featurep! :completion ivy)
               #'counsel-minibuffer-history
             #'helm-minibuffer-history)
    "\C-a" #'move-beginning-of-line
    "\C-w" #'backward-kill-word
    "\C-u" #'backward-kill-sentence
    "\C-b" #'backward-word
    "\C-f" #'forward-word
    "\C-z" (λ! (ignore-errors (call-interactively #'undo))))
  (when (featurep! :feature evil +everywhere)
    (define-key! map
      [escape] #'abort-recursive-edit
      "\C-r" #'evil-paste-from-register
      "\C-j" #'next-line
      "\C-k" #'previous-line
      (kbd "C-S-j") #'scroll-up-command
      (kbd "C-S-k") #'scroll-down-command)))

(mapc #'+default|fix-minibuffer-in-map
      (list minibuffer-local-map
            minibuffer-local-ns-map
            minibuffer-local-completion-map
            minibuffer-local-must-match-map
            minibuffer-local-isearch-map
            read-expression-map))

(after! ivy (+default|fix-minibuffer-in-map ivy-minibuffer-map))

(after! man
  (evil-define-key* 'normal Man-mode-map "q" #'kill-this-buffer))

(setq evil-collection-key-blacklist
      (list "C-j" "C-k" "gd" "gf" "K" "[" "]" "gz"
            doom-leader-key doom-localleader-key))

;; Make things do their jobs
;; (global-set-key (kbd "<f20>") (lookup-key evil-normal-state-map (kbd "<f20>")))
;; (evil-global-set-key 'normal (kbd "SPC") (lookup-key evil-normal-state-map (kbd "<f20>")))
;; (evil-global-set-key 'visual (kbd "SPC") (lookup-key evil-visual-state-map (kbd "<f20>")))
