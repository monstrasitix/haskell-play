(defstruct point x y)


(setq points_1
      (list
       (make-point :x 1 :y 2)
       (make-point :x 1 :y 8)))


(setq points_2
      (list
       (make-point :x 1.1 :y 2.2)
       (make-point :x 1.1 :y 8.2)))


(defun point-sum (point)
    (round (+ (point-x point) (point-y point))))


(defun print-point (point)
    (format t "|~s|~%" (point-sum point)))


(dolist (point points_1) (print-point point))
(dolist (point points_2) (print-point point))
