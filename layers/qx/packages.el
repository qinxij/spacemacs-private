(setq qx-packages
      '(
        org-page
        (ego :location local)
        chinese-fonts-setup
        org-webpage
        (org :location built-in)
        (evil-org :location local)
        (org-agenda :location built-in)
        org-mobile-sync
        eshell
        eshell-autojump
        monokai-theme
        solarized-theme
        virtualenvwrapper
        eshell-prompt-extras
        mwe-log-commands
        smex
        4clojure
        ))

(defun qx/init-org-page ()
  (use-package org-page
    :defer t
    :init
    (progn
      ;; do something before load the package
      (setq op/repository-directory "~/ws/org_p/org-page-blog")        ;; the repository location
      (setq op/site-domain "http://localhost:8222/")                 ;; your domain
      ;;; the configuration below you should choose one, not both
      (setq op/personal-disqus-shortname "qx_disqus_shortname")    ;; your disqus commenting system
      (setq op/personal-duoshuo-shortname "qx_duoshuo_shortname")  ;; your duoshuo commenting system
      (setq op/site-main-title "Q.X. ij")
      (setq op/site-sub-title "Qin Xerxes' Incredible Journey")

      (with-eval-after-load 'org (require 'org-page))
      )
    :config
    (progn
      ;; do something after load the package
      )))

(defun qx/init-ego ()
  (use-package ego
      :defer t
      :init
      (progn
        ;; do something before load the package
        (add-to-list 'load-path "~/.emacs.d/private/local/EGO")
        )
      :config
      (progn
        ;; do something after load the package
        (ego/add-to-alist 'ego/project-config-alist
                          `(("ego-blog" ; 站点工程的名字
                             :repository-directory "~/ws/org_p/ego-blog" ; 站点的本地目录
                             :site-domain "http://qinxij.github.io/" ; 站点的网址
                             :site-main-title "Ego Blog" ; 站点的标题
                             :site-sub-title "Egg or ego or eeg some blog" ; 站点的副标题
                             :theme (default) ; 使用的主题
                             :summary (("years" :year :updates 10) ("authors" :authors) ("tags" :tags)) ; 导航栏的设置，有 category 和 summary 两种
                             :source-browse-url ("Github" "https://github.com/qinxij") ; 你的工程源代码所在的位置
                             :personal-disqus-shortname "ego-blog" ; 使用 disqus 评论功能的话，它的短名称
                             :personal-duoshuo-shortname "ego-blog" ; 使用 多说 评论功能的话，它的短名称
                             :confound-email nil ; 是否保护邮件名称呢？t 是保护，nil 是不保护，默认是保护
                             :ignore-file-name-regexp "readme.org" ; 有些不想发布成 html 的 org 文件（但是又想被导入 git 进行管理），可以用这种正则表达的方式排除
                             :web-server-docroot "~/org_p/ego-blog-test" ; 本地测试的目录
                             :web-server-port 5432); 本地测试的端口

                            ;; 你可以在此添加更多的站点设置
                            ))
        )))

(defun qx/init-org-webpage ()
  (use-package org-webpage
      :defer t
      :init
      (progn
        (with-eval-after-load 'org (require 'org-webpage))
        )
      :config
      (progn
        (progn
          (owp/add-project-config
           '("org-webpage-page"
             :repository-directory "~/ws/org_p/org-webpage-page"
             :remote (git "https://github.com/qinxij/org-webpage-page.git" "gh-pages")
             :site-domain "http://qinxij.github.io/org-webpage-page"
             :site-main-title "qx org-webpage"
             :site-sub-title "(九天十地，太上忘情！！！)"
             :theme (worg killjs)
             :source-browse-url ("Github" "https://github.io/qinxij/org-webpage-page")
             :personal-avatar "/media/img/horse.jpg"
             :personal-duoshuo-shortname "qx-org-webpage"
             :web-server-port 7654))
          )
        )))

(defun qx/init-chinese-fonts-setup ()
  (use-package chinese-fonts-setup
      :defer t
      :init
      (progn
        (require 'chinese-fonts-setup)
        (setq cfs-profiles-directory "~/.emacs.d/private/chinese-fonts-setup/")
        (setq cfs-profiles '("programming" "org-mode" "read-book"))
        (setq cfs--fontsize-steps '(5 5 5)) ;; 将字号设置为第cfs--current-profile-name 中5行的字号
        (setq cfs--current-profile-name "programming"))
      :config
      (progn
        )
      ))

(defun qx/post-init-org ()
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "SOMEDAY(s)" "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELED(c@)" "PHONE" "MEETING")))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("NEXT" :foreground "blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("SOMEDAY" :foreground "orange" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "magenta" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold)
                ("MEETING" :foreground "forest green" :weight bold)
                ("PHONE" :foreground "forest green" :weight bold))))
  (setq org-tag-alist '((:startgroup . nil) ;; 组内的tags相互排斥
                        ("@work" . ?w) ("@home" . ?h)
                        (:endgroup .nil)
                        ("laptop" . ?l)))

  ;; allows changing todo states with S-left and S-right skipping all of
  ;; the normal processing when entering or leaving a todo state.
  ;; skip setting timestramps and notes
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)

  (setq org-directory "~/Documents/org-d")
  (defun qx/org-d-file (filename)
    (concat org-directory "/" filename))

  ;; Capture templates for: TODO tasks, Notes, appointments, phone calls,
  ;; meetings, and org-protocol
  (setq org-capture-templates
        (quote (("t" "todo"       entry (file+headline (qx/org-d-file "inbox.org") "Tasks")
                 "* TODO %?\n%U\n%a\n")
                ("r" "respond"    entry (file+headline (qx/org-d-file "inbox.org") "Respond Emails")
                 "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
                ("n" "note"       entry (file (qx/org-d-file "inbox.org"))
                 "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
                ("j" "Journal"    entry (file+datetree (qx/org-d-file "diary.org"))
                 "* %?\n%U\n" :clock-in t :clock-resume t)
                ("w" "org-protocol" entry (file (qx/org-d-file "inbox.org"))
                 "* TODO Review %c\n%U\n%i\n" :immediate-finish t)
                ("m" "Meeting"    entry (file (qx/org-d-file "inbox.org"))
                 "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
                ("p" "Phone call" entry (file (qx/org-d-file "inbox.org"))
                 "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
                ("h" "Habit"      entry (file (qx/org-d-file "inbox.org"))
                 "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

  ;; ======= Refile settings  =======
  ;; let any file in =org-agenda-files= and the current file
  ;; contribute to the list of valid refile targets.
  ;; Targets include this file and any file contributing to the agenda
  ;; - up to 9 levels deep
  (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                   (org-agenda-files :maxlevel . 9))))

  ;; Use full outline paths for refile targets - we file directly with IDO
  (setq org-refile-use-outline-path t)

  ;; Targets complete directly with IDO
  (setq org-outline-path-complete-in-steps nil)

  ;; Allow refile to create parent tasks with confirmation
  (setq org-refile-allow-creating-parent-nodes (quote confirm))

  ;; Use IDO for both buffer and file completion and ido-everywhere to t
  (setq org-completion-use-ido t)
  (setq ido-everywhere t)
  (setq ido-max-directory-size 100000)
  (ido-mode (quote both))
  ;; Use the current window when visiting files and buffers with ido
  (setq ido-default-file-method 'selected-window)
  (setq ido-default-buffer-method 'selected-window)
  ;; Use the current window for indirect buffer display
  (setq org-indirect-buffer-display 'current-window)

  ;; Exclude DONE state tasks from refile targets
  (defun qx/verify-refile-target ()
    "Exclude todo keywords with a done state from refile targets"
    (not (member (nth 2 (org-heading-components)) org-done-keywords)))

  (setq org-refile-target-verify-function 'qx/verify-refile-target)

  ;; Org HTML export
  (setq org-html-doctype "html5"
        org-html-html5-fancy t)
  )

(defun qx/post-init-org-agenda ()
  (setq org-agenda-files (list (qx/org-d-file "inbox.org")
                               (qx/org-d-file "tasks.org")
                               (qx/org-d-file "projects.org")
                               (qx/org-d-file "finished.org")
                               (qx/org-d-file "notes.org")
                               (qx/org-d-file "trash.org")
                               ))

  ; Do not dim blocked tasks
  (setq org-agenda-dim-blocked-tasks nil)

  ;; Compact the block agenda view
  (setq org-agenda-compact-blocks t)

  ;; Custom agenda command definitions
  (setq org-agenda-custom-commands
        (quote (("N" "Notes" tags "NOTE"
                 ((org-agenda-overriding-header "Notes")
                  (org-tags-match-list-sublevels t)))
                ("h" "Habits" tags-todo "STYLE=\"habit\""
                 ((org-agenda-overriding-header "Habits")
                  (org-agenda-sorting-strategy
                   '(todo-state-down effort-up category-keep))))
                ;; ("A" "Agenda"
                ;;  ((agenda "" nil)
                ;;   (tags "REFILE"
                ;;         ((org-agenda-overriding-header "Tasks to Refile")
                ;;          (org-tags-match-list-sublevels nil)))
                ;;   (tags-todo "-CANCELLED/!"
                ;;              ((org-agenda-overriding-header "Stuck Projects")
                ;;               (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                ;;               (org-agenda-sorting-strategy
                ;;                '(category-keep))))
                ;;   (tags-todo "-HOLD-CANCELLED/!"
                ;;              ((org-agenda-overriding-header "Projects")
                ;;               (org-agenda-skip-function 'bh/skip-non-projects)
                ;;               (org-tags-match-list-sublevels 'indented)
                ;;               (org-agenda-sorting-strategy
                ;;                '(category-keep))))
                ;;   (tags-todo "-CANCELLED/!NEXT"
                ;;              ((org-agenda-overriding-header (concat "Project Next Tasks"
                ;;                                                     (if bh/hide-scheduled-and-waiting-next-tasks
                ;;                                                         ""
                ;;                                                       " (including WAITING and SCHEDULED tasks)")))
                ;;               (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                ;;               (org-tags-match-list-sublevels t)
                ;;               (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-sorting-strategy
                ;;                '(todo-state-down effort-up category-keep))))
                ;;   (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                ;;              ((org-agenda-overriding-header (concat "Project Subtasks"
                ;;                                                     (if bh/hide-scheduled-and-waiting-next-tasks
                ;;                                                         ""
                ;;                                                       " (including WAITING and SCHEDULED tasks)")))
                ;;               (org-agenda-skip-function 'bh/skip-non-project-tasks)
                ;;               (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-sorting-strategy
                ;;                '(category-keep))))
                ;;   (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                ;;              ((org-agenda-overriding-header (concat "Standalone Tasks"
                ;;                                                     (if bh/hide-scheduled-and-waiting-next-tasks
                ;;                                                         ""
                ;;                                                       " (including WAITING and SCHEDULED tasks)")))
                ;;               (org-agenda-skip-function 'bh/skip-project-tasks)
                ;;               (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-sorting-strategy
                ;;                '(category-keep))))
                ;;   (tags-todo "-CANCELLED+WAITING|HOLD/!"
                ;;              ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                ;;                                                     (if bh/hide-scheduled-and-waiting-next-tasks
                ;;                                                         ""
                ;;                                                       " (including WAITING and SCHEDULED tasks)")))
                ;;               (org-agenda-skip-function 'bh/skip-non-tasks)
                ;;               (org-tags-match-list-sublevels nil)
                ;;               (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                ;;               (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
                ;;   (tags "-REFILE/"
                ;;         ((org-agenda-overriding-header "Tasks to Archive")
                ;;          (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                ;;          (org-tags-match-list-sublevels nil))))
                ;;  nil)
                )))
  )

(defun qx/init-org-mobile-sync ()
  (use-package org-mobile-sync
      :defer t
      :init
      (progn
        (setq org-mobile-directory "~/Jianguoyun/MobileOrg/"
              org-mobile-use-encryption t)
        )
      :config
      (progn
        ;; do something after load the package
        )))

(defun qx/post-init-evil-org ()
  ;; org-shiftup, down, left, right
  (evil-define-key 'normal evil-org-mode-map (kbd "C-S-k") 'org-shiftup)
  (evil-define-key 'normal evil-org-mode-map (kbd "C-S-j") 'org-shiftdown)
  (evil-define-key 'normal evil-org-mode-map (kbd "C-S-h") 'org-shiftleft)
  (evil-define-key 'normal evil-org-mode-map (kbd "C-S-l") 'org-shiftright)

  ;; subtree
  (evil-define-key 'normal evil-org-mode-map (kbd ", S b") 'show-branches)
  (evil-define-key 'normal evil-org-mode-map (kbd ", S i") 'org-tree-to-indirect-buffer)
  (evil-define-key 'normal evil-org-mode-map (kbd ", S c") 'org-cut-subtree)
  (evil-define-key 'normal evil-org-mode-map (kbd ", S y") 'org-copy-subtree)
  (evil-define-key 'normal evil-org-mode-map (kbd ", S p") 'org-paste-subtree)
  (evil-define-key 'normal evil-org-mode-map (kbd ", S s") 'org-clone-subtree-with-time-shift)

  ;; org-goto
  (evil-define-key 'normal evil-org-mode-map (kbd ", g g") 'org-goto)

  ;; Toggle heading/正文
  (evil-define-key 'normal evil-org-mode-map (kbd ", h t") 'org-ctrl-c-star)

  ;; 快捷export
  (evil-define-key 'normal evil-org-mode-map (kbd "\\ s") 'org-html-export-to-html)
  (evil-define-key 'normal evil-org-mode-map (kbd "\\ m") 'org-md-export-to-markdown)

  ;; org agenda
  (evil-define-key 'normal evil-org-mode-map (kbd ", [") 'org-agenda-file-to-front)
  (evil-define-key 'normal evil-org-mode-map (kbd ", ]") 'org-remove-file)
  (evil-define-key 'normal evil-org-mode-map (kbd ", <") 'org-agenda-set-restriction-lock)
  (evil-define-key 'normal evil-org-mode-map (kbd ", >") 'org-agenda-remove-restriction-lock)

  ;; columns view
  (evil-define-key 'normal evil-org-mode-map (kbd ", C v") 'org-columns)
  )


(defun qx/init-eshell ()
  (use-package eshell
      :defer t
      :init
      (progn
        ;; do something before load the package
        )
      :config
      (progn
        (require 'eshell-autojump)
        (evil-define-key 'insert eshell-mode-map (kbd "C-r") 'helm-eshell-history)
        (evil-define-key 'insert eshell-mode-map (kbd "C-r") 'helm-eshell-history)
        )))

(defun qx/init-eshell-autojump ()
  (use-package eshell-autojump
      :defer t
      :init
      (progn
        ;; do something before load the package
        )
      :config
      (progn
        ;; do something after load the package
        )))

(defun qx/init-monokai-theme ()
  (use-package monokai-theme
      :defer t
      :init
      (progn
        ;; do something before load the package
        )
      :config
      (progn
        ;; do something after load the package
        )))

(defun qx/init-solarized-theme ()
  (use-package solarized-theme
      :defer t
      :init
      (progn
        ;; do something before load the package
        )
      :config
      (progn
        ;; do something after load the package
        )))

(defun qx/init-virtualenvwrapper ()
  (use-package virtualenvwrapper
      :defer t
      :init
      (progn
        ;; do something before load the package
        )
      :config
      (progn
        ;; do something after load the package
        )))

(defun qx/init-eshell-prompt-extras ()
  (use-package eshell-prompt-extras
      :defer t
      :init
      (progn
        (with-eval-after-load "esh-opt"
          (require 'virtualenvwrapper)
          (venv-initialize-eshell)
          (autoload 'epe-theme-lambda "eshell-prompt-extras")
          (setq eshell-highlight-prompt nil
                eshell-prompt-function 'epe-theme-lambda))
        )
      :config
      (progn
        ;; do something after load the package
        )))

(defun qx/init-mwe-log-commands ()
  (use-package mwe-log-commands
      :defer t
      :init
      (progn
        (evil-leader/set-key
          "oll" 'mwe:log-keyboard-commands
          "olf" 'mwe:open-command-log-buffer)
        )
      :config
      (progn
        ;; do something after load the package
        )))

(defun qx/post-init-smex ()
  (with-eval-after-load 'smex
    (qx/mmap (kbd "<backspace>") 'smex)))

(defun qx/init-4clojure ()
  (use-package 4clojure
      :defer t
      :init
      (progn
        )
      :config
      (progn
        ;; do something after load the package
        (qx/mmap (kbd "C-S-j") '4clojure-next-question)
        (qx/mmap (kbd "C-S-k") '4clojure-previous-question)
        (qx/mmap (kbd "C-S-l") '4clojure-check-answers)
        )))
