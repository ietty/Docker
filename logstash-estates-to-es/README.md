# logstash-estates-to-es

Logstash の Multiple Pipeline 機能を利用して  
指定のテーブルデータを Elasticsearch に投入する container image base.

original: https://github.com/elastic/dockerfiles/tree/v7.6.2/logstash


## PreRequirement (build)
- config/.env.example を参考に、以下の環境変数に値を設定した config/.env を整備したうえで
`docker build -t ${REGISTRY}:${TAG} .` を行ってください
  - RDS_ENDPOINT
  - RDS_DATABASE
  - RDS_USERNAME
  - RDS_PASSWORD
  - ES_ENDPOINT

※注意事項： .env の最終行に改行のみの１行が必要です。そうしないと最後の行に記述した環境変数が認識されません


## Note

- /usr/share/logstash/pipeline/*.conf は Docker configs を利用して設定してください  
refs: https://matsuand.github.io/docs.docker.jp.onthefly/engine/swarm/configs/

### MySQLのJDBCコネクタ(JDBC Driver for MySQL (Connector/J)) の取得元
- https://www.mysql.com/jp/products/connector/ [^1]
    - Select Operating System では `Platform Independent` を選択した（2020/02/23）


# Footnote
[^1] : ダウンロードにはOracleアカウントのサインアップが必要になる。

