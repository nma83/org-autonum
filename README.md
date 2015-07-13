# org-autonum
## Automatic heading numbering in org-mode files.

org-autonum inserts section numbers of the form 
&lt;&lt;x.y.z&gt;&gt;at the
beginning of each heading in the current org-file.
By inserting in such format, the section numbers become [dedicated targets]
(http://orgmode.org/manual/Internal-links.html).
Hence they would be visible for reference in the buffer but not
part of any exported output.

## Installation

Install org-autonum.el in the load-path.

    (require 'org-autonum)

Enable the feature in the file header.

    # -*- org-autonum-enable: t; -*-

Add function to org-mode hook.

    (add-hook 'org-insert-heading-hook 'nma/org-autonum)

org-insert-heading-hook is used only when M-Enter is used.
org-autonum can be added to other hooks such as org-cycle-hook
to refresh section numbers when viewing contents for example.

    (add-hook 'org-cycle-hook
      (lambda (state) (if (eq state 'contents) (nma/org-autonum))))
