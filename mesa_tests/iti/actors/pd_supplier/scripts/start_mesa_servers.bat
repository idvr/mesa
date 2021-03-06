@ECHO OFF

REM This scripts starts MESA servers used for testing PD Supplier actors

set LOGLEVEL=0


if NOT "%1" == "" set LOGLEVEL=%1

echo Log Level: %LOGLEVEL%

del/q %MESA_STORAGE%\pd_supplier\hl7\*hl7
del/q %MESA_TARGET%\logs\pd_hl7ps.log

REM PD Supplier

start %MESA_TARGET%\bin\hl7_rcvr -d ihe-iti -M PDS -l %LOGLEVEL% -a -z pd_supplier 3700

