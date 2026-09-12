@echo off
setlocal
rem Homework 2 — 테스트 케이스 1~3 채점

g++ main.cpp problem1.cpp problem2.cpp problem3.cpp problem4.cpp ^
    -o hw2_main.exe -std=c++17 > nul 2>&1
if errorlevel 1 (
    echo Compile Error
    exit /b 1
)

set all_pass=true

for %%i in (1 2 3) do (
    .\hw2_main.exe Test\case%%i.txt > Test\output%%i.txt 2>nul
    if errorlevel 1 (
        echo Test %%i: Runtime Error
        set all_pass=false
    ) else (
        powershell -NoProfile -ExecutionPolicy Bypass -Command ^
            "$a = (Get-Content 'Test\output%%i.txt') -join [char]10; $e = (Get-Content 'Test\expected%%i.txt') -join [char]10; if ($a -eq $e) { Write-Host 'Test %%i: PASS' } else { Write-Host 'Test %%i: FAIL'; Compare-Object ($e -split [char]10) ($a -split [char]10) | ForEach-Object { Write-Host $_.InputObject } }"
    )
)

del hw2_main.exe 2>nul
