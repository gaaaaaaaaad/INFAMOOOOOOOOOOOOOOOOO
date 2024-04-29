@echo off
setlocal enabledelayedexpansion
set json=
set count=1
for /f "tokens=*" %%i in ('dir /b /ad /on') do (
    set json=!json!"!count!": "%%i",   
    set /a count+=1
)
(echo { & echo %json:~0,-1% & echo }) > Themes.json