PROGRAM MAIN

USE MODI_BITREP

IMPLICIT NONE

INTEGER, PARAMETER :: NVAL = 1000

REAL, PARAMETER :: ZATAN_X1 = -5.,  ZEXP_X1 = -5.,  ZLOG_X1 = 0.001,  ZSIN_X1 = -5., ZASIN_X1 = -1., ZCOS_X1 = -5.
REAL, PARAMETER :: ZATAN_X2 = +5.,  ZEXP_X2 = +5.,  ZLOG_X2 = 1000.,  ZSIN_X2 = +5., ZASIN_X2 = +1., ZCOS_X2 = +5.

REAL :: ZATAN_X(NVAL),   ZEXP_X(NVAL),   ZLOG_X(NVAL),   ZSIN_X(NVAL),   ZASIN_X(NVAL),   ZCOS_X(NVAL)
REAL :: ZATAN_Y(NVAL,4), ZEXP_Y(NVAL,4), ZLOG_Y(NVAL,4), ZSIN_Y(NVAL,4), ZASIN_Y(NVAL,4), ZCOS_Y(NVAL,4)

INTEGER :: I, J
CHARACTER (LEN=7), PARAMETER :: CLSUF (4) = ['.cpu.i.', '.cpu.b.', '.gpu.i.', '.gpu.b.']
REAL :: Z1, Z2

ZATAN_X  = 0.; ZATAN_Y  = 0.
ZEXP_X   = 0.; ZEXP_Y   = 0.
ZLOG_X   = 0.; ZLOG_Y   = 0.
ZSIN_X   = 0.; ZSIN_Y   = 0.
ZASIN_X  = 0.; ZASIN_Y  = 0.
ZCOS_X   = 0.; ZCOS_Y   = 0.

DO I = 1, NVAL
  Z2 = REAL (I-1) / REAL (NVAL-1)
  Z1 = 1. - Z2
  ZATAN_X (I) = ZATAN_X1 * Z1 + ZATAN_X2 * Z2
  ZEXP_X  (I) = ZEXP_X1  * Z1 + ZEXP_X2  * Z2
  ZLOG_X  (I) = ZLOG_X1  * Z1 + ZLOG_X2  * Z2
  ZSIN_X  (I) = ZSIN_X1  * Z1 + ZSIN_X2  * Z2
  ZASIN_X (I) = ZASIN_X1 * Z1 + ZASIN_X2 * Z2
  ZCOS_X  (I) = ZCOS_X1  * Z1 + ZCOS_X2  * Z2
ENDDO

DO I = 1, NVAL
  ZATAN_Y (I,1) = ATAN (ZATAN_X (I))
  ZEXP_Y  (I,1) = EXP  (ZEXP_X  (I))
  ZLOG_Y  (I,1) = LOG  (ZLOG_X  (I))
  ZSIN_Y  (I,1) = SIN  (ZSIN_X  (I))
  ZASIN_Y (I,1) = ASIN (ZASIN_X (I))
  ZCOS_Y  (I,1) = COS  (ZCOS_X  (I))
ENDDO

DO I = 1, NVAL
  ZATAN_Y (I,2) = BR_ATAN (ZATAN_X (I))
  ZEXP_Y  (I,2) = BR_EXP  (ZEXP_X  (I))
  ZLOG_Y  (I,2) = BR_LOG  (ZLOG_X  (I))
  ZSIN_Y  (I,2) = BR_SIN  (ZSIN_X  (I))
  ZASIN_Y (I,2) = BR_ASIN (ZASIN_X (I))
  ZCOS_Y  (I,2) = BR_COS  (ZCOS_X  (I))
ENDDO

!$acc data copyin (ZATAN_X, ZEXP_X, ZLOG_X, ZSIN_X, ZASIN_X, ZCOS_X) &
!$acc    & copyout (ZATAN_Y (:,3:4), ZEXP_Y (:,3:4), ZLOG_Y (:,3:4), ZSIN_Y (:,3:4), ZASIN_Y (:,3:4), ZCOS_Y (:,3:4))

!$acc serial
DO I = 1, NVAL
  ZATAN_Y (I,3) = ATAN (ZATAN_X (I))
  ZEXP_Y  (I,3) = EXP  (ZEXP_X  (I))
  ZLOG_Y  (I,3) = LOG  (ZLOG_X  (I))
  ZSIN_Y  (I,3) = SIN  (ZSIN_X  (I))
  ZASIN_Y (I,3) = ASIN (ZASIN_X (I))
  ZCOS_Y  (I,3) = COS  (ZCOS_X  (I))
ENDDO

DO I = 1, NVAL
  ZATAN_Y (I,4) = BR_ATAN (ZATAN_X (I))
  ZEXP_Y  (I,4) = BR_EXP  (ZEXP_X  (I))
  ZLOG_Y  (I,4) = BR_LOG  (ZLOG_X  (I))
  ZSIN_Y  (I,4) = BR_SIN  (ZSIN_X  (I))
  ZASIN_Y (I,4) = BR_ASIN (ZASIN_X (I))
  ZCOS_Y  (I,4) = BR_COS  (ZCOS_X  (I))
ENDDO
!$acc end serial

!$acc end data


DO J = 1, 4

  OPEN (71, FILE="ZATAN"//TRIM (CLSUF (J))//"dat", FORM="FORMATTED")
  OPEN (72, FILE="ZEXP"//TRIM (CLSUF (J))//"dat",  FORM="FORMATTED")
  OPEN (73, FILE="ZLOG"//TRIM (CLSUF (J))//"dat",  FORM="FORMATTED")
  OPEN (74, FILE="ZSIN"//TRIM (CLSUF (J))//"dat",  FORM="FORMATTED")
  OPEN (75, FILE="ZASIN"//TRIM (CLSUF (J))//"dat", FORM="FORMATTED")
  OPEN (76, FILE="ZCOS"//TRIM (CLSUF (J))//"dat",  FORM="FORMATTED")
  
  DO I = 1, NVAL
    WRITE (71, '(2E30.20)') ZATAN_X (I), ZATAN_Y (I,J)
    WRITE (72, '(2E30.20)') ZEXP_X  (I), ZEXP_Y  (I,J)
    WRITE (73, '(2E30.20)') ZLOG_X  (I), ZLOG_Y  (I,J)
    WRITE (74, '(2E30.20)') ZSIN_X  (I), ZSIN_Y  (I,J)
    WRITE (75, '(2E30.20)') ZASIN_X (I), ZASIN_Y (I,J)
    WRITE (76, '(2E30.20)') ZCOS_X  (I), ZCOS_Y  (I,J)
  ENDDO
  
  CLOSE (71)
  CLOSE (72)
  CLOSE (73)
  CLOSE (74)
  CLOSE (75)
  CLOSE (76)

ENDDO

END
