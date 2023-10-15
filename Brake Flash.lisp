(define rpm 0)
(define rpms 0)
(define loop false)

(defun set-auxtime (port state time)
    (progn
        (set-aux port state)
        (sleep time)
))

(defun is-brake()
    (progn
        (setvar 'rpms (get-rpm))
        (sleep 0.1)
        (setvar 'rpm (get-rpm))
        (if (< (- rpm rpms) -100)
            (setvar 'loop true))
        (if (>= (- rpm rpms) -100)
            (setvar 'loop false))
    
))

(loopwhile true
     (progn
         (is-brake) 
         (loopwhile loop
            (progn
                (set-auxtime 1 1 0)
                (is-brake)
                (set-auxtime 1 0 0)
                (is-brake)
         ))
        (set-aux 1 1)   
))