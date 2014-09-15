(define (unittest statement value casenum)
  (if (= statement value)
    (display (format "Unittest #~d passed.\n" casenum))
    (display (format "Unittest #~d failed!!!\n" casenum))
  )
)

(define (assert statement casenum)
  (cond 
    ( (not statement)
      (display (format "Assertion #~d failed!!!\n" casenum)) 
    )
  )
)

(define (asserteq statement value casenum)
  (cond 
    ( (> (abs (- statement value)) 0.0001)
      (display (format "Assertion #~d failed!!!\n" casenum))
    )
  )
)

