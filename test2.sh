#!/bin/bash
# Homework 2 — 테스트 케이스 1~3 채점

g++ main.cpp problem1.cpp problem2.cpp problem3.cpp problem4.cpp \
    -o hw2_main -std=c++17 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compile Error"
    exit 1
fi

all_pass=true

for i in 1 2 3; do
    ./hw2_main Test/case${i}.txt > Test/output${i}.txt 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "Test ${i}: Runtime Error"
        all_pass=false
        continue
    fi

    actual=$(cat Test/output${i}.txt | tr -d '\r')
    expected=$(cat Test/expected${i}.txt)

    if [ "$actual" = "$expected" ]; then
        echo "Test ${i}: PASS"
    else
        echo "Test ${i}: FAIL"
        diff <(echo "$expected") <(echo "$actual")
        all_pass=false
    fi
done

rm -f hw2_main

if [ "$all_pass" = true ]; then
    echo "All tests passed!"
fi
