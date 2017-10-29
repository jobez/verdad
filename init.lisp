(time (let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                             (user-homedir-pathname))))
        (when (probe-file quicklisp-init)
          (load quicklisp-init))))

(load
 (asdf/system:system-relative-pathname :swank "start-swank.lisp")
 :verbose t)

;; (ecl-to-matrixXd 8 3 #(0.0 0.0 0.0
;;                        0.0 0.0 1.0
;;                        0.0 1.0 0.0
;;                        0.0 1.0 1.0
;;                        1.0 0.0 0.0
;;                        1.0 0.0 1.0
;;                        1.0 1.0 0.0
;;                        1.0 1.0 1.0))

;; (ecl-to-matrixXi 12 3 #(1 6 5
;;                         1 3 7
;;                         1 4 3
;;                         1 2 4
;;                         3 8 7
;;                         3 4 8
;;                         5 7 8
;;                         5 8 6
;;                         1 5 6
;;                         1 6 2
;;                         2 6 8
;;                         2 8 4))

;; (ecl-set-mesh)
;; (ecl-start-igl-viewer)
