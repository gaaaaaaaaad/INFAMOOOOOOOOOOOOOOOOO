@echo off
setlocal enabledelayedexpansion
set json=
set count=1
for /f "tokens=*" %%i in ('dir /b /ad /on') do (
    if defined json set json=!json!,
    set json=!json!"!count!": "%%i"
    set /a count+=1
)
(echo { & echo %json% & echo }) > Themes.json