#lang racket/base

(require fractalide/modules/rkt/rkt-fbp/agent)

(require (rename-in racket/gui [send class-send])
         racket/match)
; (require (rename-in racket/class [send class-send]))

(define-agent
  #:input '("in") ; in port
  #:output '("out" "halt" "fvm") ; out port
   (define acc (try-recv (input "acc")))
   (define msg (recv (input "in")))
   (define fr (if acc
                  acc
                  (let* ([new-es (make-eventspace)]
                         [fr
                          (parameterize ([current-eventspace new-es])
                            (new frame% [label "Example"]))])
                    (class-send fr show #t)
                    fr)))
   (match msg
     [(cons 'init curry) (curry fr)]
     [(cons 'dynamic-add _)
      (send (output "fvm") msg)]
     [(cons 'dynamic-remove graph)
      (send (output "fvm") msg)]
     [(cons 'set-clipboard-string msg)
      (class-send the-clipboard set-clipboard-string msg 0)]
     [(cons 'close #t) (send (output "halt") #t) (send (output "fvm") (cons 'stop #t))]
     [(or #t
          (cons (or 'motion 'leave 'enter 'left-down 'left-up 'subwindow-focus
                'move 'superwindow-show 'size 'focus 'radio-box 'key 'list-box
                'text-field 'text-field-enter 'check-box 'slider 'button 'superwindow-enable
                'display)
                _))
      (void)]
     [else (display "msg: ") (displayln msg)])
   (send (output "acc") fr))
