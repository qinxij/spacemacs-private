;;---------------------------------
;;; Evil
;;---------------------------------
(defun qx/nmap (key def)
  (define-key evil-normal-state-map key def))
(defun qx/vmap (key def)
  (define-key evil-visual-state-map key def))
(defun qx/mmap (key def)
  (define-key evil-motion-state-map key def))
(defun qx/imap (key def)
  (define-key evil-insert-state-map key def))
(defun qx/rmap (key def)
  (define-key evil-read-key-map key def))

;; Map them to [0, $]
(qx/mmap "H" 'evil-beginning-of-line) ; H goes to beginning of the line
(qx/mmap "L" 'evil-end-of-line) ; L goes to end of the line

;; Map them to [H, L, M]
(qx/mmap "gt" 'evil-window-top)
(qx/mmap "gb" 'evil-window-bottom)
(qx/mmap "gm" 'evil-window-middle)

;; Swamp [`] and [']
(qx/mmap "'" 'evil-goto-mark)
(qx/mmap "`" 'evil-goto-mark-line)

;; <C-j> <C-h> to <C-d> <C-u>
; <C-j> original map to electric-newline-and-maybe-indent
(qx/mmap (kbd "C-j") 'evil-scroll-down)
; `D' has the same functionality of C-k
(qx/mmap (kbd "C-k") 'evil-scroll-up)


;;---------------------------------
;;; Eshell
;;---------------------------------
(qx/mmap (kbd "C-:") 'eshell-here)
(qx/imap (kbd "C-h") 'backward-delete-char-untabify)
(defun eshell--kill-backward-till-begging ()
  (interactive)
  (eshell-bol)
  (kill-line))
(qx/imap (kbd "C-u") 'eshell--kill-backward-till-begging)

(qx/imap (kbd "C-p") 'eshell-previous-matching-input-from-input)
(qx/imap (kbd "C-n") 'eshell-next-matching-input-from-input)


;;---------------------------------
;;; Chinese-font-setup
;;---------------------------------
(qx/mmap (kbd "C--") 'cfs-decrease-fontsize)
(qx/imap (kbd "C--") 'cfs-decrease-fontsize)
(qx/mmap (kbd "C-=") 'cfs-increase-fontsize)
(qx/imap (kbd "C-=") 'cfs-increase-fontsize)
;; vim in/decrease number
(qx/mmap (kbd "C-_") 'spacemacs/evil-numbers-decrease)
(qx/imap (kbd "C-_") 'spacemacs/evil-numbers-decrease)
(qx/mmap (kbd "C-+") 'spacemacs/evil-numbers-increase)
(qx/imap (kbd "C-+") 'spacemacs/evil-numbers-increase)




