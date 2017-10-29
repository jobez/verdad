(use-package :cm-ifs)

(load "helpers")

(with-interface (myigl)
  (include <igl/viewer/Viewer.h>)
  (include "cl_bridge_utils.hpp")
  (namespace
   'myigl
   (implementation-only
    (decl ((#:igl::viewer::Viewer viewer)
           (#:Eigen::MatrixXd V)
           (#:Eigen::MatrixXi F))
      (gen-ecl-wrapper
       (function to-matrixXd
           ((cl_obj rows)
            (cl_obj columns)
            (cl_object verts))
           -> void
         (decl ((int rowz = (rows.to_int))
                (int colz = (columns.to_int))
                (#:Eigen::MatrixXd (v rowz colz)))
           (for ((int row = 0)
                 (<= row (- rowz 1))
                 ++row)
             (for ((int col = 0)
                   (<= col (- colz 1))
                   ++col)
               (decl ((int index = (+ (* row colz) col)))
                 (set (v row col)
                      (ecl_to_double (ecl_aref1 verts index))))))
           (set V v))))

      (gen-ecl-wrapper
       (function to-matrixXi
           ((cl_obj rows)
            (cl_obj columns)
            (cl_object verts))
           -> void
         (decl ((int rowz = (rows.to_int))
                (int colz = (columns.to_int))
                (#:Eigen::MatrixXi (f rowz colz)))
           (for ((int row = 0)
                 (<= row (- rowz 1))
                 ++row)
             (for ((int col = 0)
                   (<= col (- colz 1))
                   ++col)
               (decl ((int index = (+ (* row colz) col)))
                 (set (f row col)
                      (ecl_to_int (ecl_aref1 verts index))))))
           (set F (- (f.array) 1)))))

      (function array-to-matrixXd
          ((int rows)
           (int columns)
           (double verts[]))
          -> #:Eigen::MatrixXd
        (decl ((#:Eigen::MatrixXd (v rows columns)))
          (for ((int row = 0)
                (<= row (- rows 1))
                ++row)
            (for ((int col = 0)
                  (<= col (- columns 1))
                  ++col)
              (decl ((int index = (+ (* row columns) col)))
                (cprint index)
                (set (v row col) verts[index]))))
          (return v)))

      (function array-to-matrixXi
          ((int rows)
           (int columns)
           (int faces[]))
          -> #:Eigen::MatrixXi
        (decl ((#:Eigen::MatrixXi (f rows columns)))
          (for ((int row = 0)
                (<= row (- rows 1))
                ++row)
            (for ((int col = 0)
                  (<= col (- columns 1))
                  ++col)
              (decl ((int index = (+ (* row columns) col)))
                (cprint index)
                (set (f row col) faces[index]))))
          (return f)))


      (function key-down ((#:igl::viewer::Viewer& viewer)
                          (unsigned char key)
                          (int modifier))
          -> bool
        (when (== key (char-code #\1))
          (viewer.core.align_camera_center V F)
          (cprint "hey"))
        (return false)))

    (gen-ecl-wrapper
     (function set-mesh ()
         -> void
       (viewer.data.clear())
       (viewer.data.set_mesh V F)
       (viewer.data.set_face_based true)))

    (gen-ecl-wrapper
     (function start-igl-viewer ()
         -> int

       (cprint V)

       (cprint F)


       (set viewer.callback_key_down &key_down)
       (viewer.launch))))

   (make-ecl-loader)
   ))
