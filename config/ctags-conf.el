(live-add-pack-lib "ctags")
(live-add-pack-lib "etags-select")

(require 'ctags)
(require 'etags-select)

;; Permit the override of the ctags binary
;; (setq *CTAGS-BINARY* "ctags-exuberant")

;; Permit the override of the prefix log message to explicit who triggers the TAGS
;; (setq *CTAGS-LOG-PREFIX* "ctags-pack - ")

;; When a new file is found in a git repo, set the project tags filename.
(add-hook 'find-file-hook 'set-project-tags-file-name)

;; When a new file is found in a git repo, generate the project tags file if it
;; doesn't exist.
;;(add-hook 'find-file-hook 'generate-project-tags-if-missing)

;; When a file is saved, (potentially) regenerate the tags file.
(add-hook 'after-save-hook 'regenerate-project-tags)

;; If the tags file is rewritten, pick up the changes without prompting.
(setq tags-revert-without-query t)

;; Always add tables to tags-table-list
(setq tags-add-tables t)

;; Use etags-select-find-tag-at-point on M-.
(global-set-key "\M-." 'etags-select-find-tag-at-point)
