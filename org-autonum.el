;;; org-autonum.el --- Tiny function to autonumber org-mode outlines

;; Copyright (C) 2015  Narendra Acharya

;; Author: Narendra Acharya (narendra_m_a at yahoo dot com)

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Automatic heading numbering in org-mode files.
;;
;; org-autonum inserts section numbers of the form <<x.y.z>> at the
;; beginning of each heading in the current org-file.
;; By inserting in such format, the section numbers become dedicated targets.
;; (see http://orgmode.org/manual/Internal-links.html)
;; Hence they would be visible for reference in the buffer but not
;; part of any exported output.

;;; Installation:
;;
;; Install org-autonum.el in the load-path
;; Add function to org-mode hook
;; (add-hook 'org-insert-heading-hook 'nma/org-autonum)
;;

(defun nma/org-autonum ()
  (let ((sec-num '(0)))
    (org-map-entries
     (lambda ()
       "Insert a section number of form <<x.y.z>> before the headling"
       ;; Move to start of heading
       (re-search-forward "\\* " (line-end-position) t)
       (setq level (1- (current-column)))
       (if (< (length sec-num) level)
           ;; Expand to next level
           (setq sec-num (append sec-num '(0)))
         ;; Prune to level
         (unless (= (length sec-num) level)
           (setq sec-num (butlast sec-num (- (length sec-num) level)))))
       ;; Increment
       (setq sec-num (append (butlast sec-num 1)
                                   (list (1+ (car (last sec-num 1))))))
       (setq sec-str (concat "<<" (mapconcat 'number-to-string sec-num ".")
                             ">>"))
       (if (re-search-forward "<<.*>>" (line-end-position) t)
           ;; Replace existing marker
           (replace-match sec-str nil nil)
         ;; Insert new marker
         (insert sec-str))))))

