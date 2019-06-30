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
- どこで動かす
  - gkeのreplicaset1？
- cats使いたい
- 必要な環境変数の管理
  - twitter？
  - google
  - デプロイまわり（ciでやるからたぶんいい）
  - slack

# devメモ
## build
sbt update clean scalafmt test assembly

## gcloud reference
https://cloud.google.com/sdk/gcloud/reference/

## gcloud active
gcloud config configurations activate celaeno-fragments
gcloud config configurations list

## gcloud auth
echo ${GCLOUD_SERVICE_KEY_ENCODED} | base64 --decode -i | gcloud auth activate-service-account --key-file=-

## docker-credential check
cat ~/.docker/config.json

## docker-credential-gcloud
gcloud auth configure-docker --quiet
echo "https://asia.gcr.io" | docker-credential-gcloud get

## docker-credential-gcr
https://cloud.google.com/container-registry/docs/access-control
gcloud components install docker-credential-gcr --quiet
docker-credential-gcr configure-docker
docker-credential-gcr gcr-login
echo "https://asia.gcr.io" | docker-credential-gcr get

## kubectl setup
gcloud container clusters get-credentials ${CLUSTER_NAME}


## check
docker pull asia.gcr.io/${PROJECT_ID}/${APP_NAME}:latest
k delete -f ops/k8s/deployment.yaml \
  && k apply -f ops/k8s/deployment.yaml \
  && sleep 5 \
  && k describe pod
