(defun zjs-count-word ()
  (interactive)
  (let ((beg (point-min)) (end (point-max))
        (eng 0) (non-eng 0))
    (if mark-active
        (setq beg (region-beginning)
              end (region-end)))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond ((not (equal (car (syntax-after (point))) 2))
               (forward-char))
              ((< (char-after) 128)     
               (progn
                 (setq eng (1+ eng))
                 (forward-word)))
              (t
               (setq non-eng (1+ non-eng))
               (forward-char)))))
    (message "English words: %d\nNon-English characters: %d"
             eng non-eng)))
