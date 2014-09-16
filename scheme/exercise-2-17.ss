(include "assert.ss")
(define (last-pair l)
  (cond ((null? l) ())
        ((null? (cdr l)) (car l))
        (else (last-pair (cdr l)))
  )
)
(last-pair (list 1 2 3 4 5))
(last-pair (list 23 72 149 34))
(last-pair (list 23))
(last-pair ())


