(define (lp) (load "E:/program/GitHub/Foobar/scheme/exercise-2-20.ss"))

(define (same-parity a . l)
  (define (same-parity-list a l)
    (cond 
      ((null? l) ())
      ((even? (+ a (car l))) (cons (car l) (same-parity-list a (cdr l))))
      (else (same-parity-list a (cdr l)))
    )
  )
  (same-parity-list a (cons a l))
)
(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

