package main

import (
	"fmt"
	"log"
	"os"
	"time"
)

var input []byte

func main() {
	var err error
	input, err = os.ReadFile("./input.txt")
	if err != nil {
		log.Fatal(err)
	}

	start := time.Now().UnixMicro()
	solution()
	end := time.Now().UnixMicro()

	print(fmt.Sprintf("__TIME__ = %d", end-start))
}
