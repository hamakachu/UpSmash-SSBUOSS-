# README

## アプリケーション名
UpSmash!
---
## アプリケーション概要
ゲームソフト"大乱闘スマッシュブラザーズSPECIAL"に関するアプリケーションで、対戦を行いその内容を言語化したり、
攻略情報などを共有することで、プレイヤーの実力向上を図る。

---
## URL
https://upsmash.onrender.com/
---
## テスト用アカウント
* Basic認証ID: admin 
* Basic認証PASS: 2222

* テストユーザー1 
  * email: test1@com 
  * pass: test1111

* テストユーザー2 
  * email: test2@com 
  * pass: test2222 
---
## 利用方法
### 対戦機能
* ログインした状態でフリー対戦ページへ移動、ルーム作成ボタンからルーム作成
* ルール選択、チャットが可能
### アウトプットフォーム機能
* ログインした状態で昨対戦振り返りページへ移動、2種のフォームから一つを選択して作成する。
* 作成したフォームの内容はユーザーページから確認可能。
### 記事投稿機能
* 未ログイン状態でも記事閲覧は可能。
* ログイン状態で記事一覧ページにアクセスすると、記事を作成できる。
* ログイン中のユーザーは記事にコメントをつけることができる。
---
## アプリケーション作成の背景

"スマブラ"を競技としてプレイするコミュニティに所属する中で、効果的な実力向上手段がわからず闇雲に試合をこなすだけのプレイヤーが多いとわかった。
同じようなモチベーションのプレーヤーが集まり、対戦を行い、言語化フォームに沿ってアウトプットを行うことで、競技プレイヤーの実力を向上させコミュニティを活発化したいと考えた。

---
## 洗い出した要件
* 要件定義書スプレッドシート
https://docs.google.com/spreadsheets/d/1LDHzZklzbuXHgqpPyn01FlZK_8XMps6PhkcIZJPeAHI/edit#gid=982722306
---
## 実装予定の機能
* テストコードでの挙動確認
* 実績解除機能：フォーム送信数や記事投稿数、対戦数などでバッジのようなものが解放されていく機能
* ルール変更がページ遷移せずに行え、かつ即時に反映される機能
* 記事作成機能の拡張(Wordなどのように直感的に文書作成ができる機能)
* アプリ内検索機能
---
## データベース設計
[![Image from Gyazo](https://i.gyazo.com/e28b282fb2c5e94d74b5ef4d06b15690.png)](https://gyazo.com/e28b282fb2c5e94d74b5ef4d06b15690)

## 画面遷移
[![Image from Gyazo](https://i.gyazo.com/acb87fb6a98d9c2b19985a09baa34b4b.png)](https://gyazo.com/acb87fb6a98d9c2b19985a09baa34b4b)
---
## 開発環境
* フロントエンド
* バックエンド
* テキストエディタ
* タスク管理
---
## ローカルでの動作方法
* % git clone https://github.com/hamakachu/UpSmash-SSBUOSS-
* % cd UpSmash-SSBUOSS-
* % bundle install
* % yarn install
---
## 工夫した点
対戦相手が現れるのを待つ仕様を実現するため、対戦ルーム作成時に保存される情報を絞り、参加者がボタンを押すことで参加者のデータが保存されるようにした。
