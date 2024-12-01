package main

import (
	"encoding/json"
	"log"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"
)

func HandleRequest() (string, error) {
    log.Println("Sending message to SQS queue")

    sess := session.Must(session.NewSession(&aws.Config{
        Region:   aws.String("us-west-2"),
        Endpoint: aws.String("http://localhost:4566"),
    }))
    sqsSvc := sqs.New(sess)

    messageBody, err := json.Marshal(map[string]string{
        "email": "gottsutaku@gmail.com",
        "name":  "namae",
    })
    if err != nil {
        return "", err
    }

    sqsQueueURL := aws.String("SQS_QUEUE_URL")
    sqsParams := &sqs.SendMessageInput{
        QueueUrl:    sqsQueueURL,
        MessageBody: aws.String(string(messageBody)),
    }

    _, err = sqsSvc.SendMessage(sqsParams)
    if err != nil {
        return "", err
    }

    return "Message sent successfully", nil
}

func main() {
    lambda.Start(HandleRequest)
}