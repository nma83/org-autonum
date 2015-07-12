# org-autonum
## Automatic heading numbering in org-mode files.

org-autonum inserts section numbers of the form 
&lt;&lt;x.y.z&gt;&gt;at the
beginning of each heading in the current org-file.
By inserting in such format, the section numbers become dedicated targets.
(see http://orgmode.org/manual/Internal-links.html)
Hence they would be visible for reference in the buffer but not
part of any exported output.

## Installation

Install org-autonum.el in the load-path.
Add function to org-mode hook.

    (add-hook 'org-insert-heading-hook 'nma/org-autonum)

