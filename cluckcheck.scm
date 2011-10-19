(require-extension srfi-1) ; lists

(define (gen-int)
	(random 256))

(define (gen-bool)
	(= (random 2) 0))

(define (gen-char)
	(integer->char (random 128)))

(define (gen-list gen)
	(map (lambda (x) (gen)) (iota (random 100))))

(define (gen-string)
	(list->string (gen-list gen-char)))

(define (for-all property . generators)
	(let ((values (map (lambda (x) (map (lambda (f) (f)) generators)) (iota 100))))
		(let ((failure (find (lambda (vs) (not (apply property vs))) values)))
			(if (list? failure)
				(display (format "*** Failed!\n~a\n" failure))
				(display (format "+++ OK, passed 100 tests\n"))))))