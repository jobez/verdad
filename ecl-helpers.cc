//IMPLEMENTATION GENERATED WITH CM-IFS
#include "ecl-helpers.h"
namespace ecl_helpers
{

	void call_lisp(const std::string &call)
	{
		cl_eval(c_string_to_object(call.c_str()));
	}
}