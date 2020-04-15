# logstash-estates-to-es

Logstash の Multiple Pipeline 機能を利用して  
指定のテーブルデータを Elasticsearch に投入する container image base.

original: https://github.com/elastic/dockerfiles/tree/v7.6.2/logstash


## Note
- 起動時のdocker-compose.yml には以下の環境変数を設定してください
  ```docker-compose.yml
      #・・・
      environment:
        - TZ=Asia/Tokyo
        - JDBC_DRIVER_FILENAME=mysql-connector-java-8.0.19.jar
        - RDS_ENDPOINT= <set properly>
        - RDS_DATABASE= <set properly>
        - RDS_USERNAME= <set properly>
        - RDS_PASSWORD= <set properly>
        - ES_ENDPOINT=  <set properly>
      #・・・
  ```

- /usr/share/logstash/pipeline/*.conf は Docker configs を利用して設定してください  
refs: https://matsuand.github.io/docs.docker.jp.onthefly/engine/swarm/configs/

### MySQLのJDBCコネクタ(JDBC Driver for MySQL (Connector/J)) の取得元
- https://www.mysql.com/jp/products/connector/ [^1]
    - Select Operating System では `Platform Independent` を選択した（2020/02/23）


# Footnote
[^1] : ダウンロードにはOracleアカウントのサインアップが必要になる。

