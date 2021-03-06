package main

import (
	"log"
	"net/http"

	"test.com/myapp/hw"

	"github.com/go-chi/chi"
)

func main() {
	r := chi.NewRouter()

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte(hw.HelloWorld()))
	})

	port := "8080"
	err := http.ListenAndServe(":"+port, r)
	if err != nil {
		log.Fatalf("Error starting the Server. Error: %s", err.Error())
	}

	log.Println("Started the server !")
}
