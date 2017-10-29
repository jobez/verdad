//IMPLEMENTATION GENERATED WITH CM-IFS
#include "ecl-root.h"
#include "ecl-helpers.h"
namespace ecl_root
{

	void initialize_ecl(int argc, char* argv[])
	{
		cl_boot(argc, argv);
		atexit(cl_shutdown);
		myigl::load_ecl_bindings();
		ecl_helpers::call_lisp("(load \"init.lisp\")");
	}
}