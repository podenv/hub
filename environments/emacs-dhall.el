(add-to-list 'load-path "/usr/local/share/emacs/dhall-mode")
(add-to-list 'load-path "/usr/local/share/emacs/reformatter")
(require 'dhall-mode)
(setq
    dhall-format-arguments (\` ("--ascii"))
    dhall-use-header-line nil
    compilation-read-command nil
    compile-command "dhall --explain --file ./config.dhall")

(global-set-key (kbd "<f5>") 'compile)
