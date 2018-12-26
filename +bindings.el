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
      :desc "Run Command"               "SPC" #'spacemacs/exwm-app-launcher
      :desc "M-x"                       "<f20>" #'execute-extended-command
      :desc "Toggle last popup"         "`"    #'+popup/toggle
      :desc "Universal Argument"        "u" #'universal-argument
      (:when (featurep! :completion ivy)
        :desc "Resume last search"      "'"    #'ivy-resume)
      :desc "window"                    "w"    evil-window-map
      (:prefix ("[" . "previous...")
        :desc "Buffer"              "b" #'previous-buffer
        :desc "Diff Hunk"           "d" #'git-gutter:previous-hunk
        :desc "Error"               "e" #'previous-error
        :desc "Spelling error"      "s" #'evil-prev-flyspell-error
        :desc "Spelling correction" "S" #'flyspell-correct-previous-word-generic
        :desc "Todo"                "t" #'hl-todo-previous
        :desc "Workspace"           "w" #'+workspace/switch-left
        :desc "Text size"           "[" #'text-scale-decrease)
      (:prefix ("]" . "next...")
        :desc "Buffer"              "b" #'next-buffer
        :desc "Diff Hunk"           "d" #'git-gutter:next-hunk
        :desc "Error"               "e" #'next-error
        :desc "Todo"                "t" #'hl-todo-next
        :desc "Spelling error"      "s" #'evil-next-flyspell-error
        :desc "Spelling correction" "S" #'flyspell-correct-word-generic
        :desc "Workspace"           "w" #'+workspace/switch-right
        :desc "Text size"           "]" #'text-scale-increase)
      (:desc "workspace" :prefix [tab]
        :desc "Display tab bar"          [tab] #'+workspace/display
        :desc "Delete this workspace"    "d"   #'+workspace/delete
        :desc "Load workspace from file" "l"   #'+workspace/load
        :desc "Load a past session"      "L"   #'+workspace/load-session
        :desc "New workspace"            "n"   #'+workspace/new
        :desc "Rename workspace"         "r"   #'+workspace/rename
        :desc "Restore last session"     "R"   #'+workspace/load-last-session
        :desc "Save workspace to file"   "s"   #'+workspace/save
        :desc "Autosave current session" "S"   #'+workspace/save-session
        :desc "Kill all buffers"         "x"   #'doom/kill-all-buffers
        :desc "Delete session"           "X"   #'+workspace/kill-session
        :desc "Switch to 1st workspace"  "1"   (λ! (+workspace/switch-to 0))
        :desc "Switch to 2nd workspace"  "2"   (λ! (+workspace/switch-to 1))
        :desc "Switch to 3rd workspace"  "3"   (λ! (+workspace/switch-to 2))
        :desc "Switch to 4th workspace"  "4"   (λ! (+workspace/switch-to 3))
        :desc "Switch to 5th workspace"  "5"   (λ! (+workspace/switch-to 4))
        :desc "Switch to 6th workspace"  "6"   (λ! (+workspace/switch-to 5))
        :desc "Switch to 7th workspace"  "7"   (λ! (+workspace/switch-to 6))
        :desc "Switch to 8th workspace"  "8"   (λ! (+workspace/switch-to 7))
        :desc "Switch to 9th workspace"  "9"   (λ! (+workspace/switch-to 8))
        :desc "Switch workspace"         "."   #'+workspace/switch-to
        :desc "Next workspace"           "]"   #'+workspace/switch-right
        :desc "Previous workspace"       "["   #'+workspace/switch-left)
      (:prefix ("a" . "apps")
        :desc "Apps"              "a" #'counsel-linux-app
        (:prefix ("o" . "Org")
          :desc "Org agenda"      "a" #'org-agenda)
        :desc "REPL"              "r" #'+eval/open-repl :v "r" #'+eval:repl
        :desc "Terminal"          "t" #'+term/open
        :desc "Terminal in popup" "T" #'+term/open-popup-in-project
        :desc "Dired"             "-" #'dired-jump)
      (:prefix ("b" . "buffer")
        :desc "Switch buffer"             "b" #'switch-to-buffer
        :desc "Kill buffer"               "d" #'kill-this-buffer
        :desc "New empty buffer"          "n" #'evil-buffer-new
        :desc "Kill other buffers"        "o" #'doom/kill-other-buffers
        :desc "Pop scratch buffer"        "s" #'doom/open-scratch-buffer
        :desc "Sudo edit this file"       "S" #'doom/sudo-this-file
        (:when (featurep! :feature workspaces)
          :desc "Switch workspace buffer" "w" #'persp-switch-to-buffer)
        :desc "Bury buffer"               "z" #'bury-buffer
        :desc "Next buffer"               "]" #'next-buffer
        :desc "Previous buffer"           "[" #'previous-buffer)
      (:prefix ("c" . "code")
        :desc "Jump to definition" "g" #'+lookup/definition
        :desc "Open REPL"          "r" #'+eval/open-repl
        :v "r" #'+eval:repl)
      (:prefix ("f" . "file")
        :desc "Find file"                   "f" #'find-file
        :desc "Find directory"              "d" #'dired
        :desc "Delete this file"            "D" #'doom/delete-this-file
        :desc "Find file in emacs.d"        "e" (λ! (doom-project-find-file doom-emacs-dir))
        :desc "Browse emacs.d"              "E" (λ! (doom-project-browse doom-emacs-dir))
        :desc "Find file in private config" "p" (λ! (doom-project-find-file doom-private-dir))
        :desc "Browse private config"       "P" (λ! (doom-project-browse doom-private-dir))
        :desc "Recent files"                "r" #'recentf-open-files
        :desc "Rename file"                 "R" #'rename-file
        :desc "Save file"                   "s" #'save-buffer)
      (:prefix ("g" . "git")
        :desc "Gist"                  "g" #'gist-region-or-buffer
        :desc "Gist (private)"        "G" #'gist-region-or-buffer-private
        :desc "Browse issues tracker" "i" #'+vc/git-browse-issues
        :desc "Magit buffer log"      "l" #'magit-log-buffer-file
        :desc "Browse remote"         "o" #'+vc/git-browse
        :desc "Git revert hunk"       "r" #'git-gutter:revert-hunk
        :desc "Git revert file"       "R" #'vc-revert
        :desc "Magit status"          "s" #'magit-status
        :desc "Git time machine"      "t" #'git-timemachine-toggle)
      (:prefix ("h" . "help")
        :n "h" help-map
        :desc "Apropos"               "a" #'apropos
        :desc "Describe char"         "c" #'describe-char
        :desc "Describe function"     "f" #'describe-function
        :desc "Describe face"         "F" #'describe-face
        :desc "Info"                  "i" #'info-lookup-symbol
        :desc "Describe key"          "k" #'describe-key
        :desc "Find library"          "l" #'find-library
        :desc "Command log"           "L" #'clm/toggle-command-log-buffer
        :desc "Describe mode"         "M" #'describe-mode
        :desc "Toggle profiler"       "p" #'doom/toggle-profiler
        :desc "Reload theme"          "r" #'doom/reload-theme
        :desc "Reload private config" "R" #'doom/reload
        :desc "Describe variable"     "v" #'describe-variable
        :desc "Describe at point"     "." #'helpful-at-point
        :desc "What face"             "'" #'doom/what-face
        :desc "What minor modes"      ";" #'doom/describe-active-minor-mode)
      (:prefix ("i" . "insert")
        (:when (featurep! :completion ivy)
          :desc "From evil registers" "r" #'counsel-evil-registers
          :desc "From kill-ring"      "y" #'counsel-yank-pop))
      (:prefix ("o" . "org")
        :desc "Agenda"               "a" #'org-agenda
        :desc "Add file to agenda"   "A" #'org-agenda-file-to-front
        :desc "Capture"              "c" #'org-capture
        :desc "Copy"                 "C" #'org-copy
        :desc "Find org file"        "f" #'+default/find-in-notes
        :desc "Browse org directory" "d" #'+default/browse-notes
        :desc "Refile"               "r" #'org-refile)
      (:prefix ("p" . "project")
        :desc "Find file in project"   "f" #'projectile-find-file
        :desc "Kill buffers"           "k" #'projectile-kill-buffers
        :desc "Switch project"         "p" #'projectile-switch-project
        :desc "Recent project files"   "r" #'projectile-recentf
        :desc "Replace text"           "R" #'projectile-replace
        :desc "Search project symbols" "s" #'imenu-anywhere
        :desc "List project tasks"     "t" #'+ivy/tasks
        :desc "Invalidate cache"       "x" #'projectile-invalidate-cache)
      (:prefix ("q" . "quit")
        :desc "Quit Emacs"            "q" #'evil-quit-all
        :desc "Save and quit"         "Q" #'evil-save-and-quit
        :desc "Restart Emacs"         "R" #'restart-emacs
        :desc "Quit (forget session)" "X" #'+workspace/kill-session-and-quit)
      (:prefix ("s" . "search")
        (:when (featurep! :completion ivy)
          :desc "Buffer"               "b" #'swiper
          :desc "Directory"            "d" #'+ivy/project-search-from-cwd
          :desc "Project"              "p" #'+ivy/project-search)
        :desc "Multi-edit"             "m" #'evil-multiedit-match-all
        :desc "Online providers"       "o" #'+lookup/online-select
        :desc "Tags"                   "t" #'imenu
        :desc "Tags across buffers"    "T" #'imenu-anywhere)
      (:prefix ("t" . "toggle")
        :desc "Big font mode"     "b" #'doom-big-font-mode
        :desc "Flycheck"          "f" #'flycheck-mode
        :desc "Frame fullscreen"  "F" #'toggle-frame-fullscreen
        :desc "Line numbers"      "l" #'doom/toggle-line-numbers
        :desc "Flyspell"          "s" #'flyspell-mode))

;;; Local application keybindings

(map!
 (:after sly
   :map sly-mode-map
   :localleader
   :desc "Start Sly"                       :n "'" #'sly
   (:prefix ("h" . "help")
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
   (:prefix ("c" . "compile")
     :desc "Compile file"                   :n "c" #'sly-compile-file
     :desc "Compile/load file"              :n "C" #'sly-compile-and-load-file
     :desc "Compile defun"                  :n "f" #'sly-compile-defun
     :desc "Load file"                      :n "l" #'sly-load-file
     :desc "Remove notes"                   :n "n" #'sly-remove-notes
     :desc "Compile region"                 :n "r" #'sly-compile-region)
   (:prefix ("e" . "evaluate")
     :desc "Evaluate buffer"                :n "b" #'sly-eval-buffer
     :desc "Evaluate last expression"       :n "e" #'sly-eval-last-expression
     :desc "Evaluate/print last expression" :n "E" #'sly-eval-print-last-expression
     :desc "Evaluate defun"                 :n "f" #'sly-eval-defun
     :desc "Undefine function"              :n "F" #'sly-undefine-function
     :desc "Evaluate region"                :n "r" #'sly-eval-region)
   (:desc "go"                             :n "g" #'mfiano/lisp-navigation/body)
   (:prefix ("m" . "macro")
     :desc "Macro-expand 1 level"           :n "e" #'sly-macroexpand-1
     :desc "Macro-expand all"               :n "E" #'sly-macroexpand-all
     :desc "Macro stepper"                  :n "s" #'mfiano/lisp-macrostep/body)
   (:prefix ("r" . "repl")
     :desc "Clear REPL"                     :n "c" #'sly-mrepl-clear-repl
     :desc "Quit Lisp"                      :n "q" #'sly-quit-lisp
     :desc "Restart Lisp"                   :n "r" #'sly-restart-inferior-lisp
     :desc "Sync REPL"                      :n "s" #'sly-mrepl-sync)
   (:prefix ("s" . "stickers")
     :desc "Toggle break on sticker"        :n "b" #'sly-stickers-toggle-break-on-stickers
     :desc "Clear defun stickers"           :n "c" #'sly-stickers-clear-defun-stickers
     :desc "Clear buffer stickers"          :n "C" #'sly-stickers-clear-buffer-stickers
     :desc "Fetch sticker recordings"       :n "f" #'sly-stickers-fetch
     :desc "Replay sticker recordings"      :n "r" #'sly-stickers-replay
     :desc "Add/remove stickers"            :n "s" #'sly-stickers-dwim)
   (:prefix ("t" . "trace")
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
  (map!
   (:map map
     "C-s" (if (featurep! :completion ivy)
               #'counsel-minibuffer-history
             #'helm-minibuffer-history)
     "C-a" #'move-beginning-of-line
     "C-w" #'backward-kill-word
     "C-u" #'backward-kill-sentence
     "C-b" #'backward-word
     "C-f" #'forward-word
     "C-z" (λ! (ignore-errors (call-interactively #'undo)))
     (:when (featurep! :feature evil +everywhere)
       [escape] #'abort-recursive-edit
       "C-r" #'evil-paste-from-register
       "C-j" #'next-line
       "C-k" #'previous-line
       "C-S-j" #'scroll-up-command
       "C-S-k" #'scroll-down-command))))

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

(global-set-key (kbd "<f20>") 'doom-leader)
