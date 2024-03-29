[![Ruby on Rails CI](https://github.com/ko1ke/tich-api/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/ko1ke/tich-api/actions/workflows/rubyonrails.yml)

# アプリの目的

米国 Nasdaq100 企業及び金融マーケットのニュースを自動で収集し、ブラウザで閲覧できるようにする。
実物はここ　https://tich-de99a.web.app/

# 作った経緯

米国テック株投資を始めたものの、米国のテック企業について全然詳しくない。マーケットについても同様。であれば、cron で API に定期的にリクエストを投げ、効率的に情報収集しよう、というのが端緒。~~いちいちググるのめんどくさい~~

# 概要

## それぞれのページについての説明

基本的に左のメニューバーで選択してアクセス。ログインのみ画面最上部の LOGIN ボタンをクリックしてアクセス。

- TopPage: トップページ。それぞれのページについての簡単な説明を記述
- LOGIN： E メールか、Google ログインで登録＆ログインできる
- Company News: 企業ごとのミクロなニュースを閲覧するためのページ。ティッカーシンボルで検索ができる。登録＋ログインしていれば、ポートフォリオに登録したティッカーを"You Favorites"でまとめて検索可能。
- Market News: 金融市場のマクロなニュースを閲覧するためのページ。キーワードで検索できる。
- Favorite News: ログインしたときのみアクセス可能。❤ アイコンをクリックしたニュースを閲覧するためのページ。キーワードで検索できる。
- Portfolio: ログインしたときのみアクセス可能。ティッカーシンボル、およびその目標価格とメモ書きを登録できる。登録したティッカーシンボルは株価が表示される（一日ごとの更新）。また、登録したティッカーシンボルは Company News で検索するときに"You Favorites"でまとめて検索できる。
- Setting: 設定、を作ろうとしたが放置。

## ニュース取得元

以下の 3 つ。

- Finnhub: 金融や仮想通貨系のニュース API を提供しているサービス https://finnhub.io/
- Reddit: 海外の掲示板サービス。日本でいうと５ちゃんねる的なサービス https://www.reddit.com/
- Hacker News: テクノロジー系がメインのニュースサイト https://news.ycombinator.com/

## Nasdaq100 ティッカーシンボル取得元

Wikipedia の関連記事からスクレイピング。

## 株価の取得元

Google spread sheet。ティッカーおよび GOOGLEFINNCE 関数（株価を取得できる関数）をティッカーに適用した spread sheet を作成。外部公開したそれに、リクエストを投げることで、ティッカーとその株価を取得できるようにした。

## 投げ銭

右上のコーヒーアイコンをクリックすると、stripe経由で投げ銭が可能（テストのAPIキーを使用しているため、実際に支払われることはない）

# 主な使用技術

- Ruby on Rails
- faraday
- Docker
- ~~Heroku~~ -> render.com
- Rspec
- Elastic Search
- Github Action