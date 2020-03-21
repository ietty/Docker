# logstash-estates-to-es

Logstash の pipeline 機能を利用して指定のテーブルデータを Elasticsearch に投入する container image base.


## PreRequirement
- .env for [staging|production]
    - .env.example に以下項目を設定してください
    ```
    RDS_ENDPOINT=
    RDS_DATABASE=
    RDS_USERNAME=
    RDS_PASSWORD=
    ES_ENDPOINT=
    ```

- image build 
    - `bash ./build.sh ${CONTAINER_REGISTRY} ${TAG_NAME}` 


## Note

- /usr/share/logstash/pipeline/*.conf は Docker configs を利用して設定してください  
refs: https://matsuand.github.io/docs.docker.jp.onthefly/engine/swarm/configs/

### MySQLのJDBCコネクタ(JDBC Driver for MySQL (Connector/J)) の取得元
- https://www.mysql.com/jp/products/connector/ [^1]
    - Select Operating System では `Platform Independent` を選択した（2020/02/23）


# Footnote
[^1] : ダウンロードにはOracleアカウントのサインアップが必要になる。
