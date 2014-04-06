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



*注意: 既存の boot2docker 環境のデータは全て失われます*

### b2d-pipework install

以下の一連の処理を行います

- [Homebrew](http://brew.sh/) を利用して、```docker``` および ```boot2docker``` パッケージの最新版をインストール
- あらかじめ作成した ```profile``` ファイルに従って boot2docker VM を作成
- SSH鍵(```$HOME/.boot2docker/id_rsa```)を新規作成し、boot2docker VM にノンパスワードでアクセスできるようにする
- boot2docker VM 内に pipework をインストールする
- ```192.168.99.0/24``` のアドレスで、VirtualBox ホストオンリーネットワークを構築する


### b2d-pipework run

Usage: ```b2d-pipework run <IP Address> [<Docker options> ...] <Container Image>```

- ```docker run -d -t``` コマンドを実行して任意のコンテナを起動した後、```pipework```を実行して任意のIPアドレスを付与します

- ```docker run``` と同じコマンドラインパラメータを使用できます

実行例

```
b2d-pipework 192.168.99.101 mogproject/sshd
```


制約条件
----

- コンテナには ```192.168.99.0/24``` セグメントの ```.1```, ```.2``` 以外のアドレスを指定してください


使用方法
----

### 事前準備

- [VirtualBox](https://www.virtualbox.org/) のインストール
- [Homebrew](http://brew.sh/) のインストールとカタログ最新化

```
$ sudo brew update
$ sudo brew tap homebrew/binary
```

### インストール

*注意: 既存の boot2docker 環境のデータは全て失われます*

```
$ ./b2d-pipework clean
$ ./b2d-pipework install
```

インストールが完了したら、環境変数を設定。(.bashrc/.zshrc への設定を推奨)

```
$ export DOCKER_HOST=tcp://127.0.0.1:4243
```

### 動作確認

- boot2docker VM にホストオンリーネットワークのアドレスで接続

```
$ ping 192.168.99.2
```

- IPアドレスを指定してコンテナを起動

```
$ ./b2d-pipework run 192.168.99.101 mogproject/sshd
$ docker ps
$ ssh ssh-user@192.168.99.101    # password: ssh-user
```



