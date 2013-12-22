(require 'magit)

(defvar *CTAGS-BINARY* "ctags-exuberant" "CTAGS binary to use for TAGS generation.")

(defun set-project-tags-file-name ()
  (interactive)
  "If the current directory is a git project (but not the user's home directory),
   make .tags the default tag file location. You probably want to add .tags to a
   global gitignore file."
  (let* ((top-dir (magit-get-top-dir))
         (home-dir (expand-file-name "~/"))
         (tags-file (format "%sTAGS" top-dir)))
    (when (and top-dir
               (not (string-equal top-dir home-dir)))
      (setq-local tags-table-list (list tags-file))
      (message "Project tags file set to: %s" tags-file)
      (generate-project-tags-if-missing))))

(defun generate-project-tags (tags-file)
  "Generate tags for current project in `tags-file`"
  (interactive)
  (call-process *CTAGS-BINARY* nil nil nil
                  "-Re"
                  "--exclude=.git"
                  "--exclude='.#*'"
                  "--langmap=Lisp:+.clj.cljs"
                  (format "-f %s" tags-file)
                  (magit-get-top-dir)))

(defun get-project-tags-file-name ()
  "Get file name to put project tags in."
  (interactive)
  (car tags-table-list))

(defun generate-project-tags-if-missing ()
  "If `tags-table-list` is set and no project tags file exists, generate it."
  (interactive)
  (when tags-table-list
    (let* ((tags-file (get-project-tags-file-name)))
      (when (and tags-file (not (file-exists-p tags-file)))
        (generate-project-tags tags-file)
        (message "Generated new project tags in %s" tags-file)))))

(defun regenerate-project-tags ()
  "If `tags-file-name` is set, regenerate the tags file."
  (interactive)
  (let* ((tags-file-name (get-project-tags-file-name)))
    (when tags-file-name
      (generate-project-tags tags-file-name)
      (message "ctags-pack - Regenerated project tags in %s" tags-file-name))))

(provide 'ctags)
