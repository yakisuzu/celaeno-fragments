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
sbt update clean scalafmt test assembly

## gcloud reference
https://cloud.google.com/sdk/gcloud/reference/

## kubernetes customize
https://blog.stack-labs.com/code/kustomize-101/
https://github.com/kubernetes-sigs/kustomize
https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/

## kubernetes deploy
cd ops/k8s/overlays/production
kustomize edit set image app=asia.gcr.io/${PROJECT_ID}/${APP_NAME}:${CIRCLE_SHA1}
kustomize build . | kubectl apply -f -
