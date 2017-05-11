;; ============================================================
;; Utilitys
;; ============================================================
(defun qx/define-key (keymap &rest bindings)
  (declare (indent 1))
  (while bindings
    (define-key keymap (pop bindings) (pop bindings))))

;; ============================================================
;; Eshell
;; http://www.howardism.org/Technical/Emacs/eshell-fun.html
;; ============================================================
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "ESHELL: " name))

    (insert (concat "ls"))
    (eshell-send-input)))


(defun eshell/x ()
  "Closes the EShell session and gets rid of the EShell window."
  (insert "exit")
  (eshell-send-input)
  (delete-window))

(defun eshell/pe ()
  (eshell/printnl (eshell-environment-variables)))

(defun eshell/print-ev (reg-key)
  (eshell/printnl (replace-regexp-in-string
                   ":" "\n"
                   (substring (car (remove-if-not
                                    (lambda (str)
                                      (string-match-p reg-key str))
                                    (eshell-environment-variables)))
                              (- (length reg-key) 1)))))
(defun eshell/pp () (eshell/print-ev "^PATH="))
(defun eshell/pmp () (eshell/print-ev "^MANPATH="))


;; ============================================================
;; Org
;; ============================================================
;; Remove empty LOGBOOK drawers on clock out
(defun qx/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'qx/remove-empty-drawer-on-clock-out 'append)
