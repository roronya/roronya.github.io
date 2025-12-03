# blog

## usage

```shell
$ make all # ブログをすべてビルドする
$ make top # トップページだけ更新する
$ make articles # 記事ページすべてを更新する
$ make article slug=2024050511 # 特定の記事だけ更新する
$ # templateの変更や記事の更新などに合わせて適切に使い分けること
$ git push # github actionsでデプロイされる
```

## emacs
emacsで以下のようなヘッダを書くと保存時にmarkdownディレクトリ配下にコピーされる。

```yaml
---
target: "blog"
slug: 202501032235
---
```

## directory structure

```shell
.
├── Makefile # ビルドのためのコマンド群
├── README.md
├── docs # Webページのドキュメントルート
│   ├── XXXXXXXXXXXX.html
│   ├── images # 画像はここに配置し、htmlからは相対パスでアクセスする e.g. <img src="./images/roronya.jpeg"/>
│   │   ├── favicon.ico
│   │   ├── large-header.jpg
│   │   ├── middle-header.jpg
│   │   ├── roronya.jpeg
│   │   └── small-header.jpg
│   ├── index.html # トップページ
│   └── style.css # スタイルシートはdocs配下を直接触る
├── entries.md # トップページに埋め込まれる記事一覧の元ファイル。markdown配下を走査して作っている。make entriesを参考。
├── markdown # emacsで記事を書くとこのディレクトリにコピーされる
│   ├── XXXXXXXXXXXX.md
├── pandoc # pandocで使っているフィルタ。markdownをパースして情報を取得しhtmlに整形するために使う。
│   └── filter.py
└── templates # pandocのテンプレート。レイアウトを変更したいときに触る。変更したらmakeするとdocs配下が更新される。
    ├── article.html # 記事ページのテンプレート
    └── top.html # トップページのテンプレート
```
