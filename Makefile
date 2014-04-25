FILES = CMakeLists.txt Makefile configure src/
NAME = name
PROJECT_NAME = parser
TARBALL = ${NAME}-${PROJECT_NAME}.tar.bz2

ERROR="<It seems that the build/ directory is missing\nMaybe you forgot to execute the configure ?>"

.PHONY: check pit track


all:
	@make -C build

clean:
	@echo "\033[33m< ---------------------- >\033[37m"
	@echo "\033[33m<     Cleaning Parser    >\033[37m"
	@echo "\033[33m< ---------------------- >\033[37m"
	@rm -f *.dot
	@if [ -e build/ ] ; then make -C build/ clean ; fi 1>/dev/null

distclean: clean
	@echo "\033[34m< Preparing directory for dist >\033[37m"
	@if [ -e build/ ] ; then rm -fr build/ ; fi 1>/dev/null
	@rm -frv track pit
	@if test -e $(TARBALL) ; then rm -fr $(TARBALL) ; fi 1>/dev/null

check: all
	@echo "\033[33m< -------------------- >\033[37m"
	@echo "\033[33m< Launching test_suite >\033[37m"
	@echo "\033[33m< -------------------- >\033[37m"
	@make -C check/

dist: distclean
	@mkdir ${NAME}
	@cp -r $(FILES) ${NAME}
	@tar cjvf $(TARBALL) ${NAME}
	@rm -fr ${NAME}

distcheck: dist
	@tar -xjvf $(TARBALL)
	@make -C ${NAME} check
	@make distclean
	@rm -fr ${NAME}
