(time (let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                             (user-homedir-pathname))))
        (when (probe-file quicklisp-init)
          (load quicklisp-init))))

(load
 (asdf/system:system-relative-pathname :swank "start-swank.lisp")
 :verbose t)
