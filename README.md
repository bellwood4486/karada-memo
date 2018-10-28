# からだメモ

Sorry, this document is Japanese only

「からだメモ」とは、症状をメモとして記録ておけるサービスです。

## System dependencies

* Ruby 2.5.1
* Ruby on Rails 5.2.0
* PostgreSQL 10.4

## Setup

リポジトリをクローン後、以下を実行してください。
```
$ cd karada-memo
$ bin/setup
```
コマンドが完了するとデータベースと一緒にデモ用のデータも作られます。

以下のコマンドでサーバーを起動してください。
```
$ bin/rails s
```
サーバーが起動したらブラウザから次のURLにアクセスしてください。

http://localhost:3000

デモ用のユーザーのログイン情報は以下のとおりです。
* 管理ユーザー
  * メールアドレス：admin@example.com
* 一般ユーザー
  * メールアドレス：demo1@example.com

パスワードはいずれも`password`です。

## How to run the test suite

テストは以下のコマンドから実行できます。
```
$ bin/rspec
```

## Deployment instructions

以下の手順でHerokuにデプロイすることができます。

次のAddonをセットアップしてください。

* [Heroku Postgres](https://devcenter.heroku.com/articles/heroku-postgresql)
* [SendGrid](https://elements.heroku.com/addons/sendgrid)
  * [API Key](https://sendgrid.kke.co.jp/docs/User_Manual_JP/Settings/api_keys.html)
  
以下の環境変数を設定してください。

| 環境変数名 | 値 |
----|----
| DATABASE_URL | <Heroku PosgresのデータベースURL> |
| DOMAIN | <Herokuのドメイン> |
| RAILS_MASTER_KEY | <master.keyの値> |
| SENDGRID_API_KEY | <SendGridのapiキー> |
| SENDGRID_PASSWORD | <SendGridのパスワード> |
| SENDGRID_USERNAME | <SendGridのユーザー名> |
| TZ | Asia/Tokyo |

以下のコマンドを実行します。
```
$ git push heroku master
$ heroku run bin/rails db:migrate
$ heroku open
```

