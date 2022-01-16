

include Makefile.$(ARCH)


all: br_main.$(ARCH).x

clean: 
	\rm -f *.$(ARCH).o *.mod *.$(ARCH).x


br_transcendentals.$(ARCH).o: br_transcendentals.cpp
	$(CXX) -o br_transcendentals.$(ARCH).o -c br_transcendentals.cpp

modi_bitrep.$(ARCH).o: modi_bitrep.f90
	$(FC) -o modi_bitrep.$(ARCH).o -c modi_bitrep.f90

br_main.$(ARCH).x: br_transcendentals.$(ARCH).o modi_bitrep.$(ARCH).o br_main.F90
	$(FC) -DARCH="'$(ARCH)'" -o br_main.$(ARCH).x br_main.F90 modi_bitrep.$(ARCH).o br_transcendentals.$(ARCH).o



