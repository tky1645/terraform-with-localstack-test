- プロダクトの構成を読める、編集できるようになる
  -  iamroleなどの権限をからめたterraformの書き方を知る
    - sqsを使ってlambdaを呼び出す構築する
https://qiita.com/WebEngrChild/items/42bbc6fdc1855fa01b6c#%E3%83%8F%E3%83%B3%E3%82%BA%E3%82%AA%E3%83%B3%E7%B7%A8

## 確認コマンド
---
aws lambda --endpoint-url=http://localhost:4566 invoke --function-name ses_email_sender result.log --region us-west-2
{
    "StatusCode": 200,
    "FunctionError": "Unhandled",
    "LogResult": "",
    "ExecutedVersion": "$LATEST"
}


aws lambda --endpoint-url=http://localhost:4566 invoke --function-name sqs_sender result.log --region us-west-2

## リソース可視化
https://docs.pluralith.com/docs/get-started/run-locally/

pluralith login --api-key d470b5a50c2f731647ac3d537d61eb56
pluralith graph

---
 terraform graph | dot -Tpng > graph.png
---
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name テストキュー --region us-west-2

# デプロイパッケージを作成
GOOS=linux GOARCH=amd64 go build -o main
zip -r ./.aws/lamda/sqs_sender.zip main

----
terraform apply -auto-approve