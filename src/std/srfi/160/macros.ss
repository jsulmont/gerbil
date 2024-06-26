;;; -*- Gerbil -*-
;;; © vyzo
;;; SRFI-160: Homogeneous Numeric Vector Libraries

(import (for-syntax :std/stxutil)
        :gerbil/gambit
        (only-in :std/srfi/128 make-comparator)
        ./base)
(export #t)

(defsyntax (deflib stx)
  (syntax-case stx ()
    ((_ t)
     (with-syntax ((make-@vector              (format-id #'t "make-~avector" #'t))
                   (@vector                   (format-id #'t "~avector" #'t))
                   (@vector-unfold            (format-id #'t "~avector-unfold" #'t))
                   (@vector-unfold-right      (format-id #'t "~avector-unfold-right" #'t))
                   (@vector-copy              (format-id #'t "~avector-copy" #'t))
                   (@vector-reverse-copy      (format-id #'t "~avector-reverse-copy" #'t))
                   (@vector-append            (format-id #'t "~avector-append" #'t))
                   (@vector-concatenate       (format-id #'t "~avector-concatenate" #'t))
                   (@vector-append-subvectors (format-id #'t "~avector-append-subvectors" #'t))
                   (@?                        (format-id #'t "~a?" #'t))
                   (@vector?                  (format-id #'t "~avector?" #'t))
                   (@vector-empty?            (format-id #'t "~avector-empty?" #'t))
                   (@vector=                  (format-id #'t "~avector=" #'t))
                   (@vector-ref               (format-id #'t "~avector-ref" #'t))
                   (@vector-length            (format-id #'t "~avector-length" #'t))
                   (@vector-take              (format-id #'t "~avector-take" #'t))
                   (@vector-take-right        (format-id #'t "~avector-take-right" #'t))
                   (@vector-drop              (format-id #'t "~avector-drop" #'t))
                   (@vector-drop-right        (format-id #'t "~avector-drop-right" #'t))
                   (@vector-segment           (format-id #'t "~avector-segment" #'t))
                   (@vector-fold              (format-id #'t "~avector-fold" #'t))
                   (@vector-fold-right        (format-id #'t "~avector-fold-right" #'t))
                   (@vector-map               (format-id #'t "~avector-map" #'t))
                   (@vector-map!              (format-id #'t "~avector-map!" #'t))
                   (@vector-for-each          (format-id #'t "~avector-for-each" #'t))
                   (@vector-count             (format-id #'t "~avector-count" #'t))
                   (@vector-cumulate          (format-id #'t "~avector-cumulate" #'t))
                   (@vector-take-while        (format-id #'t "~avector-take-while" #'t))
                   (@vector-take-while-right  (format-id #'t "~avector-take-while-right" #'t))
                   (@vector-drop-while        (format-id #'t "~avector-drop-while" #'t))
                   (@vector-drop-while-right  (format-id #'t "~avector-drop-while-right" #'t))
                   (@vector-index             (format-id #'t "~avector-index" #'t))
                   (@vector-index-right       (format-id #'t "~avector-index-right" #'t))
                   (@vector-skip              (format-id #'t "~avector-skip" #'t))
                   (@vector-skip-right        (format-id #'t "~avector-skip-right" #'t))
                   (@vector-any               (format-id #'t "~avector-any" #'t))
                   (@vector-every             (format-id #'t "~avector-every" #'t))
                   (@vector-partition         (format-id #'t "~avector-partition" #'t))
                   (@vector-filter            (format-id #'t "~avector-filter" #'t))
                   (@vector-remove            (format-id #'t "~avector-remove" #'t))
                   (@vector-set!              (format-id #'t "~avector-set!" #'t))
                   (@vector-swap!             (format-id #'t "~avector-swap" #'t))
                   (@vector-fill!             (format-id #'t "~avector-fill!" #'t))
                   (@vector-reverse!          (format-id #'t "~avector-reverse!" #'t))
                   (@vector-copy!             (format-id #'t "~avector-copy!" #'t))
                   (@vector-reverse-copy!     (format-id #'t "~avector-reverse-copy!" #'t))
                   (@vector-unfold!           (format-id #'t "~avector-unfold!" #'t))
                   (@vector-unfold-right!     (format-id #'t "~avector-unfold-right!" #'t))
                   (@vector->list             (format-id #'t "~avector->list" #'t))
                   (reverse-@vector->list     (format-id #'t "reverse-~avector->list" #'t))
                   (list->@vector             (format-id #'t "list->~avector" #'t))
                   (reverse-list->@vector     (format-id #'t "reverse-list->~avector" #'t))
                   (@vector->vector           (format-id #'t "~avector->vector" #'t))
                   (vector->@vector           (format-id #'t "vector->~avector" #'t))
                   (make-@vector-generator    (format-id #'t "make-~avector-generator" #'t))
                   (@vector-comparator        (format-id #'t "~avector-comparator" #'t))
                   (write-@vector             (format-id #'t "write-~avector" #'t)))
       #'(begin
           (import :std/error)
           (export make-@vector @vector
                   @vector-unfold @vector-unfold-right
                   @vector-copy @vector-reverse-copy
                   @vector-append @vector-concatenate
                   @vector-append-subvectors
                   @? @vector? @vector-empty? @vector=
                   @vector-ref @vector-length
                   @vector-take @vector-take-right
                   @vector-drop @vector-drop-right
                   @vector-segment
                   @vector-fold @vector-fold-right
                   @vector-map @vector-map! @vector-for-each
                   @vector-count @vector-cumulate
                   @vector-take-while @vector-take-while-right
                   @vector-drop-while @vector-drop-while-right
                   @vector-index @vector-index-right @vector-skip @vector-skip-right
                   @vector-any @vector-every @vector-partition
                   @vector-filter @vector-remove
                   @vector-set! @vector-swap! @vector-fill! @vector-reverse!
                   @vector-copy! @vector-reverse-copy!
                   @vector-unfold! @vector-unfold-right!
                   @vector->list reverse-@vector->list list->@vector reverse-list->@vector
                   @vector->vector vector->@vector
                   make-@vector-generator @vector-comparator write-@vector)
           (defvector-unfold @vector-unfold make-@vector @? @vector-set!)
           (defvector-unfold-right @vector-unfold-right make-@vector @? @vector-set!)
           (defvector-copy @vector-copy make-@vector @vector-length @vector-copy!)
           (defvector-copy! @vector-copy! @vector? @vector-length @vector-ref @vector-set!)
           (defvector-reverse-copy @vector-reverse-copy make-@vector @vector-length @vector-reverse-copy!)
           (defvector-reverse-copy! @vector-reverse-copy! @vector? @vector-length @vector-ref @vector-set!)
           (defvector-append @vector-append @vector-concatenate)
           (defvector-concatenate @vector-concatenate make-@vector @vector-length @vector-copy!)
           (defvector-append-subvectors @vector-append-subvectors make-@vector @vector-copy!)
           (defvector-empty? @vector-empty? @vector-length)
           (defvector= @vector= @vector? @vector-length @vector-ref)
           (defvector-take @vector-take make-@vector @vector-copy!)
           (defvector-take-right @vector-take-right make-@vector @vector-length @vector-copy!)
           (defvector-drop @vector-drop make-@vector @vector-length @vector-copy!)
           (defvector-drop-right @vector-drop-right make-@vector @vector-length @vector-copy!)
           (defvector-segment @vector-segment @vector-length @vector-copy)
           (defvector-fold @vector-fold @vector-length @vector-ref)
           (defvector-fold-right @vector-fold-right @vector-length @vector-ref)
           (defvector-map @vector-map make-@vector @vector-length @vector-ref @vector-set!)
           (defvector-map! @vector-map! @vector-length @vector-ref @vector-set!)
           (defvector-for-each @vector-for-each @vector-length @vector-ref)
           (defvector-count @vector-count @vector-length @vector-ref)
           (defvector-cumulate @vector-cumulate make-@vector @vector-length @vector-ref @vector-set!)
           (defvector-take-while @vector-take-while @vector-length @vector-skip @vector-copy)
           (defvector-take-while-right @vector-take-while-right @vector-length @vector-skip-right @vector-copy)
           (defector-drop-while @vector-drop-while @vector-length @vector-skip @vector-copy)
           (defvector-drop-while-right @vector-drop-while-right @vector-length @vector-skip-right @vector-copy)
           (defvector-index @vector-index @vector-length @vector-ref)
           (defvector-index-right @vector-index-right @vector-length @vector-ref)
           (defvector-skip @vector-skip @vector-index)
           (defvector-skip-right @vector-skip-right @vector-index-right)
           (defvector-any @vector-any @vector-length @vector-ref)
           (defvector-every @vector-every @vector-length @vector-ref)
           (defvector-partition @vector-partition make-@vector @vector-length @vector-ref @vector-set! @vector-count)
           (defvector-filter @vector-filter make-@vector @vector-length @vector-ref @vector-set! @vector-count)
           (defvector-remove @vector-remove @vector-filter)
           (defvector-swap! @vector-swap! @vector-ref @vector-set!)
           (defvector-fill! @vector-fill! @vector-length @vector-set! @? @vector?)
           (defvector-reverse! @vector-reverse! @vector-length @vector-ref @vector-set! @vector?)
           (defvector-unfold! @vector-unfold! @vector-length @vector-set! @vector?)
           (defvector-unfold-right! @vector-unfold-right! @vector-length @vector-set! @vector?)
           (defvector-reverse-vector->list reverse-@vector->list @vector-length @vector-ref @vector?)
           (defvector-reverse-list->vector reverse-list->@vector make-@vector @vector-set! @?)
           (defvector->vector @vector->vector @vector-length @vector-ref @vector?)
           (defvector<-vector vector->@vector make-@vector @vector-set! @?)
           (defvector-generator make-@vector-generator @vector-length @vector-ref @vector?)
           (defvector-comparator @vector-comparator @vector? @vector= @vector-length @vector-ref)
           (defvector-write write-@vector))))))

(defrules defvector-unfold ()
  ((_ @vector-unfold make-@vector @? @vector-set!)
   (def (@vector-unfold f len seed)
     (declare (not safe))
     (unless (procedure? f)
       (error "Bad argument; expected procedure" f))
     (let (v (make-@vector len))
       (let lp ((i 0) (state seed))
         (if (fx< i len)
           (let ((values x state) (f i state))
             (unless (@? x)
               (error "Bad generated value" x))
             (@vector-set! v i x)
             (lp (fx1+ i) state))
           v))))))

(defrules defvector-unfold-right ()
  ((_ @vector-unfold-right make-@vector @? @vector-set!)
   (def (@vector-unfold-right f len seed)
     (declare (not safe))
     (unless (procedure? f)
       (error "Bad argument; expected procedure" f))
     (let (v (make-@vector len))
       (let lp ((i (fx1- len)) (state seed))
         (if (fx>= i 0)
           (let ((values x state) (f i state))
             (unless (@? x)
               (error "Bad generated value" x))
             (@vector-set! v i x)
             (lp (fx1- i) state))
           v))))))

(defrules defvector-copy ()
  ((_ @vector-copy make-@vector @vector-length @vector-copy!)
   (def (@vector-copy vec (start 0) (end (@vector-length vec)))
     (let (v (make-@vector (fx- end start)))
       (@vector-copy! v 0 vec start end)
       v))))

(defrules defvector-copy! ()
  ((_ @vector-copy! @vector? @vector-length @vector-ref @vector-set!)
   (def (@vector-copy! to at from start end)
     (declare (not safe))
     (unless (@vector? to)
       (error "Bad argument" to))
     (unless (@vector? from)
       (error "Bad argument" from))
     (unless (and (fixnum? at) (fx<= 0 at (fx1- (@vector-length from))))
       (error "Index out of range" to at))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length from))))
       (error "Index out of range" from start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length from)))
       (error "Index out of range" from end))
     (unless (fx<= (fx- end start) (fx- (@vector-length to) at))
       (error "Destination area too small" to at from start end))
     (let lp ((i start) (j at))
       (when (fx< i end)
         (@vector-set! to j (@vector-ref from i))
         (lp (fx1+ i) (fx1+ j)))))))

(defrules defvector-reverse-copy ()
  ((_ @vector-reverse-copy make-@vector @vector-length @vector-reverse-copy!)
   (def (@vector-reverse-copy vec (start 0) (end (@vector-length vec)))
     (let (v (make-@vector (fx- end start)))
       (@vector-reverse-copy! v 0 vec start end)
       v))))

(defrules defvector-reverse-copy! ()
  ((_ @vector-reverse-copy! @vector? @vector-length @vector-ref @vector-set!)
   (def (@vector-reverse-copy! to at from start end)
     (declare (not safe))
     (unless (@vector? to)
       (error "Bad argument" to))
     (unless (@vector? from)
       (error "Bad argument" from))
     (unless (and (fixnum? at) (fx<= 0 at (fx1- (@vector-length to))))
       (error "Index out of range" to at))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length from))))
       (error "Index out of range" from start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length from)))
       (error "Index out of range" from end))
     (unless (fx<= (fx- end start) (fx- (@vector-length to) at))
       (error "Destination area too small" to at from start end))
     (let lp ((i (fx1- end)) (j at))
       (when (fx>= i start)
         (@vector-set! to j (@vector-ref from i))
         (lp (fx1- i) (fx1+ j)))))))

(defrules defvector-append ()
  ((_ @vector-append @vector-concatenate)
   (def (@vector-append . args)
     (@vector-concatenate args))))

(defrules defvector-concatenate ()
  ((_ @vector-concatenate make-@vector @vector-length @vector-copy!)
   (def (@vector-concatenate lst)
     (let* ((len (foldl (lambda (v r) (fx+ (@vector-length v) r)) 0 lst))
            (v (make-@vector len)))
       (declare (not safe))
       (let lp ((rest lst) (at 0))
         (match rest
           ([u . rest]
            (let (ulen (@vector-length u))
              (@vector-copy! v at u 0 ulen)
              (lp rest (fx+ at ulen))))
           (else v)))))))

(defrules defvector-append-subvectors ()
  ((_ @vector-append-subvectors make-@vector @vector-copy!)
   (def (@vector-append-subvectors . args)
     (let* ((len (let lp ((rest args) (r 0))
                   (match rest
                     ([_ start end . rest]
                      (lp rest (fx+ r (fx- end start))))
                     (else r))))
            (v (make-@vector len)))
       (let lp ((rest args) (at 0))
         (match rest
           ([u start end . rest]
            (@vector-copy! v at u start end)
            (lp rest (fx+ at (fx- end start))))
           (else v)))))))

(defrules defvector-empty? ()
  ((_ @vector-empty? @vector-length)
   (def (@vector-empty? v)
     (fxzero? (@vector-length v)))))

(defrules defvector= ()
  ((_ @vector= @vector? @vector-length @vector-ref)
   (def (@vector= v . args)
     (declare (not safe))
     (unless (@vector? v)
       (error "Bad argument" v))
     (let (vlen (@vector-length v))
       (let lp ((rest args))
         (match rest
           ([u . rest]
            (unless (@vector? u)
              (error "Bad argument" u))
            (let (ulen (@vector-length u))
              (if (fx= vlen ulen)
                (let cmp ((i 0))
                  (if (fx< i vlen)
                    (if (= (@vector-ref v i) (@vector-ref u i))
                      (cmp (fx1+ i))
                      #f)
                    (lp rest)))
                #f)))
           (else #t)))))))

(defrules defvector-take ()
  ((_ @vector-take make-@vector @vector-copy!)
   (def (@vector-take v n)
     (let (u (make-@vector n))
       (@vector-copy! u 0 v 0 n)
       u))))

(defrules defvector-take-right ()
  ((_ @vector-take-right make-@vector @vector-length @vector-copy!)
   (def (@vector-take-right v n)
     (let* ((vlen (@vector-length v))
            (ulen (fx- vlen n))
            (u (make-@vector ulen)))
       (@vector-copy! u 0 v n vlen)
       u))))

(defrules defvector-drop ()
  ((_ @vector-drop make-@vector @vector-length @vector-copy!)
   (def (@vector-drop v n)
     (let* ((vlen (@vector-length v))
            (ulen (fx- vlen n))
            (u (make-@vector ulen)))
       (@vector-copy! u 0 v n vlen)
       u))))

(defrules defvector-drop-right ()
  ((_ @vector-drop-right make-@vector @vector-length @vector-copy!)
   (def (@vector-drop-right v n)
     (let* ((vlen (@vector-length v))
            (ulen (fx- vlen n))
            (u (make-@vector ulen)))
       (@vector-copy! u 0 v 0 ulen)
       u))))

(defrules defvector-segment ()
  ((_ @vector-segment @vector-length @vector-copy)
   (def (@vector-segment v n)
     (let lp ((i 0) (rest (@vector-length v)) (r []))
       (if (fx> r 0)
         (let (size (fxmin n rest))
           (lp (fx+ i size)
               (fx- rest size)
               (cons (@vector-copy v i (fx+ i size)) r)))
         (reverse r))))))

(defrules defvector-fold ()
  ((_ @vector-fold @vector-length @vector-ref)
   (def* @vector-fold
     ((kons knil v)
      (unless (procedure? kons)
        (error "Bad argument; expected procedure" kons))
      (let (end (@vector-length v))
        (declare (not safe))
        (let lp ((i 0) (r knil))
          (if (fx< i end)
            (lp (fx1+ i)
                (kons r (@vector-ref v i)))
            r))))
     ((kons knil v . vs)
      (unless (procedure? kons)
        (error "Bad argument; expected procedure" kons))
      (let* ((vs (cons v vs))
             (end (apply fxmin (map @vector-length vs))))
        (declare (not safe))
        (let lp ((i 0) (r knil))
          (if (fx< i end)
            (lp (fx1+ i)
                (apply kons r (map (cut @vector-ref <> i) vs)))
            r)))))))

(defrules defvector-fold-right ()
  ((_ @vector-fold-right @vector-length @vector-ref)
   (def* @vector-fold-right
     ((kons knil v)
      (unless (procedure? kons)
        (error "Bad argument; expected procedure" kons))
      (let (last (fx1- (@vector-length v)))
        (declare (not safe))
        (let lp ((i last) (r knil))
          (if (fx>= i 0)
            (lp (fx1- i)
                (kons r (@vector-ref v i)))
            r))))
     ((kons knil v . vs)
      (unless (procedure? kons)
        (error "Bad argument; expected procedure" kons))
      (let* ((vs (cons v vs))
             (last (fx1- (apply min (map @vector-length vs)))))
        (declare (not safe))
        (let lp ((i last) (r knil))
          (if (fx>= i 0)
            (lp (fx1- i)
                (apply kons r (map (cut @vector-ref <> i) vs)))
            r)))))))

(defrules defvector-map ()
  ((_ @vector-map make-@vector @vector-length @vector-ref @vector-set!)
   (def* @vector-map
     ((f v)
      (unless (procedure? f)
        (error "Bad argument; expected procedure" f))
      (let* ((len (@vector-length v))
             (u (make-@vector len)))
        (declare (not safe))
        (let lp ((i 0))
          (if (fx< i len)
            (begin
              (@vector-set! u i (@vector-ref v i))
              (lp (fx1+ i)))
            u))))
     ((f v . vs)
      (unless (procedure? f)
        (error "Bad argument; expected procedure" f))
      (let* ((vs (cons v vs))
             (len (apply fxmin (map @vector-length vs)))
             (u (make-@vector len)))
        (declare (not safe))
        (let lp ((i 0))
          (if (fx< i len)
            (begin
              (@vector-set! u i (apply f (map (cut @vector-ref <> i) vs)))
              (lp (fx1+ i)))
            u)))))))

(defrules defvector-map! ()
  ((_ @vector-map! @vector-length @vector-ref @vector-set!)
   (def* @vector-map!
     ((f v)
      (unless (procedure? f)
        (error "Bad argument; expected procedure" f))
      (let (len (@vector-length v))
        (declare (not safe))
        (let lp ((i 0))
          (if (fx< i len)
            (begin
              (@vector-set! v i (f (@vector-ref v i)))
              (lp (fx1+ i)))
            v))))
     ((f v . vs)
      (unless (procedure? f)
        (error "Bad argument; expected procedure" f))
      (let* ((vs (cons v vs))
             (len (apply fxmin (map @vector-length vs))))
        (declare (not safe))
        (let lp ((i 0))
          (if (fx< i len)
            (begin
              (@vector-set! v i (apply f (map (cut @vector-ref <> i) vs)))
              (lp (fx1+ i)))
            v)))))))

(defrules defvector-for-each ()
  ((_ @vector-for-each @vector-length @vector-ref)
   (def* @vector-for-each
     ((f v)
      (unless (procedure? f)
        (error "Bad argument; expected procedure" f))
      (let (len (@vector-length v))
        (declare (not safe))
        (let lp ((i 0))
          (when (fx< i len)
            (f (@vector-ref v i))
            (lp (fx1+ i))))))
     ((f v . vs)
      (let* ((vs (cons v vs))
             (len (apply fxmin (map @vector-length vs))))
        (declare (not safe))
        (let lp ((i 0))
          (when (fx< i len)
            (apply f (map (cut @vector-ref <> i) vs))
            (lp (fx1+ i)))))))))

(defrules defvector-count ()
  ((_ @vector-count @vector-length @vector-ref)
   (def* @vector-count
     ((pred v)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let (end (@vector-length v))
        (declare (not safe))
        (let lp ((i 0) (r 0))
          (if (fx< i end)
            (if (pred (@vector-ref v i))
              (lp (fx1+ i) (fx1+ r))
              (lp (fx1+ i) r))
            r))))
     ((pred v . vs)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let* ((vs (cons v vs))
             (end (apply fxmin (map @vector-length vs))))
        (declare (not safe))
        (let lp ((i 0) (r 0))
          (if (fx< i end)
            (if (apply pred (map (cut @vector-ref <> i) vs))
              (lp (fx1+ i) (fx1+ r))
              (lp (fx1+ i) r))
            r)))))))

(defrules defvector-cumulate ()
  ((_ @vector-cumulate make-@vector @vector-length @vector-ref @vector-set!)
   (def (@vector-cumulate f knil v)
     (unless (procedure? f)
       (error "Bad argument; expected procedure" f))
     (let* ((len (@vector-length v))
            (r (make-@vector len)))
       (declare (not safe))
       (let lp ((i 0) (r knil))
         (if (fx< i len)
           (let (next (f r (@vector-ref v i)))
             (@vector-set! v i next)
             (lp (fx1+ i) next))
           v))))))

(defrules defvector-take-while ()
  ((_ @vector-take-while @vector-length @vector-skip @vector-copy)
   (def (@vector-take-while pred v)
     (let* ((len (@vector-length v))
            (idx (@vector-skip pred v))
            (idx (or idx len)))
       (@vector-copy v 0 idx)))))

(defrules defvector-take-while-right ()
  ((_ @vector-take-while-right @vector-length @vector-skip-right @vector-copy)
   (def (@vector-take-while-right pred v)
     (let* ((len (@vector-length v))
            (idx (@vector-skip-right pred v))
            (idx (if idx (fx1+ idx) 0)))
       (@vector-copy v idx len)))))

(defrules defector-drop-while ()
  ((_ @vector-drop-while @vector-length @vector-skip @vector-copy)
   (def (@vector-drop-while pred v)
     (let* ((len (@vector-length v))
            (idx (@vector-skip pred v))
            (idx (or idx len)))
       (@vector-copy v idx len)))))

(defrules defvector-drop-while-right ()
  ((_ @vector-drop-while-right @vector-length @vector-skip-right @vector-copy)
   (def (@vector-drop-while-right pred v)
     (let* ((len (@vector-length v))
            (idx (@vector-skip-right pred v))
            (idx (if idx (fx1+ idx) 0)))
       (@vector-copy v 0 idx)))))

(defrules defvector-index ()
  ((_ @vector-index @vector-length @vector-ref)
   (def* @vector-index
     ((pred v)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let (end (@vector-length v))
        (declare (not safe))
        (let lp ((i 0))
          (if (fx< i end)
            (if (pred (@vector-ref v i))
              i
              (lp (fx1+ i)))
            #f))))
     ((pred v . vs)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let* ((vs (cons v vs))
             (end (apply fxmin (map @vector-length vs))))
        (declare (not safe))
        (let lp ((i 0))
          (if (fx< i end)
            (if (apply pred (map (cut @vector-ref <> i) vs))
              i
              (lp (fx1+ i)))
            #f)))))))

(defrules defvector-index-right ()
  ((_ @vector-index-right @vector-length @vector-ref)
   (def* @vector-index-right
     ((pred v)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let (start (fx1- (@vector-length v)))
        (declare (not safe))
        (let lp ((i start))
          (if (fx>= i 0)
            (if (pred (@vector-ref v i))
              i
              (lp (fx1- i)))
            #f))))
     ((pred v . vs)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let* ((vs (cons v vs))
             (start (fx1- (apply fxmin (map @vector-length vs)))))
        (declare (not safe))
        (let lp ((i start))
          (if (fx>= i 0)
            (if (apply pred (map (cut @vector-ref <> i) vs))
              i
              (lp (fx1- i)))
            #f)))))))

(defrules defvector-skip ()
  ((_ @vector-skip @vector-index)
   (def* @vector-skip
     ((pred v)
      (@vector-index (? (not pred)) v))
     ((pred v . vs)
      (apply @vector-index (? (not pred)) v vs)))))

(defrules defvector-skip-right ()
  ((_ @vector-skip-right @vector-index-right)
   (def* @vector-skip-right
     ((pred v)
      (@vector-index-right (? (not pred)) v))
     ((pred v . vs)
      (apply @vector-index-right (? (not pred)) v vs)))))

(defrules defvector-any ()
  ((_ @vector-any @vector-length @vector-ref)
   (def* @vector-any
     ((pred v)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let (end (@vector-length v))
        (declare (not safe))
        (let lp ((i 0))
          (if (fx< i end)
            (cond
             ((pred (@vector-ref v i)))
             (else
              (lp (fx1+ i))))
            #f))))
     ((pred v . vs)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let* ((v (cons v vs))
             (end (apply fxmin (map @vector-length vs))))
        (declare (not safe))
        (let lp ((i 0))
          (if (fx< i end)
            (cond
             ((apply pred (map (cut @vector-ref <> i) vs)))
             (else
              (lp (fx1+ i))))
            #f)))))))

(defrules defvector-every ()
  ((_ @vector-every @vector-length @vector-ref)
   (def* @vector-every
     ((pred v)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let (end (@vector-length v))
        (declare (not safe))
        (let lp ((i 0) (r #t))
          (if (fx< i end)
            (cond
             ((pred (@vector-ref v i)) => (cut lp (fx1+ i) <>))
             (else #f))
            r))))
     ((pred v . vs)
      (unless (procedure? pred)
        (error "Bad argument; expected procedure" pred))
      (let* ((v (cons v vs))
             (end (apply fxmin (map @vector-length vs))))
        (declare (not safe))
        (let lp ((i 0) (r #t))
          (if (fx< i end)
            (cond
             ((apply pred (map (cut @vector-ref <> i) vs)) => (cut lp (fx1+ i) <>))
             (else #f))
            r)))))))

(defrules defvector-partition ()
  ((_ @vector-partition make-@vector @vector-length @vector-ref @vector-set! @vector-count)
   (def (@vector-partition pred v)
     (let* ((count (@vector-count pred v))
            (len (@vector-length v))
            (u (make-@vector len)))
       (declare (not safe))
       (let lp ((i 0) (left 0) (right count))
         (if (fx< i len)
           (let (x (@vector-ref v i))
             (if (pred x)
               (begin
                 (@vector-set! u left x)
                 (lp (fx1+ i) (fx1+ left) right))
               (begin
                 (@vector-set! u right x)
                 (lp (fx1+ i) left (fx1+ right)))))
           u))))))

(defrules defvector-filter ()
  ((_ @vector-filter make-@vector @vector-length @vector-ref @vector-set! @vector-count)
   (def (@vector-filter pred v)
     (let* ((count (@vector-count pred v))
            (u (make-@vector count))
            (end (@vector-length v)))
       (declare (not safe))
       (let lp ((i 0) (j 0))
         (if (fx< i end)
           (let (x (@vector-ref v i))
             (if (pred x)
               (begin
                 (@vector-set! u j x)
                 (lp (fx1+ i) (fx1+ j)))
               (lp (fx1+ i) j)))
           u))))))

(defrules defvector-remove ()
  ((_ @vector-remove @vector-filter)
   (def (@vector-remove pred v)
     (@vector-filter (? (not pred)) v))))


(defrules defvector-swap! ()
  ((_ @vector-swap! @vector-ref @vector-set!)
   (def (@vector-swap! v i j)
     (let ((iv (@vector-ref v i))
           (jv (@vector-ref v j)))
       (declare (not safe))
       (@vector-set! v i jv)
       (@vector-set! v j iv)))))

(defrules defvector-fill! ()
  ((_ @vector-fill! @vector-length @vector-set! @? @vector?)
   (def (@vector-fill! v fill (start 0) (end (@vector-length v)))
     (declare (not safe))
     (unless (@vector? v)
       (error "Bad argument" v))
     (unless (@? fill)
       (error "Bad argument" fill))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length v))))
       (error "Index out of range" start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length v)))
       (error "Index out of range" end))
     (let lp ((i start))
       (when (fx< i end)
         (@vector-set! v i fill)
         (lp (fx1+ i)))))))

(defrules defvector-reverse! ()
  ((_ @vector-reverse! @vector-length @vector-ref @vector-set! @vector?)
   (def (@vector-reverse! v (start 0) (end (@vector-length v)))
     (declare (not safe))
     (unless (@vector? v)
       (error "Bad argument" v))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length v))))
       (error "Index out of range" start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length v)))
       (error "Index out of range" end))
     (let lp ((i start) (j (fx1- end)))
       (when (fx< i j)
         (let ((iv (@vector-ref v i))
               (jv (@vector-ref v j)))
           (@vector-set! v i jv)
           (@vector-set! v j iv)
           (lp (fx1+ i) (fx1- j))))))))

(defrules defvector-unfold! ()
  ((_ @vector-unfold! @vector-length @vector-set! @vector?)
   (def (@vector-unfold! f v start end seed)
     (declare (not safe))
     (unless (procedure? f)
       (error "Bad argument; expected procedure" f))
     (unless (@vector? v)
       (error "Bad argument" v))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length v))))
       (error "Index out of range" start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length v)))
       (error "Index out of range" end))
     (let lp ((i start) (state seed))
       (when (fx< i end)
         (let ((values x state) (f state))
           (@vector-set! v i x)
           (lp (fx1+ i) state)))))))

(defrules defvector-unfold-right! ()
  ((_ @vector-unfold-right! @vector-length @vector-set! @vector?)
   (def (@vector-unfold-right! f v start end seed)
     (declare (not safe))
     (unless (procedure? f)
       (error "Bad argument; expected procedure" f))
     (unless (@vector? v)
       (error "Bad argument" v))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length v))))
       (error "Index out of range" start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length v)))
       (error "Index out of range" end))
     (let lp ((i (fx1- end)) (state seed))
       (when (fx>= i start)
         (let ((values x state) (f state))
           (@vector-set! v i x)
           (lp (fx1- i) state)))))))

(defrules defvector-reverse-vector->list ()
  ((_ reverse-@vector->list @vector-length @vector-ref @vector?)
   (def (reverse-@vector->list v (start 0) (end (@vector-length v)))
     (declare (not safe))
     (unless (@vector? v)
       (error "Bad argument" v))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length v))))
       (error "Index out of range" start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length v)))
       (error "Index out of range" end))
     (let lp ((i start) (r []))
       (if (fx< i end)
         (lp (fx1+ i) (cons (@vector-ref v i) r))
         r)))))

(defrules defvector-reverse-list->vector ()
  ((_ reverse-list->@vector make-@vector @vector-set! @?)
   (def (reverse-list->@vector lst)
     (let* ((len (length lst))
            (v (make-@vector len)))
       (declare (not safe))
       (let lp ((rest lst) (i 0))
         (match rest
           ([x . rest]
            (unless (@? x)
              (error "Bad element" x))
            (@vector-set! v i x)
            (lp rest (fx1+ i)))
           (else v)))))))

(defrules defvector->vector ()
  ((_ @vector->vector @vector-length @vector-ref @vector?)
   (def (@vector->vector v (start 0) (end (@vector-length v)))
     (declare (not safe))
     (unless (@vector? v)
       (error "Bad argument" v))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length v))))
       (error "Index out of range" start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length v)))
       (error "Index out of range" end))
     (let* ((len (@vector-length v))
            (u (make-vector len)))
       (let lp ((i 0))
         (if (fx< i len)
           (begin
             (vector-set! u i (@vector-ref v i))
             (lp (fx1+ i)))
           u))))))

(defrules defvector<-vector ()
  ((_ vector->@vector make-@vector @vector-set! @?)
   (def (vector->@vector v (start 0) (end (vector-length v)))
     (declare (not safe))
     (unless (vector? v)
       (error "Bad argument; expected vector" v))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (vector-length v))))
       (error "Index out of range" start))
     (unless (and (fixnum? end) (fx<= start end (vector-length v)))
       (error "Index out of range" end))
     (let* ((len (vector-length v))
            (u (make-@vector len)))
       (let lp ((i 0))
         (if (fx< i len)
           (begin
             (@vector-set! u i (vector-ref v i))
             (lp (fx1+ i)))
           u))))))

(defrules defvector-generator ()
  ((_ make-@vector-generator @vector-length @vector-ref @vector?)
   (def (make-@vector-generator v (start 0) (end (@vector-length v)))
     (declare (not safe))
     (unless (@vector? v)
       (error "Bad argument" v))
     (unless (and (fixnum? start) (fx<= 0 start (fx1- (@vector-length v))))
       (error "Index out of range" start))
     (unless (and (fixnum? end) (fx<= start end (@vector-length v)))
       (error "Index out of range" end))
     (let (i start)
       (lambda ()
         (if (fx< i end)
           (let (next (@vector-ref v i))
             (set! i (fx1+ i))
             next)
           #!eof))))))

(defrules defvector-comparator ()
  ((_ @vector-comparator @vector? @vector= @vector-length @vector-ref)
   (def @vector-comparator
     (let ()
       (def (<? a b)
         (let ((len-a (@vector-length a))
               (len-b (@vector-length b)))
           (declare (not safe))
           (cond
            ((fx< len-a len-b) #t)
            ((fx> len-a len-b) #f)
            (else
             (let (end len-a)
               (let lp ((i 0))
                 (if (fx< i end)
                   (let ((x (@vector-ref a i))
                         (y (@vector-ref b i)))
                     (cond
                      ((< x y) #t)
                      ((> x y) #f)
                      (else
                       (lp (fx1+ i)))))
                   #f)))))))
       (make-comparator @vector? @vector= <? equal?-hash)))))

(defrules defvector-write ()
  ((_ write-@vector)
   (def (write-@vector v (port (current-output-port)))
     (cond
      ((method-ref v ':write) => (cut <> v port))
      (else
       (write v (current-output-port)))))))
