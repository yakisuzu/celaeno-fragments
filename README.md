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

## gkeとIAM
https://cloud.google.com/solutions/using-gcp-services-from-gke?hl=ja  
https://cloud.google.com/kubernetes-engine/docs/concepts/access-control?hl=ja  
https://cloud.google.com/kubernetes-engine/docs/tutorials/authenticating-to-cloud-platform?hl=ja  

## kubernetes customize
https://kubectl.docs.kubernetes.io/pages/reference/kustomize.html  
https://github.com/kubernetes-sigs/kustomize/blob/master/docs/fields.md  
https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/  
https://blog.stack-labs.com/code/kustomize-101/  

## Custom Search API
https://developers.google.com/custom-search/v1/?hl=ja  
https://developers.google.com/custom-search/v1/introduction?hl=ja#identify_your_application_to_google_with_api_key  

### APIを有効化
https://console.cloud.google.com/apis/api/customsearch.googleapis.com/overview  

### 検索エンジンIDの発行
https://cse.google.com/  

### APIキーの発行
https://console.developers.google.com/apis/credentials  
APIの制限にCustomSearchAPIをつける  
`curl "https://www.googleapis.com/customsearch/v1?key=${API_KEY}&cx=${API_CX}&q=${API_QUERY}" > res.json`  

## Sudachi
https://github.com/WorksApplications/Sudachi  

### dictionary
https://object-storage.tyo2.conoha.io/v1/nc_2520839e1f9641b08211a5c85243124a/sudachi/sudachi-dictionary-20190718-full.zip  
- /system_full.dic  
- /ops/app/system_full.dic  


# sdk
## customsearch
https://developers.google.com/api-client-library/java/apis/customsearch/v1  
