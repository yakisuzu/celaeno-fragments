# celaeno-fragments

# TODO
- twitter trendを10分ごとに取得
- Custom Search APIでひとつづつ詳細を検索
  - どこかに保存し、処理済みのワードなら終了
  - 上位10件分くらい？
- MeCab（または何か）で形態素分析
  - ワードに対する頻出の単語を10個くらいピックアップ？
- slackに投稿

# 課題
- ワードどこに保存する
- 必要な環境変数の管理
  - twitter？
  - google
  - slack


# devメモ
## build
`make compile`
`make jar`

## local deploy
`make run-skaffold`

# reference
## gcloud
https://cloud.google.com/sdk/gcloud/reference/

## kubernetes customize
https://blog.stack-labs.com/code/kustomize-101/
https://github.com/kubernetes-sigs/kustomize
https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/

## Custom Search API
https://console.cloud.google.com/apis/api/customsearch.googleapis.com/overview
https://cse.google.com/
https://developers.google.com/custom-search/v1/?hl=ja
https://developers.google.com/custom-search/v1/introduction?hl=ja#identify_your_application_to_google_with_api_key
https://developers.google.com/api-client-library/java/apis/customsearch/v1
