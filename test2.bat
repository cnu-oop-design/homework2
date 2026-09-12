@echo off
setlocal
rem Homework 2 — 문제별 테스트

if not exist Test mkdir Test

g++ main.cpp problem1.cpp problem2.cpp problem3.cpp problem4.cpp ^
    -o hw2_main.exe -std=c++17 > nul 2>&1
if errorlevel 1 (
    echo Compile Error
    exit /b 1
)

.\hw2_main.exe > Test\output2.txt 2>nul
if errorlevel 1 (
    echo Runtime Error
    del hw2_main.exe 2>nul
    exit /b 1
)
del hw2_main.exe 2>nul

powershell -NoProfile -ExecutionPolicy Bypass -Command "1..4 | ForEach-Object { $i = $_; $nxt = $i + 1; $get = { param($f) $c = Get-Content $f; $o = @(); $in = $false; foreach ($l in $c) { if ($l -match ('=== Problem ' + $i + ':')) { $in = $true }; if ($in -and $i -lt 4 -and $l -match ('=== Problem ' + $nxt + ':') -and $o.Count -gt 0) { break }; if ($in) { $o += $l } }; $o -join [char]10 }; $a = & $get 'Test\output2.txt'; $e = & $get 'Test\expected2.txt'; if ($a -eq $e) { Write-Host ('Problem ' + $i + ': PASS') } else { Write-Host ('Problem ' + $i + ': FAIL') } }"
