(ql:quickload :cffi)

(cffi:defcallback on-keydown
    :bool
    ((viewer :pointer)
     (key :char)
     (modifier :int))
  (princ key))

(ecl-set-keydown-cb (cffi:callback on-keydown))


(ecl-to-matrixXd 8 3 #(0.0 0.0 0.0
                       0.0 0.0 1.0
                       0.0 1.0 0.0
                       0.0 1.0 1.0
                       1.0 0.0 0.0
                       1.0 0.0 1.0
                       1.0 1.0 0.0
                       1.0 1.0 1.0))

(ecl-to-matrixXi 12 3 #(1 7 5
                        1 3 7
                        1 4 3
                        1 2 4
                        3 8 7
                        3 4 8
                        5 7 8
                        5 8 6
                        1 5 6
                        1 6 2
                        2 6 8
                        2 8 4))

(ecl-set-mesh)
(ecl-start-igl-viewer)
