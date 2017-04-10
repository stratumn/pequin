package main

import (
	"crypto/rand"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	var length int
	var err error

	if len(os.Args) > 1 {
		length, err = strconv.Atoi(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}
	} else {
		length = 128
	}

	n, err := rand.Prime(rand.Reader, length)

	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(n)
}
