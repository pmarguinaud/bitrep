MODULE MODI_BITREP
!
!    MODIFICATIONS
!    -------------  
! J.Escobar : 12/08/2020: for ifort18 , add intent(in) on pure function
!-----------------------------------------------------------------
!
  USE, INTRINSIC :: ISO_C_BINDING
!  
  IMPLICIT NONE

  REAL , PARAMETER, PRIVATE :: XPI = 3.1415926535897932384626433832795
!
CONTAINS
!
ELEMENTAL FUNCTION BR_ATAN(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_ATAN
!
INTERFACE
  PURE FUNCTION BR_ATAN_C(PIN) BIND(C,NAME="br_atan")
!$acc routine seq
    IMPORT C_DOUBLE
    REAL(KIND=C_DOUBLE)                  :: BR_ATAN_C
    REAL(KIND=C_DOUBLE),VALUE,INTENT(IN) :: PIN
  END FUNCTION
END INTERFACE
!
BR_ATAN = BR_ATAN_C(REAL(PVAL,KIND=C_DOUBLE))
!
END FUNCTION
!
!
ELEMENTAL FUNCTION BR_EXP(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_EXP
!
INTERFACE
  PURE FUNCTION BR_EXP_C(PIN) BIND(C,NAME="br_exp")
!$acc routine seq
    IMPORT C_DOUBLE
    REAL(KIND=C_DOUBLE)                  :: BR_EXP_C
    REAL(KIND=C_DOUBLE),VALUE,INTENT(IN) :: PIN
  END FUNCTION
END INTERFACE
!
BR_EXP = BR_EXP_C(REAL(PVAL,KIND=C_DOUBLE))
!
END FUNCTION
!
!
ELEMENTAL FUNCTION BR_LOG(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_LOG
!
INTERFACE
  PURE FUNCTION BR_LOG_C(PIN) BIND(C,NAME="br_log")
!$acc routine seq
    IMPORT C_DOUBLE
    REAL(KIND=C_DOUBLE)                  :: BR_LOG_C
    REAL(KIND=C_DOUBLE),VALUE,INTENT(IN) :: PIN
  END FUNCTION
END INTERFACE
!
BR_LOG = BR_LOG_C(REAL(PVAL,KIND=C_DOUBLE))
!
END FUNCTION
!
!
ELEMENTAL FUNCTION BR_POW(PVAL,PPOW)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL,PPOW
REAL             :: BR_POW
!
BR_POW = BR_EXP( PPOW * BR_LOG(PVAL) )
!
END FUNCTION
!  
ELEMENTAL FUNCTION BR_P2(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_P2
!
BR_P2 = PVAL * PVAL
!!$BR_P2 = PVAL ** 2
!
END FUNCTION BR_P2
!
ELEMENTAL FUNCTION BR_P3(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_P3
!
BR_P3 = PVAL * PVAL * PVAL
!
END FUNCTION BR_P3
!
ELEMENTAL FUNCTION BR_P4(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_P4
!
BR_P4 = PVAL * PVAL * PVAL * PVAL
!
END FUNCTION BR_P4
!
ELEMENTAL FUNCTION BR_SIN(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_SIN
!
INTERFACE
  PURE FUNCTION BR_SIN_C(PIN) BIND(C,NAME="br_sin")
!$acc routine seq
    IMPORT C_DOUBLE
    REAL(KIND=C_DOUBLE)                  :: BR_SIN_C
    REAL(KIND=C_DOUBLE),VALUE,INTENT(IN) :: PIN
  END FUNCTION
END INTERFACE
!
BR_SIN = BR_SIN_C(REAL(PVAL,KIND=C_DOUBLE))
!
END FUNCTION BR_SIN
!
ELEMENTAL FUNCTION BR_ASIN(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_ASIN
!
INTERFACE
  PURE FUNCTION BR_ASIN_C(PIN) BIND(C,NAME="br_asin")
!$acc routine seq
    IMPORT C_DOUBLE
    REAL(KIND=C_DOUBLE)                  :: BR_ASIN_C
    REAL(KIND=C_DOUBLE),VALUE,INTENT(IN) :: PIN
  END FUNCTION
END INTERFACE
!
BR_ASIN = BR_ASIN_C(REAL(PVAL,KIND=C_DOUBLE))
!
END FUNCTION BR_ASIN
!
ELEMENTAL FUNCTION BR_COS(PVAL)
!$acc routine seq
!
REAL, INTENT(IN) :: PVAL
REAL             :: BR_COS
!
INTERFACE
  PURE FUNCTION BR_COS_C(PIN) BIND(C,NAME="br_cos")
!$acc routine seq
    IMPORT C_DOUBLE
    REAL(KIND=C_DOUBLE)                  :: BR_COS_C
    REAL(KIND=C_DOUBLE),VALUE,INTENT(IN) :: PIN
  END FUNCTION
END INTERFACE
!
BR_COS = BR_COS_C(REAL(PVAL,KIND=C_DOUBLE))
!
END FUNCTION BR_COS
!
ELEMENTAL FUNCTION BR_ATAN2(PA,PB)
!$acc routine seq
!
REAL, INTENT(IN) :: PA,PB
REAL             :: BR_ATAN2
!
if (PB > 0.0) then 
   BR_ATAN2 = br_atan(PA/PB);
   
else if ((PB < 0.0) .and. (PA >= 0.0)) then
   BR_ATAN2 = br_atan(PA/PB) + XPI;
   
else if ((PB < 0.0) .and. (PA < 0.0)) then
   BR_ATAN2 = br_atan(PA/PB) - XPI;
   
else if ((PB == 0.0) .and. (PA > 0.0)) then
   BR_ATAN2 = XPI / 2.0 ;
   
else if ((PB == 0.0) .and. (PA < 0.0)) then
   BR_ATAN2 = 0.0 - (XPI / 2.0 );
   
else if ((PB == 0.0) .and. (PA == 0.0)) then
   BR_ATAN2 = 0;               ! represents undefined
end if
!
  END FUNCTION BR_ATAN2
END MODULE MODI_BITREP