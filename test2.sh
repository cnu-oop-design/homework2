#!/bin/bash
# Homework 2 — 문제별 테스트

mkdir -p Test

g++ main.cpp problem1.cpp problem2.cpp problem3.cpp problem4.cpp \
    -o hw2_main -std=c++17 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compile Error"
    exit 1
fi

./hw2_main > Test/output2.txt 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Runtime Error"
    rm -f hw2_main
    exit 1
fi
rm -f hw2_main

all_pass=true

for i in 1 2 3 4; do
    next=$((i + 1))
    if [ $i -lt 4 ]; then
        actual=$(awk "/=== Problem $i:/{found=1} /=== Problem $next:/{found=0} found{print}" Test/output2.txt | tr -d '\r')
        expected=$(awk "/=== Problem $i:/{found=1} /=== Problem $next:/{found=0} found{print}" Test/expected2.txt)
    else
        actual=$(awk "/=== Problem $i:/{found=1} found{print}" Test/output2.txt | tr -d '\r')
        expected=$(awk "/=== Problem $i:/{found=1} found{print}" Test/expected2.txt)
    fi

    if [ "$actual" = "$expected" ]; then
        echo "Problem $i: PASS"
    else
        echo "Problem $i: FAIL"
        all_pass=false
    fi
done

