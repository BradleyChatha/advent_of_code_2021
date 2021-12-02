package main

import (
	"fmt"
	"strconv"
	"strings"
)

type movement struct {
	Direction string
	Amount    int64
}

func solution() {
	in := string(input)

	var movements []movement

	for _, line := range strings.Split(in, "\n") {
		split := strings.Split(line, " ")
		amount, _ := strconv.ParseInt(split[1], 10, 32)
		movements = append(movements, movement{
			Direction: split[0],
			Amount:    amount,
		})
	}

	s1(movements)
	s2(movements)
}

func s1(movements []movement) {
	vert := 0
	horiz := 0

	for _, m := range movements {
		if m.Direction == "forward" {
			horiz += int(m.Amount)
		} else if m.Direction == "up" {
			vert -= int(m.Amount)
		} else {
			vert += int(m.Amount)
		}
	}

	fmt.Printf("__S1__ = %d\n", vert*horiz)
}

func s2(movements []movement) {
	vert := 0
	horiz := 0
	aim := 0

	for _, m := range movements {
		if m.Direction == "forward" {
			horiz += int(m.Amount)
			vert += int(m.Amount) * aim
		} else if m.Direction == "up" {
			aim -= int(m.Amount)
		} else {
			aim += int(m.Amount)
		}
	}

	fmt.Printf("__S2__ = %d\n", vert*horiz)
}
