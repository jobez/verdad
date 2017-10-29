(use-package :cm-ifs)

(load "helpers.lisp")

(with-interface (ecl-root)
  (include <ecl/ecl.h>)
  (include <chrono>)
  (include <iostream>)
  (include <fstream>)
  (include "myigl.h")

  (implementation-only
   (include "ecl-helpers.h")
   )

  (namespace
   'ecl-root
   (function initialize-ecl ((int argc)
                             (char* argv[]))
       -> void

     (cl_boot argc argv)
     (atexit cl_shutdown)
     (#:myigl::load-ecl-bindings)
     (load-embed-lisp "init.lisp")
     ;; (decl ((#:std::chrono::high_resolution_clock::time-point start = (#:std::chrono::high_resolution_clock::now))))
     ;; (load-shen)
     ;; (decl ((#:std::chrono::high_resolution_clock::time-point end = (#:std::chrono::high_resolution_clock::now))))

     ;; (<< #:std::cout "shen is ready" #:std::endl)
     ;; (decl ((auto duration = ((instantiate #:std::chrono::duration_cast (#:std::chrono::microseconds) )
     ;;                            (- end start))
     ;;                          )))
     ;; (<< #:std::cout (duration.count) #:std::endl)
     )))
