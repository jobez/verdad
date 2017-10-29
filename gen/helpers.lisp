(use-package :metabang-bind)

#|

This contains a small proof in concept for generating
and exposing wrappers of functions in c land to ecl.

It is ugly code with tremendous personality that will blossom later in life.

|#


(defvar *ecl-wrapper-exprs* nil)

(defun symbolicate (&rest syms)
  (intern (format nil "~{~a~}" syms) :keyword))

(defmacro c-to-cl (name fun arg-count)
  `(funcall cl_def_c_function
            (funcall c_string_to_object ,name)
            (cast cl_objectfn_fixed ,fun)
            ,arg-count))


(defun need-to-provider (arg-pair)
  ;; need a cleaner interface for getting the
  ;; c type to pattern match on

  (case (first arg-pair)

    ((string)
     `(funcall #:ecl-helpers::cl-str-to-str
               ,(second arg-pair)))
    (otherwise (second arg-pair))))

(defmacro gen-ecl-wrapper (cc-fun)
  (bind (((_ name args &rest things) cc-fun)
         (wrapper-name (symbolicate 'ecl- name))
         (ecl-args (cl:mapcar
                    (cl:lambda (arg)
                      `(cl-object ,(cl:second arg)))
                    args))
         (provisions (cl:mapcar #'need-to-provider args)))
        (declare (ignore things))
        (push (c-to-cl (symbol-name wrapper-name)
                       wrapper-name (cl:length args))
              *ecl-wrapper-exprs*)
        `(decl ()
           ,cc-fun
           (function ,wrapper-name ,ecl-args -> cl-object
             (funcall ,name ,@provisions)
             (return (funcall ecl_make_integer 0)))

           )))

(defmacro cprint (msg)
  `(<< #:std::cout ,msg #:std::endl))

(defmacro make-ecl-loader ()
  `(function load-ecl-bindings ()
       -> void
     ,@*ecl-wrapper-exprs*))

;; cmera needs double \'s to escape strings
(defmacro load-embed-lisp (file)
  `(funcall #:ecl-helpers::call-lisp
            ,(format nil "(load \\\"~a\\\")"
                     file)))

(defmacro compile-embed-lisp (file)
  `(funcall call-lisp
            ,(format nil "(compile-file \\\"~a\\\")"
                     file)))

(defmacro inject-syntax (string)
  `(comment ,string :prefix ""))
