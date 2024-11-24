## terraform-sample
- いろんな記事から切り貼りしたsample
- lambda,s3を作成する
- 

 aws lambda invoke \
  --function-name my-lambda \
  --endpoint-url=http://localhost:4574 \
  --log-type Tail \
  outputfile.txt \
  --query 'LogResult' | tr -d '"' | base64
--- 
curl http://localhost:4574/health
---
