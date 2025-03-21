@echo off
set "url=https://www.infamousunleashed.org/Loader/Infamous Loader.exe"
set "output_file=Infamous Loader.exe"


echo Waiting for 2 seconds...
timeout /t 2 >nul
if exist "%output_file%" (
    del "%output_file%"
)

echo Downloading file...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%output_file%')"
