package main

import (
	"fmt"
	"strconv"
	"strings"
)

func solution() {
	s1()
	s2()
}

func s1() {
	in := string(input)
	numbers := strings.Split(in, "\n")

	lastValue, _ := strconv.ParseInt(numbers[0], 10, 32)
	count := 0

	for _, numStr := range numbers[1:] {
		num, _ := strconv.ParseInt(numStr, 10, 32)
		if num > lastValue {
			count++
		}
		lastValue = num
	}

	print(fmt.Sprintf("__S1__ = %d\n", count))
}

func s2() {
	in := string(input)
	numbers := strings.Split(in, "\n")

	var values [3]int64
	values[0], _ = strconv.ParseInt(numbers[0], 10, 32)
	values[1], _ = strconv.ParseInt(numbers[1], 10, 32)
	values[2], _ = strconv.ParseInt(numbers[2], 10, 32)

	lastSum := values[0] + values[1] + values[2]
	count := 0

	for _, numStr := range numbers[3:] {
		num, _ := strconv.ParseInt(numStr, 10, 32)
		values[0] = values[1]
		values[1] = values[2]
		values[2] = num
		sum := values[0] + values[1] + values[2]

		if sum > lastSum {
			count++
		}
		lastSum = sum
	}

	print(fmt.Sprintf("__S2__ = %d\n", count))
}
