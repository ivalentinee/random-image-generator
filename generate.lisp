(defun arguments ()
  (cdr *posix-argv*))

(setf *random-state* (make-random-state t))

(defparameter *image-count* (parse-integer (car (arguments))))
(defparameter *picture-width* 1920)
(defparameter *picture-height* 1080)
(defparameter *text-size* 60)
(defparameter *font* "DejaVu-Sans")

(defparameter *picture-size*
  (concatenate 'string
               (write-to-string *picture-width*)
               "X"
               (write-to-string *picture-height*)))

(defparameter *circle-colors-list* '("red" "blue" "lime" "yellow" "cyan" "purple" "pink" "green" "magenta" "white"))
(defparameter *circle-colors-count* (length *circle-colors-list*))

(defun random-circle-count (max-circle-count)
  (+ 1 (random (- max-circle-count 1))))

(defun random-ids (id-count max-id)
  (let ((id-list ()))
    (dotimes (i id-count)
      (setf id-list (cons (random max-id) id-list)))
    id-list))

(defun circle-colors (random-ids)
  (mapcar #'(lambda (id) (nth id *circle-colors-list*)) random-ids))

(defun circle-coordinates (circle-count index)
  (let ((x (floor (* (/ *picture-width* (+ circle-count 1)) (+ index 1))))
        (y (floor (/ *picture-height* 2))))
    (concatenate 'string (write-to-string x) "," (write-to-string y))))

(defun circles (circle-colors)
  (loop for index from 0
        and value in circle-colors
        collecting (concatenate 'string (circle-coordinates (length circle-colors) index) " " value)))

(defun circle-parameter (circles)
  (reduce #'(lambda (x y) (concatenate 'string x "  " y)) circles))

(defun random-circle-parameter ()
  (circle-parameter (circles (circle-colors (random-ids (random-circle-count *circle-colors-count*) *circle-colors-count*)))))

(defun text-coordinates ()
  (concatenate 'string
               (write-to-string (floor (/ *picture-width* 20)))
               ","
               (write-to-string (floor (/ *picture-height* 2)))))

(defun text-parameter (id)
  (concatenate 'string "text " (text-coordinates) " 'Test Image #" (write-to-string id) "'"))

(defun image-filename (id)
  (concatenate 'string "image_" (write-to-string id) ".png"))

(defun im-args (id)
  (list "-size" *picture-size* "xc:" "-sparse-color" "Shepards" (random-circle-parameter) "-font" *font* "-pointsize" (write-to-string *text-size*) "-draw" (text-parameter id) (image-filename id)))

(defun create-image (id)
  (format t "Writing image #~a~%" id)
  (sb-ext:run-program "/usr/bin/convert" (im-args id)))

(dotimes (id *image-count*)
  (create-image (+ id 1)))
