@echo off
setlocal

rem Python versiyasi va yuklab olish havolasi
set "PYTHON_VERSION=3.10.0"
set "PYTHON_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-amd64.exe"

rem Vaqtinchalik yuklab olish va o'rnatish katalogini yaratish
set "TEMP_DIR=%~dp0temp_python"
mkdir "%TEMP_DIR%"
cd /d "%TEMP_DIR%"

rem Pythonni yuklab olish
echo Yuklab olinmoqda...
powershell -command "Invoke-WebRequest -Uri %PYTHON_URL% -OutFile python_installer.exe"

rem Pythonni o'rnatish
echo O'rnatilmoqda...
python_installer.exe /quiet InstallAllUsers=1 PrependPath=1

rem Temp katalogni tozalash
cd /d %~dp0
rmdir /s /q "%TEMP_DIR%"

rem O'rnatilgan Pythonni tekshirish
python --version

endlocal
echo O'rnatish tugadi.
pause
