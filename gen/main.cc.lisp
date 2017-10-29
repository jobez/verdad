; -*- mode: Lisp; eval: (cm-mode 1); -*-

(include "cl_bridge_utils.hpp")
(include "ecl-root.h")

(function main ((int argc)
               (char *argv[]))
    -> int
  (#:ecl-root::initialize-ecl argc argv)
  (while 1
    ))
