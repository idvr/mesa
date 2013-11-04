# a40.tpl: Template for A40 Merge
#
MSH
 1 |
 2 ^~\&
 3 $SENDING_APP$
 4 $SENDING_FACILITY$
 5 $RECEIVING_APP$
 6 $RECEIVING_FACILITY$
 7 
 8 
 9 ADT^A40
 10 $MESSAGE_CONTROL_ID$
 11 P
 12 2.3.1
 13 
 14 
 15 
 16 
 17 
EVN
 1 
 2 $EVN_RECORDED_DATE_TIME$
 3 
 4 
 5 
 6 $EVN_EVENT_OCCURRED$
PID
 1
 2 
 3 $PATIENT_ID$
 4 
 5 $PATIENT_NAME$
 6 
 7 $DATE_TIME_BIRTH$
 8 $SEX$
 9
 10 $RACE$
 11 $PATIENT_ADDRESS$
 12 
 13 
 14 
 15 
 16 
 17 
 18 $PATIENT_ACCOUNT_NUM$
 19 
 20 
 21 
 22 
 23 
MRG
 1 $PRIOR_PATIENT_ID_LIST$
 2 
 3 
 4 $PRIOR_PATIENT_ID$
 5 
 6 
 7 $PRIOR_PATIENT_NAME$
