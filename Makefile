FC=nvfortran -mp -byteswapio -Mlarge_arrays -acc=gpu -Minfo=accel,all,intensity,ccff -gpu=lineinfo -O0 -Mcuda -r8
CXX=nvc++ -std=c++11 -acc=gpu -Minfo=accel,all,intensity,ccff -gpu=lineinfo -O0 -Mcuda


all: br_main.x

clean: 
	\rm -f *.o *.mod *.x

br_transcendentals.o: br_transcendentals.cpp
	$(CXX) -c br_transcendentals.cpp

modi_bitrep.o: modi_bitrep.f90
	$(FC) -c modi_bitrep.f90

br_main.x: br_transcendentals.o modi_bitrep.o br_main.F90
	$(FC) -o br_main.x br_main.F90 modi_bitrep.o br_transcendentals.o



