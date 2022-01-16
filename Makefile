

include Makefile.$(ARCH)


all: br_main.$(ARCH).x

clean: 
	\rm -f *.$(ARCH).o *.mod *.$(ARCH).x


parkind1.$(ARCH).o: parkind1.F90
	$(FC) -o parkind1.$(ARCH).o -c parkind1.F90

br_transcendentals.$(ARCH).o: br_transcendentals.cpp
	$(CXX) -o br_transcendentals.$(ARCH).o -c br_transcendentals.cpp

br_intrinsics.$(ARCH).o: br_intrinsics.F90 parkind1.$(ARCH).o
	$(FC) -o br_intrinsics.$(ARCH).o -c br_intrinsics.F90

br_main.$(ARCH).x: br_transcendentals.$(ARCH).o br_intrinsics.$(ARCH).o br_main.F90
	$(FC) -DARCH="'$(ARCH)'" -o br_main.$(ARCH).x br_main.F90 br_intrinsics.$(ARCH).o br_transcendentals.$(ARCH).o



