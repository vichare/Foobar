(define (reverse l)
  (define (iter l r)
    (cond
      ((null? l) r)
      (else (iter (cdr l) (cons (car l) r)))
    )
  )
  (iter l ())
)
(reverse (list 1 2 3))
(reverse (list 1 4 9 16 25))
(reverse ())

