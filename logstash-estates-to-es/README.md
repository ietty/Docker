# logstash-estates-to-es

Logstash の pipeline 機能を利用して指定のテーブルデータを Elasticsearch に投入する container image base.


## PreRequirement
- volume `logstash_env` が整備されていることを確認してください
    - 状況確認方法: 
        1. 実体パス確認
            - `docker volume ls --format "{{.Name}} : {{.Driver}} : {{.Mountpoint}}" | grep logstash_env`
        1. そのディレクトリに cd して ls -la
        1. export.sh と .env.[staging|production] が存在して内容が妥当なことを確認する


## Note

- /usr/share/logstash/pipeline/*.conf は Docker configs を利用して設定してください  
refs: https://matsuand.github.io/docs.docker.jp.onthefly/engine/swarm/configs/

### MySQLのJDBCコネクタ(JDBC Driver for MySQL (Connector/J)) の取得元
- https://www.mysql.com/jp/products/connector/ [^1]
    - Select Operating System では `Platform Independent` を選択した（2020/02/23）


# Footnote
[^1] : ダウンロードにはOracleアカウントのサインアップが必要になる。
