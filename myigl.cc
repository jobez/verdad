//IMPLEMENTATION GENERATED WITH CM-IFS
#include "myigl.h"
namespace myigl
{
	igl::viewer::Viewer viewer;
	Eigen::MatrixXd V;
	Eigen::MatrixXi F;

	void to_matrixXd(cl_obj rows, cl_obj columns, cl_object verts)
	{
		int rowz = rows.to_int();
		int colz = columns.to_int();
		Eigen::MatrixXd v(rowz, colz);
		for(int row = 0; row <= (rowz - 1); ++row) {
			for(int col = 0; col <= (colz - 1); ++col) {
				int index = (row * colz) + col;
				v(row, col) = ecl_to_double(ecl_aref1(verts, index));
			}
		}
		V = v;
	}

	cl_object ecl_to_matrixXd(cl_object rows, cl_object columns, cl_object verts)
	{
		to_matrixXd(rows, columns, verts);
		return ecl_make_integer(0);
	}

	void to_matrixXi(cl_obj rows, cl_obj columns, cl_object verts)
	{
		int rowz = rows.to_int();
		int colz = columns.to_int();
		Eigen::MatrixXi f(rowz, colz);
		for(int row = 0; row <= (rowz - 1); ++row) {
			for(int col = 0; col <= (colz - 1); ++col) {
				int index = (row * colz) + col;
				f(row, col) = ecl_to_int(ecl_aref1(verts, index));
			}
		}
		F = f.array() - 1;
	}

	cl_object ecl_to_matrixXi(cl_object rows, cl_object columns, cl_object verts)
	{
		to_matrixXi(rows, columns, verts);
		return ecl_make_integer(0);
	}

	Eigen::MatrixXd array_to_matrixXd(int rows, int columns, double verts[])
	{
		Eigen::MatrixXd v(rows, columns);
		for(int row = 0; row <= (rows - 1); ++row) {
			for(int col = 0; col <= (columns - 1); ++col) {
				int index = (row * columns) + col;
				std::cout << index << std::endl;
				v(row, col) = verts[index];
			}
		}
		return v;
	}

	Eigen::MatrixXi array_to_matrixXi(int rows, int columns, int faces[])
	{
		Eigen::MatrixXi f(rows, columns);
		for(int row = 0; row <= (rows - 1); ++row) {
			for(int col = 0; col <= (columns - 1); ++col) {
				int index = (row * columns) + col;
				std::cout << index << std::endl;
				f(row, col) = faces[index];
			}
		}
		return f;
	}

	bool key_down(igl::viewer::Viewer& viewer, unsigned char key, int modifier)
	{
		if (key == 49) {
			viewer.core.align_camera_center(V, F);
			std::cout << "hey" << std::endl;
		}
		return false;
	}

	void set_mesh()
	{
		viewer.data.clear();
		viewer.data.set_mesh(V, F);
		viewer.data.set_face_based(true);
	}

	cl_object ECL_SET_MESH()
	{
		set_mesh();
		return ecl_make_integer(0);
	}

	int start_igl_viewer()
	{
		std::cout << V << std::endl;
		std::cout << F << std::endl;
		viewer.callback_key_down = &key_down;
		viewer.launch();
	}

	cl_object ECL_START_IGL_VIEWER()
	{
		start_igl_viewer();
		return ecl_make_integer(0);
	}

	void load_ecl_bindings()
	{
		cl_def_c_function(c_string_to_object("ecl-start-igl-viewer"), ((cl_objectfn_fixed)ECL_START_IGL_VIEWER), 0);
		cl_def_c_function(c_string_to_object("ecl-set-mesh"), ((cl_objectfn_fixed)ECL_SET_MESH), 0);
		cl_def_c_function(c_string_to_object("ecl-to-matrixXi"), ((cl_objectfn_fixed)ecl_to_matrixXi), 3);
		cl_def_c_function(c_string_to_object("ecl-to-matrixXd"), ((cl_objectfn_fixed)ecl_to_matrixXd), 3);
	}
}