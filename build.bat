@echo off

set FILE_NAME=%1
set INCLUDE_PATH=%2
set LIB_PATH=%3
set LIB_FLAGS=%4

rem Changeable variables
rem FILETYPE -> specify the translation unit file type
rem COMPILER -> specify the compiler. supported compiler: g++(c++) and gcc(c)
rem AUTO_RUN -> run the application after compilation
rem EXECUTEABLE_DIR -> specify the location where the executeable file will be placed
set FILETYPE=cpp
set COMPILER=g++
set AUTO_RUN=true
set EXECUTEABLE_DIR=..\bin

set INCLUDEPATH_EXIST=false
set LIBPATH_EXIST=false
set LIBFLAGS_EXIST=false 


set "XINCLUDE_PATH=%INCLUDE_PATH: =%"
set "XLIB_PATH=%LIB_PATH: =%"
set "XLIB_FLAGS=%LIB_FLAGS: =%"


call :strLen XINCLUDE_PATH xinclude_path_len
call :strLen XLIB_PATH xlib_path_len
call :strLen XLIB_FLAGS xlib_flags_len

if not %xinclude_path_len%==2 set INCLUDEPATH_EXIST=true
if not %xlib_path_len%==2 set LIBPATH_EXIST=true
if not %xlib_flags_len%==2 set LIBFLAGS_EXIST=true

if "%INCLUDEPATH_EXIST%"=="true" (
        if "%LIBPATH_EXIST%"=="true" (
            if "%LIBFLAGS_EXIST%"=="true" (
                goto External
            )
        )
)

goto Main


:Main
        

    if "%INCLUDE_PATH%"=="-f" (
        if not "%LIB_PATH%"=="" (
            set EXECUTEABLE_DIR=%LIB_PATH%
        )
    )
    set "DIR=%EXECUTEABLE_DIR%\%FILE_NAME%"
    set "DIR=%DIR: =%"
    echo [STATUS]: compilation section      : Main
    echo [STATUS]: compilation output path  : %DIR%.exe
    echo [STATUS]: autorun                  : %AUTO_RUN%
    if exist %DIR%.exe del %DIR%.exe
    echo [STATUS]: compiling file           : %FILE_NAME%.%FILETYPE%
    %COMPILER% -o %DIR% %FILE_NAME%.%FILETYPE%
    goto Done


:External
    set LAST_PAR=%5
    if not "%LAST_PAR%"=="" (
        set EXECUTEABLE_DIR=%LAST_PAR%
    )
    
    set INCLUDE_PATH=%INCLUDE_PATH:"=%
    set LIB_PATH=%LIB_PATH:"=%
    set LIB_FLAGS=%LIB_FLAGS:"=%
    
    echo [INFO]: include path               : %INCLUDE_PATH%
    echo [INFO]: library path               : %LIB_PATH%
    echo [INFO]: library flags              : %LIB_FLAGS%

    set "DIR=%EXECUTEABLE_DIR%\%FILE_NAME%"
    set "DIR=%DIR: =%"
    echo [STATUS]: compilation section      : External
    echo [STATUS]: compilation output path  : %DIR%.exe
    echo [STATUS]: autorun                  : %AUTO_RUN%
    if exist %DIR%.exe del %DIR%.exe
    echo [STATUS]: compiling file           : %FILE_NAME%.%FILETYPE%
    %COMPILER% -o %DIR% %FILE_NAME%.%FILETYPE% -I%INCLUDE_PATH% -L%LIB_PATH% %LIB_FLAGS%
    goto Done


:Done
   setlocal disabledelayedexpansion
   if "%AUTO_RUN%"=="true" (
        if exist %DIR%.exe (
            echo [STATUS]: executing file %FILE_NAME%.exe
            echo.
            %DIR%.exe
            pause
        )
   ) 
   if not "%AUTO_RUN%"=="true" (
       echo [STATUS]: file compilation done.
   )

   exit /b

  
:strLen
setlocal enabledelayedexpansion

:strLen_Loop
   if not "!%1:~%len%!"=="" set /A len+=1 & goto :strLen_Loop
   (endlocal & set %2=%len%)

