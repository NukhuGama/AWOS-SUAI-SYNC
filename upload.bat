@echo off
setlocal

echo ========================================
echo Starting file upload...
echo ========================================

:: --- CONFIGURATION ---
set "LOCALIP=input local ip"
set "PUBLICIP=input public ip"
set "PORT=2022"
set "WINSCP=C:\Program Files (x86)\WinSCP\WinSCP.com"
set "LOGFILE=C:\Users\Administrator\Documents\winscript_suai\winscp.log"

:: --- CHECK LOCAL IP ---
echo Checking local SFTP server at %LOCALIP%:%PORT% ...
ping -n 1 -w 1000 %LOCALIP% >nul 2>&1
if %errorlevel%==0 (
    echo Local IP reachable. Using local SFTP connection.
    set "SCRIPT=C:\Users\Administrator\Documents\winscript_suai\upload_script.txt"
) else (
    echo Local IP not reachable. Using public SFTP connection.
    set "SCRIPT=C:\Users\Administrator\Documents\winscript_suai\upload_script_publicip.txt"
)

:: --- RUN WINSCP ---
"%WINSCP%" ^
  /log="%LOGFILE%" ^
  /script="%SCRIPT%"

:: --- CHECK RESULT ---
IF %ERRORLEVEL% EQU 0 (
    echo Upload completed successfully.
) ELSE IF %ERRORLEVEL% EQU 1 (
    echo Upload completed with warnings (code 1).
) ELSE (
    echo Upload failed with error code %ERRORLEVEL%.
)

echo ========================================
pause
endlocal
exit /b
