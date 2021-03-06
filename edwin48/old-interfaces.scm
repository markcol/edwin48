;;; -*- mode: scheme; scheme48-package: (config) -*-

(define-interface edwin:group-definition/interface
  (export make-group
          group?
          group-start-mark
          group-end-mark
          group-point
          group-buffer
          group-length
          group-start-index
          group-end-index
          group-start-index?
          group-end-index?
          group-display-start-index
          group-display-end-index
          group-display-start-index?
          group-display-end-index?
          set-group-writeable!
          set-group-read-only!
          group-region
          group-position->index
          group-index->position
          set-group-point!
          set-group-point-index!
          group-absolute-start
          group-absolute-end
          add-group-clip-daemon!
          remove-group-clip-daemon!
          set-group-undo-data!
          group-undo-data
          group-modified?
          group-text-properties
))

(define-interface edwin:group-operations/interface
  (export group-extract-string
          group-copy-substring!
          group-left-char
          group-right-char
          group-extract-and-delete-string!

          group-insert-char!
          group-insert-chars!
          group-insert-string!
          group-insert-substring!
          prepare-gap-for-insert!
          finish-group-insert!

          group-delete-left-char!
          group-delete-right-char!
          group-delete!

          group-replace-char!
          group-replace-string!
          group-replace-substring!
          prepare-gap-for-replace!
          finish-group-replace!

          grow-group!
          shrink-group!
          memoize-shrink-length!
          compute-shrink-length
          group-reallocation-factor
))

(define-interface edwin:group/interface
  (compound-interface edwin:group-definition/interface
                      edwin:group-operations/interface))


(define-interface edwin:mark/interface
  (export mark-group
          mark-index
          set-mark-index!
          mark?
          guarantee-mark
          make-temporary-mark
          make-mark
          move-mark-to!
          mark-temporary-copy
          mark-permanent-copy
          mark-right-inserting
          mark-right-inserting-copy
          mark-left-inserting
          mark-left-inserting-copy
          make-permanent-mark
))

(define-interface edwin:region-definition/interface
  (export make-region
          region-start
          region-end
          region-group
          region-start-index
          region-end-index
))

(define-interface edwin:region-operations/interface
  (export region-insert!
          region-insert-string!
          region-insert-substring!
          region-insert-newline!
          region-insert-char!
          region->string
          region-delete!
          mark-left-char
          mark-right-char
          mark-delete-left-char!
          mark-delete-right-char!
          region-transform!
          group-narrow!
          group-widen!
          region-clip!
          with-region-clipped!
          without-group-clipped!
          group-clipped?
          group-unclipped-region
))

(define-interface edwin:region/interface
  (compound-interface edwin:region-definition/interface
                      edwin:region-operations/interface))

(define-interface edwin:motion/interface
  (export limit-mark-motion
          mark1+
          mark-1+
          region-count-chars
          mark+
          mark-
          line-start-index
          line-end-index
          line-start-index?
          line-end-index?
          line-start
          line-end
          ))

(define-interface edwin:search/interface
  (export
   (define-next-char-search :syntax)
   (define-prev-char-search :syntax)
   make-find-next
   group-find-next-char
   group-find-next-char-ci
   group-find-next-char-in-set
   make-find-previous
   group-find-previous-char
   group-find-previous-char-ci
   group-find-previous-char-in-set
   group-match-substring-forward
   group-match-substring-backward
   group-match-substring-forward-ci
   group-match-substring-backward-ci
   char-search-forward
   char-search-backward
   char-match-forward
   char-match-backward
   default-start-mark
   default-end-mark
   default-case-fold-search
   skip-chars-forward
   skip-chars-backward
   match-forward
   match-backward))


(define-interface edwin:utilities/interface
  (export %substring-move!
          split-list
          list-of-type?
          list-of-strings?
          string-or-false?
          string-append-separated
          string-greatest-common-prefix-ci
          string-greatest-common-prefix
          write-strings-densely
          pad-on-left-to pad-on-right-to))

(define-interface edwin:ring/interface
  (export make-ring
          ring-list
          ring-size
          ring-clear!
          ring-empty?
          ring-push!
          ring-pop!
          ring-ref
          ring-set!))

(define-interface edwin:string-table/interface
  (export make-string-table
          alist->string-table
          string-table-ci?
          string-table-get
          string-table-put!
          string-table-remove!
          string-table-complete
          string-table-completions
          string-table-apropos))

(define-interface edwin:doc-string/interface
  (export *external-doc-strings?*
          *external-doc-strings-file*
          ->doc-string
          doc-string->posn
          description?
          description->string
          description-first-line
          description-append))

(define-interface edwin:paths/interface
  (export edwin-binary-directory
          edwin-info-directory
          edwin-etc-directory
          edwin-tutorial-pathname
          default-homedir-pathname))

(define-interface edwin:command/interface
  (export (define-command     :syntax)
          (ref-command-object :syntax)
          (ref-command        :syntax)
          command-name
          command-interactive-specification
          command-procedure
          command-description
          command-name-string
          editor-name/internal->external
          editor-name/external->internal
          make-command
          name->command
          ->command
          copy-command))

(define-interface edwin:variable/interface
  (export (define-variable            :syntax)
          (define-variable-per-buffer :syntax)
          (ref-variable-object        :syntax)
          (ref-variable               :syntax)
          (set-variable!              :syntax)
          (local-set-variable!        :syntax)
          variable-name
          variable-buffer-local?
          variable-description
          variable-value
          variable-default-value
          variable-name-string
          make-variable
          normalize-variable-value
          add-variable-assignment-daemon!
          invoke-variable-assignment-daemons!
          editor-variables
          name->variable
          ->variable
          variable-permanent-local?
          variable-permanent-local!))

(define-interface edwin:buffer/interface+edwin
  (edwin:export (variable buffer-creation-hook
                          tab-width)))

(define-interface edwin:buffer/interface+scheme
  (export make-buffer
          buffer-modeline-event!
          without-editor-interrupts
          buffer-reset!
          buffer-name set-buffer-name!
          buffer-default-directory
          set-buffer-default-directory!
          buffer-pathname set-buffer-pathname!
          buffer-truename set-buffer-truename!
          set-buffer-save-length!
          buffer-point
          minibuffer?
          buffer-group
          buffer-region
          buffer-string
          buffer-unclipped-region
          buffer-widen!
          buffer-length
          buffer-start buffer-absolute-start
          buffer-end   buffer-absolute-end
          add-buffer-window!
          remove-buffer-window!
          buffer-visible?
          buffer-x-size mark-x-size
          buffer-get
          buffer-put!
          buffer-remove!
          ->buffer
          buffer-modified?
          buffer-modified! buffer-not-modified!
          verify-visited-file-modification-time?
          clear-visited-file-modification-time!
          buffer-modification-time
          set-buffer-auto-saved!
          buffer-auto-save-modified?
          buffer-read-only? buffer-writeable?
          set-buffer-read-only! set-buffer-writeable!
          with-read-only-defeated

          define-variable-local-value!
          undefine-variable-local-value!
          variable-local-value
          variable-local-value?
          set-variable-local-value!
          set-variable-default-value!
          set-variable-value!
          with-variable-value!

          ;; modes
          buffer-major-mode
          set-buffer-major-mode!
          buffer-minor-modes
          buffer-minor-mode?
          enable-buffer-minor-mode!
          disable-buffer-minor-mode!))

(define-interface edwin:buffer/interface
  (compound-interface edwin:buffer/interface+edwin
                      edwin:buffer/interface+scheme))

(define-interface edwin:command-table/interface
  (export comtab-entry local-comtab-entry
          comtab-key?
          prefix-key-list?
          define-key
          define-prefix-key
          comtab->alist
          comtab-key-bindings))

(define-interface edwin:mode/interface
  (export (ref-mode-object   :syntax)
          (define-major-mode :syntax)
          (define-minor-mode :syntax)
          make-mode
          mode-name
          mode-major?
          mode-display-name
          mode-initialization
          mode-comtabs
          editor-modes
          name->mode
          ->mode
          major-mode?
          minor-mode?
          minor-mode-comtab
          mode-description))

(define-interface edwin:modeline/interface+edwin
  (edwin:export
   (variable mode-name
             minor-mode-alist
             mode-line-format
             mode-line-modified
             mode-line-procedure
             mode-line-process)))

(define-interface edwin:modeline/interface+scheme
  (export add-minor-mode-line-entry!
          remove-minor-mode-line-entry!))

(define-interface edwin:modeline/interface
  (compound-interface edwin:modeline/interface+edwin
                      edwin:modeline/interface+scheme))

(define-interface edwin:text-property/interface
  (export add-text-property
          remove-text-property
          get-text-properties get-text-property
          next-proper-change
          previous-property-change
          next-specific-property-change
          previous-specific-property-change
          region-writeable region-read-only
          text-not-insertable?
          text-not-deleteable?
          text-not-replaceable?
          highlight-subgroup
          highlight-region
          highlight-region-excluding-indentation
          local-comtabs
          set-subgroup-local-comtabs!
          set-region-local-comtabs!
          update-intervals-for-insertion!
          update-intervals-for-deletion!
          update-intervals-for-replacement!
          group-extract-properties
          group-reinsert-properties!
          reinsert-properties-size))

(define-interface edwin:simple-editing/interface
  (export delete-left-char  delete-right-char
          delete-string     extract-and-delete-string
          extract-left-char extract-right-char
          extract-string
          find-next-property-change
          find-next-specific-property-change
          find-previous-property-change
          find-previous-specific-property-change
          guarantee-newline         guarantee-newlines
          insert                    insert-char
          insert-chars              insert-newline
          insert-newlines           insert-region
          insert-string             insert-substring
          insert-string-pad-left    insert-string-pad-right
          insert-substring-pad-left insert-substring-pad-right
          mark-flash                narrow-to-region
          region-get                region-put!
          region-remove!            reposition-window-top
          sit-for                   sleep-for
          specific-property-region  widen))

(define-interface edwin:undo/interface
  (export enable-group-undo!          disable-group-undo!
          group-undo-boundary!
          record-first-change!        record-item!
          record-point!               record-properties!
          truncate-buffer-undo-lists! truncate-undo-data!
          undo-boundary!              undo-done!
          undo-enabled?               undo-item-size
          undo-leave-window!          undo-more
          undo-one-step               undo-record-deletion!
          undo-record-insertion!      undo-record-property-changes!
          undo-record-replacement!    undo-start
          with-group-undo-disabled))

(define-interface edwin:basic-command/interface+edwin
  (edwin:export (variable buffer-reallocation-factor)
                (commmand abort-recursive-edit
                          control-meta-prefix
                          control-prefix
                          define-command
                          execute-extended-command
                          exit-recursive-edit
                          indent-for-comment
                          indent-new-comment-line
                          keyboard-quit
                          kill-comment
                          meta-prefix
                          narrow-to-region
                          open-line
                          prefix-key
                          quoted-insert
                          save-buffers-kill-edwin
                          save-buffers-kill-scheme
                          self-insert-command
                          set-comment-column
                          set-key
                          suspend-edwin
                          suspend-scheme
                          undefined
                          widen)))

(define-interface edwin:basic-command/interface+scheme
  (export barf-if-read-only      check-first-group-modification
          editor-beep            editor-failure
          execute-extended-keys?
          extension-commands     indent-new-comment-line
          read-quoted-char
          save-buffers-and-exit  save-buffers-kill-edwin
          scheme-can-quit?       self-insert
          set-command-prompt-prefix!))

(define-interface edwin:basic-command/interface
  (compound-interface edwin:basic-command/interface+edwin
                      edwin:basic-command/interface+scheme))

(define-interface edwin:bufferset/interface
  (export bufferset-buffer-list
          bufferset-names
          make-bufferset
          set-bufferset-buffer-list!  bufferset-buffer-list
          bufferset-bury-buffer!      bufferset-create-buffer
          bufferset-find-buffer       bufferset-find-or-create-buffer
          bufferset-guarantee-buffer! bufferset-kill-buffer!
          bufferset-rename-buffer     bufferset-select-buffer!))

(define-interface edwin:current-state/interface+edwin
  (edwin:export (variable frame-creation-hook
                          select-buffer-hook)))

(define-interface edwin:current-state/interface+scheme
  (export add-kill-buffer-hook
          add-rename-buffer-hook
          add-select-buffer-hook
          buffer-alive?
          buffer-list
          buffer-mark
          buffer-names
          bury-buffer
          clear-current-message!
          create-buffer
          current-buffer
          current-buffer?
          current-column
          current-comtabs
          current-major-mode
          current-mark
          current-message
          current-minor-mode?
          current-point
          current-process
          current-region
          current-window
          current-window?
          delete-screen!
          disable-current-minor-mode!
          enable-current-minor-mode!
          find-buffer
          find-or-create-buffer
          global-window-modeline-event!
          kill-buffer
          make-buffer-invisible
          make-screen
          maybe-deselect-buffer-layout
          multiple-screens?
          next-visible-window
          other-buffer
          other-screen
          other-window
          pop-current-mark!
          previous-buffer
          push-buffer-mark!
          push-current-mark!
          remove-kill-buffer-hook
          remove-rename-buffer-hook
          remove-select-buffer-hook
          rename-buffer
          save-excursion
          screen-list
          select-buffer
          select-buffer-no-record
          select-cursor
          select-screen
          select-window
          selected-buffer
          selected-buffer?
          selected-screen
          selected-screen?
          selected-window
          selected-window?
          set-buffer-mark!
          set-buffer-point!
          set-current-major-mode!
          set-current-mark!
          set-current-message!
          set-current-point!
          set-current-region!
          set-current-region-reversed!
          typein-window
          typein-window?
          update-screens!
          update-selected-screen!
          window-list
          window-live?
          window-visible?
          window0
          with-current-point
          with-messages-suppressed
          with-selected-buffer))

(define-interface edwin:current-state/interface
  (compound-interface edwin:current-state/interface+edwin
                      edwin:current-state/interface+scheme))

(define-interface edwin:editor-definition/interface
  (export make-editor
          editor-screens         set-editor-screens!
          editor-selected-screen set-editor-selected-screen!
          editor-bufferset
          editor-halt-update?
          editor-peek-no-hang
          editor-peek
          editor-read))

(define-interface edwin:display-type/interface
  (export make-display-type
          display-type/name
          display-type/multiple-screens?
          display-type/available?
          display-type/make-screen
          display-type/get-input-operations
          display-type/with-display-grabbed
          display-type/with-interrupts-enabled
          display-type/with-interrupts-disabled
          editor-display-types
          name->display-type))

(define-interface edwin:screen/interface
  (export make-screen
          screen-state
          screen-x-size
          screen-y-size
          screen-root-window
          screen-visibility set-screen-visibility!
          screen-needs-update?
          guarantee-screen
          initialize-screen-root-window!

          screen-beep
          screen-enter!
          screen-exit!
          screen-discard!
          screen-modeline-event!
          screen-selected-window
          screen-select-window!
          screen-select-cursor!
          screen-window-list
          screen-window0
          screen-typein-window
          window-screen
          screen-visible?
          screen-deleted?
          update-screen!
          set-screen-size!
          screen-move-cursor
          screen-direct-output-move-cursor
          screen-output-char
          screen-direct-output-char
          screen-get-output-line
          screen-clear-rectangle
          screen-output-substring
          screen-direct-output-substring
          screen-force-update
          screen-scroll-lines-down
          screen-scroll-lines-up
          with-screen-in-update
          screen-line-draw-cost))

(define-interface edwin:terminal-screen/interface
  (export make-console-screen))

(define-interface edwin:kill-command/interface
  (edwin:export (command delete-region
                         delete-backward-char
                         delete-char
                         kill-line
                         backward-delete-char-untabify
                         kill-region
                         copy-region-as-kill
                         append-next-kill
                         yank
                         yank-pop
                         rotate-yank-pointer
                         set-mark-command
                         mark-beginning-of-buffer
                         mark-end-of-buffer
                         mark-whole-buffer
                         exchange-point-and-mark
                         transpose-chars)
                (variable kill-ring-max
                          kill-ring
                          kill-ring-yank-pointer
                          mark-ring-maximum)))

(define-interface edwin:display-imaging/interface
  (export default-char-image-strings
          group-column->index
          group-columns
          group-line-columns
          string-columns
          group-image!
          partial-image!
          substring-image!))

(define-interface edwin:window-system/interface
  (export vanilla-window))

(define-interface edwin:input-event/interface
  (export make-input-event
          input-event?
          input-event/type
          input-event/operator
          input-event/operands
          apply-input-event))

(define-interface edwin:editor/interface+scheme
  (export edwin-editor
          current-editor
          within-editor?
          editor-thread editor-thread-root-continuation
          edwin-initialization
          editor-initializations
          enter-recursive-edit exit-recursive-edit
          editor-error
          abort-current-command
          ^G-signal
          quit-editor-and-signal-error quit-editor
          quit-scheme
          ))

(define-interface edwin:editor/interface+edwin
  (edwin:export (variable inhibit-startup-message
                          error-display-mode
                          debug-on-editor-error)))

(define-interface edwin:editor/interface
  (compound-interface edwin:editor/interface+scheme
                      edwin:editor/interface+edwin))

(define-interface edwin:command-reader/interface
  (export top-level-command-reader
          command-reader
          return-to-command-loop
          override-next-command!
          current-command-key
          last-command-key
          set-command-argument!
          command-argument
          auto-argument-mode?
          set-command-message!
          command-message-receive
          command-history-list
          execute-key
          execute-command
          execute-button-command
          dispatch-on-key
          dispatch-on-command
          execute-command-history-entry))

(define-interface edwin:prompting/interface+scheme
  (export make-typein-buffer-name
          within-typein-edit?
          typein-edit-other-window
          prompt-for-typein
          prompt-for-string
          prompt-for-completed-string
          prompt-for-string/prompt
          prompt-for-number
          prompt-for-string-table-name
          prompt-for-alist-value
          prompt-for-command
          prompt-for-variable
          prompt-history-strings
          set-prompt-history-strings!
          prompt-options-default-string
          standard-completion
          pop-up-generated-completions
          prompt-for-char
          prompt-for-key
          prompt-for-confirmation?
          prompt-for-yes-or-no?
          call-with-pass-phrase
          call-with-confirmed-pass-phrase
          ))

(define-interface edwin:prompting/interface+edwin
  (edwin:export (command exit-minibuffer
                         minibuffer-yank-default
                         minibuffer-complete
                         minibuffer-complete-word
                         minibuffer-completion-help
                         minibuffer-complete-and-exit
                         exit-minibuffer-yes-or-no
                         next-prompt-history-item
                         previous-prompt-history-item
                         repeat-complex-command)
                (mode minibuffer-local
                      minibuffer-local-completion
                      minibuffer-local-must-match
                      minibuffer-local-yes-or-no)
                (variable completion-auto-help
                          enable-recursive-minibuffers)
                ))

(define-interface edwin:prompting/interface
  (compound-interface edwin:prompting/interface+scheme
                      edwin:prompting/interface+edwin))

(define-interface edwin:things/interface
  (export
   make-motion-pair
   move-thing
   move-thing-saving-point
   mark-thing
   kill-thing
   transpose-things
   horizontal-space-region
   horizontal-space-start
   horizontal-space-end
   compute-horizontal-space
   insert-horizontal-space
   delete-horizontal-space
   indent-to
   region-blank?
   line-blank?
   find-previous-blank-line
   find-next-blank-line
   find-previous-non-blank-line
   find-next-non-blank-line
   maybe-change-indentation
   change-indentation
   current-indentation
   mark-indentation
   indentation-end
   within-indentation?
   maybe-change-column
   change-column
   forward-line
   backward-line))

