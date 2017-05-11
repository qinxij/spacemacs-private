;; ======================================================================
;; UTF-8
;; http://blog.sina.com.cn/s/blog_71906a600100nw7j.html
;; ======================================================================
;; For my language code setting (UTF-8)
;; (setq current-language-environment "UTF-8")
;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)


;; ======================================================================
;; Org
;; Org as a Word Processor:
;; http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
;; ======================================================================
;; (setq org-hide-emphasis-markers t)

(if window-system
    (let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                                 ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                                 ((x-list-fonts "Verdana")         '(:font "Verdana"))
                                 ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                                 (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
           (base-font-color     (face-foreground 'default nil 'default))
           (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

      (custom-theme-set-faces 'user
                              `(org-level-8 ((t (,@headline ,@variable-tuple))))
                              `(org-level-7 ((t (,@headline ,@variable-tuple))))
                              `(org-level-6 ((t (,@headline ,@variable-tuple))))
                              `(org-level-5 ((t (,@headline ,@variable-tuple))))
                              `(org-level-4 ((t (,@headline ,@variable-tuple))))
                              `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.12))))
                              `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.35))))
                              `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
                              `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil)))))))

