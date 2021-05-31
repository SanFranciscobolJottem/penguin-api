package main

import (
	"flag"
	"fmt"
	"net/http"

	"github.com/SanFranciscobolJottem/penguin-api/pkg/handlers"
)

const (
	defaultAddress string = "0.0.0.0"
	defaultPort    int    = 80
)

var (
	address string
	port    int
)

func main() {
	flag.StringVar(&address, "address", defaultAddress, "Server's Address")
	flag.IntVar(&port, "port", defaultPort, "Server's Port")
	flag.Parse()
	runAPI()
}

func runAPI() {
	fullAddress := fmt.Sprintf("%s:%d", address, port)
	fmt.Printf("\n Server is running on %s", fullAddress)
	http.HandleFunc("/test", handlers.TestHandler)
	http.ListenAndServe(fullAddress, nil)
}
