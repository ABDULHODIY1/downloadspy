@echo off
echo Checking for Python installation...

REM Check if Python is installed
where python >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo Python is not installed. Installing Python...

    REM Install Chocolatey
    echo Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    IF %ERRORLEVEL% NEQ 0 (
        echo Chocolatey installation failed. Exiting.
        pause
        exit /b 1
    )

    REM Refresh the environment variables
    echo Refreshing environment variables...
    refreshenv

    REM Install Python 3.12 using Chocolatey
    echo Installing Python 3.12...
    choco install python --version=3.12 -y
    IF %ERRORLEVEL% NEQ 0 (
        echo Python 3.12 installation failed. Exiting.
        pause
        exit /b 1
    )

    REM Refresh the environment variables again after installation
    echo Refreshing environment variables again...
    refreshenv
)

REM Check Python version to ensure it is 3.12
python --version | find "3.12" >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo Python 3.12 installation failed or wrong version installed. Exiting.
    pause
    exit /b 1
)

echo Python 3.12 is installed successfully.

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip
IF %ERRORLEVEL% NEQ 0 (
    echo Pip upgrade failed. Exiting.
    pause
    exit /b 1
)

REM Install required packages
echo Installing required packages...
pip install numpy opencv-python requests pyserial pyinstaller
IF %ERRORLEVEL% NEQ 0 (
    echo Package installation failed. Exiting.
    pause
    exit /b 1
)

REM Inform user that setup is complete
echo Setup complete. Python and required packages have been installed successfully.
pause
