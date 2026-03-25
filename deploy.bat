@echo off
if "%~1"=="" goto usage
if "%~2"=="" goto usage
if "%~3"=="" goto usage
if not "%~6"=="" goto usage

@REM 参数
set "WINDEPLOYQT=%~1"

set "NAME=%~n3"

set "BUILD_EXE=%~2"
set "DEPLOY_EXE=%~3"

set "DEPLOY_ROOT=%~dp3"
set "DEPLOY_ROOT=%DEPLOY_ROOT:~0,-1%"

set "BUILD_LICENSE=%~4"
set "LICENSE_NAME=%~nx4"

set "BUILD_README=%~5"
set "README_NAME=%~nx5"

for /f "usebackq delims=" %%i in (`powershell -c "[Environment]::GetFolderPath('Desktop')"`) do set "DESKTOP_PATH=%%i"

goto main



:usage
echo Args: ^<WINDEPLOYQT^> ^<BUILD_EXE^> ^<DEPLOY_EXE^> ^<BUILD_LICENSE^> ^<BUILD_README^>
exit /b 1



:main
@REM 清理
if exist "%DEPLOY_ROOT%" (
    powershell -c "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory('%DEPLOY_ROOT%', 'OnlyErrorDialogs', 'SendToRecycleBin')"
)

@REM 复制
echo F | xcopy "%BUILD_EXE%" "%DEPLOY_EXE%"
if exist "%BUILD_LICENSE%" (
    echo F | xcopy "%BUILD_LICENSE%" "%DEPLOY_ROOT%\%LICENSE_NAME%"
)
if exist "%BUILD_README%" (
    echo F | xcopy "%BUILD_README%" "%DEPLOY_ROOT%\%README_NAME%"
)

@REM 部署
"%WINDEPLOYQT%" --no-translations --no-system-d3d-compiler --no-opengl-sw -no-svg -no-network "%DEPLOY_EXE%"

@REM 清理
if exist "%DEPLOY_ROOT%\styles" (
    powershell -c "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory('%DEPLOY_ROOT%\styles', 'OnlyErrorDialogs', 'SendToRecycleBin')"
)
if exist "%DEPLOY_ROOT%\imageformats" (
    powershell -c "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory('%DEPLOY_ROOT%\imageformats', 'OnlyErrorDialogs', 'SendToRecycleBin')"
)

@REM 压缩
set "ARCHIVE=%DESKTOP_PATH%\%NAME%.7z"
if exist "%ARCHIVE%" (
    powershell -c "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile('%ARCHIVE%', 'OnlyErrorDialogs', 'SendToRecycleBin')"
)

@REM bz 指令来自 Bandizip
bz c -fmt:7z -l:9 -y "%ARCHIVE%" "%DEPLOY_ROOT%"
