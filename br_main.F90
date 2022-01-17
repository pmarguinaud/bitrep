PROGRAM MAIN

USE MODI_BITREP

IMPLICIT NONE

REAL :: X, Y1, Y2


X = 0.22023000000046451419E+02_8

Y1 = BR_LOG (X)

!$acc serial copyin (X) copyout (Y2)
Y2 = BR_LOG (X)
!$acc end serial

WRITE (0, '(3E30.20)') X, Y1, Y2

END
