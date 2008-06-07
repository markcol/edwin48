(define (terminal-raw-input port)
  (let* ((info               (tty-info port))
         (local-flags        (lambda ()  (tty-info:local-flags       info)))
         (input-flags        (lambda ()  (tty-info:input-flags       info)))
         (control-flags      (lambda ()  (tty-info:control-flags     info)))
         (control-chars      (lambda ()  (tty-info:control-chars     info)))
         (set-local-flags!   (lambda (f) (set-tty-info:local-flags   info f)))
         (set-input-flags!   (lambda (f) (set-tty-info:input-flags   info f)))
         (set-control-flags! (lambda (f) (set-tty-info:control-flags info f)))
         (set-control-chars! (lambda (idx char)
                               (let ((cc (tty-info:control-chars info)))
                                 (string-set! cc idx char)
                                 (set-tty-info:control-chars info cc)))))

    ;; echo off, canonical off, extended input processing off
    ;; lflags &= ~(ICANON | ECHO | IEXTEN)
    (set-local-flags!
     (bitwise-and (local-flags)
                  (bitwise-not (bitwise-ior ttyl/canonical
                                            ttyl/echo
                                            ttyl/enable-signals
                                            ttyl/extended))))

    ;; ignore breaks
    ;; iflags |= IGNBRK
    (set-input-flags! (bitwise-ior (input-flags) ttyin/ignore-break))

    ;; Disable CR->NL conversion, Output flow control, strip chars to
    ;; 7-bits
    ;; iflags &= ~(ICRNL | IXON | ISTRIP)
    (set-input-flags!
     (bitwise-and (input-flags)
                  (bitwise-not (bitwise-ior ttyin/cr->nl
                                            ttyin/output-flow-ctl
                                            ttyin/7bits))))

    ;; Enable char-size 8
    ;; cflags |= CS8
    (set-control-flags! (bitwise-ior (control-flags) ttyc/char-size8))

    ;; Disable parity detection
    ;; cflags &= ~PARENB
    (set-control-flags!
     (bitwise-and (control-flags) (bitwise-not ttyc/enable-parity)))

    ;; cc [VMIN]  = 0
    ;; cc [VTIME] = 0
    (set-tty-info:min  info 0)
    (set-tty-info:time info 0)

    ;; cc [VSTART] = disable
    ;; cc [VSTOP]  = disable
    (set-control-chars! ttychar/start disable-tty-char)
    (set-control-chars! ttychar/stop  disable-tty-char)

    ;; tcsetattr (fd, TCSANOW, &info);
    (set-tty-info/now port info)))