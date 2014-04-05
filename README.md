b2d-pipework
============

Installation helper script for Mac + boot2docker + pipework


概要
----

[boot2docker](https://github.com/boot2docker/boot2docker) と [pipework](https://github.com/jpetazzo/pipework) を使って「任意のIPアドレス付き」のコンテナを持ったDocker環境の構築を簡単にするシェルスクリプトです。

コマンド
----

### b2d-pipework clean

以下の一連の処理を行います

- boot2docker が起動中であれば停止し、VMイメージを削除
- [Homebrew](http://brew.sh/) でインストールされた ```docker``` および ```boot2docker``` をアンインストール
- ```/usr/local/bin/docker``` または ```/usr/local/bin/boot2docker``` が存在する場合は削除
- ```$HOME/.boot2docker``` ディレクトリ(個人用boot2docker設定ディレクトリ)を削除



注意: 既存の boot2docker 環境のデータは全て消去されます

### b2d-pipework install

以下の一連の処理を行います

- [Homebrew](http://brew.sh/) を利用して、```docker``` および ```boot2docker``` パッケージの最新版をインストール
- あらかじめ作成した ```profile``` ファイルに従って boot2docker VM を作成
- SSH鍵(```$HOME/.boot2docker/id_rsa```)を新規作成し、boot2docker VM にノンパスワードでアクセスできるようにする
- boot2docker VM 内に pipework をインストールする
- ```192.168.99.0/24``` のアドレスで、VirtualBox ホストオンリーネットワークを構築する


### b2d-pipework run

```docker run``` コマンドを実行して任意のコンテナを起動した後、```pipework```を実行して任意のIPアドレスを付与します

- ```docker run``` と同じコマンドラインパラメータを使用できます

実行例

```
b2d-pipework 192.168.99.101/24 -d -t mogproject/sshd
```


制約条件
----

- コンテナには ```192.168.99.0/24``` セグメントの ```.1```, ```.2``` 以外のアドレスを指定してください