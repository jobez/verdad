#ifndef __MYIGL_H__
#define __MYIGL_H__
//INTERFACE GENERATED WITH CM-IFS
#include <igl/viewer/Viewer.h>
#include "cl_bridge_utils.hpp"
typedef bool (*keydown_cb)(igl::viewer::Viewer& viewer, unsigned char key, int modifier);
namespace myigl
{

	void load_ecl_bindings();
}
#endif // __MYIGL_H__
