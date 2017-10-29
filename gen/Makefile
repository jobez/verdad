all: gen

%.h: %.cc.lisp
	@echo "$< $@"
	@cm-cxx -E "(require :cm-ifs)" -E '(setf cm-ifs:*gen-interface* t)' $< -o ../$@

%.cc: %.cc.lisp
	@echo "CM $<"
	@cm-cxx -E "(require :cm-ifs)" -E '(setf cm-ifs:*gen-interface* nil)'  $< -o ../$@

gen: main.cc ecl-helpers.h ecl-helpers.cc ecl-root.h ecl-root.cc myigl.h myigl.cc

clean:
	rm -f ../*.cc ../*.h
