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
