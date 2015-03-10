(import (rnrs))

(define (factorization n)
  (define (helper n a)
    (cond ((> (* a a) n) (display n))
          ((= n a) (display n))
          ((integer? (/ n a)) (begin (display a) (display "*") (helper (/ n a) a)))
          (else (helper n (+ a 1)))
    )
  )
  (begin (helper n 2) (newline))
)

(define (test-fact a b)
  (if (< a b) (begin (factorization a) (test-fact (+ a 1) b)) (factorization a))
)


