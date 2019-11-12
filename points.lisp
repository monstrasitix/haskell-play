(defstruct point x y)


(setq points_1
      (list
       (make-point :x 1 :y 2)
       (make-point :x 1 :y 8)))


(setq points_2
      (list
       (make-point :x 1 :y 2)
       (make-point :x 1 :y 8)))


(defun point-sum (point)
    (+ (point-x point) (point-y point)))


(dolist (point points_1)
    (format t "|~s|~%" (point-sum point)))


(dolist (point points_2)
    (format t "|~s|~%" (point-sum point)))
