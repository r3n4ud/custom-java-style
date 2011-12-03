;;; custom-java-style.el --- Java style

;; Keywords: java, tools

;; custom-java-style is distributed under the terms of the GNU General Public License version 3.
;;
;; This work is partly derived from google-c-style.el.

;;; Commentary:

;; Provides a custom java coding style. You may wish to add `custom-set-java-style' to your
;; `java-mode-hook' after requiring this file. For example:
;;
;;    (add-hook 'java-mode-hook 'custom-set-java-style)
;;
;; If you want the RETURN key to go to the next line and space over to the right place, add this to
;; your .emacs right after the load-file:
;;
;;    (add-hook 'java-mode-hook 'custom-make-newline-indent)

;;; Code:

;; Start with the original java style bare definition + arglist-cont-nonempty
(defconst custom-java-style
  ;; `((c-basic-offset . 4)
  ;;   (indent-tabs-mode . nil)
  ;;   (c-comment-only-line-offset . (0 . 0))
  ;;   ;; the following preserves Javadoc starter lines
  ;;   (c-offsets-alist . ((inline-open . 0)
  ;;                       (topmost-intro         . 0)
  ;;                       (topmost-intro-cont    . 0)
  ;;                       (statement-block-intro . +)
  ;;                       (knr-argdecl-intro     . 5)
  ;;                       (substatement-open     . +)
  ;;                       (substatement-label    . +)
  ;;                       (label                 . +)
  ;;                       (statement-case-open   . +)
  ;;                       ;; (statement-cont        . +)
  ;;                       (statement-cont
  ;;                        .
  ;;                        (,(when (fboundp 'c-no-indent-after-java-annotations)
  ;;                            'c-no-indent-after-java-annotations)
  ;;                         ,(when (fboundp 'c-lineup-assignments)
  ;;                            'c-lineup-assignments)
  ;;                         ++))
  ;;                       (arglist-intro  . c-lineup-arglist-intro-after-paren)
  ;;                       (arglist-close  . c-lineup-arglist)
  ;;                       (access-label   . 0)
  ;;                       (inher-cont     . c-lineup-java-inher)
  ;;                       (func-decl-cont . c-lineup-java-throws)
  ;;                       (arglist-cont-nonempty . ++))))
  ;; "Custom Java Programming Style")

  `((c-recognize-knr-p . nil) ; K&R style argument declarations are not valid
    (c-enable-xemacs-performance-kludge-p . t) ; speed up indentation in XEmacs
    (c-basic-offset . 4)
    (indent-tabs-mode . nil) ; tabs are evil!
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((defun-open after)
                               (defun-close before after)
                               (class-open after)
                               (class-close before after)
                               (namespace-open after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open after)
                               (block-close . c-snug-do-while)
                               (extern-lang-open after)
                               (extern-lang-close after)
                               (statement-case-open after)
                               (substatement-open after)))
    (c-hanging-colons-alist . ((case-label)
                               (label after)
                               (access-label after)
                               (member-init-intro before)
                               (inher-intro)))
    (c-hanging-semi&comma-criteria
     . (c-semi&comma-no-newlines-for-oneline-inliners
        c-semi&comma-inside-parenlist
        c-semi&comma-no-newlines-before-nonblanks))
    (c-indent-comments-syntactically-p . nil)
    (comment-column . 40)
    (c-cleanup-list . (brace-else-brace
                       brace-elseif-brace
                       brace-catch-brace
                       empty-defun-braces
                       defun-close-semi
                       list-close-comma
                       scope-operator))
    (c-offsets-alist . (;;(arglist-intro custom-java-lineup-expression-plus-4)
                        (func-decl-cont . ++)
                        (member-init-intro . ++)
                        (inher-intro . ++)
                        (comment-intro . 0)
                        (arglist-close . c-lineup-arglist)
                        (topmost-intro . 0)
                        (block-open . 0)
                        (inline-open . 0)
                        (substatement-open . 0)
                        (statement-cont
                         .
                         (,(when (fboundp 'c-no-indent-after-java-annotations)
                             'c-no-indent-after-java-annotations)
                          ,(when (fboundp 'c-lineup-assignments)
                             'c-lineup-assignments)
                          ++))
                        (label . /)
                        (case-label . +)
                        (statement-case-open . +)
                        (statement-case-intro . +) ; case w/o {
                        (access-label . /)
                        (innamespace . 0)
                        (arglist-cont-nonempty . ++)))
    (c-block-comment-prefix . "*"))
  "Custom Java Programming Style")

(defun custom-set-java-style ()
  "Set the current buffer's java-style to my Custom Programming Style. Meant to be added to `java-mode-hook'."
  (interactive)
  (make-local-variable 'c-tab-always-indent)
  (setq c-tab-always-indent t)
  (c-toggle-auto-newline 1)
  (c-add-style "custom-java-style" custom-java-style t))

(defun custom-make-newline-indent ()
  "Sets up preferred newline behavior. Not set by default. Meant to be added to `java-mode-hook'."
  (interactive)
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map [ret] 'newline-and-indent))

(provide 'custom-java-style)
;;; custom-java-style.el ends here
