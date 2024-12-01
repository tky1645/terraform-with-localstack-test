package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

func HandleRequest() (string, error) {
	for _, message := range sqsEvent.Records {
		fmt.Println("Message ID: , Evetnt Source", message.MessageId, message.EventSource)
}

func main() {
	lambda.Start(HandleRequest)
}