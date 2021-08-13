# docker-mirakurun-epgstation

[EPGStation](https://github.com/l3tnun/EPGStation) のみの Docker コンテナ
Upstream: [l3tnun/docker-mirakurun-epgstation](https://github.com/l3tnun/docker-mirakurun-epgstation)

## 前提条件

- Docker, docker-compose の導入が必須
- 別途Mirakurunが起動されている
    - 同一ホストでなくても可

## インストール手順

```sh
curl -sf https://raw.githubusercontent.com/Crow314/docker-epgstation/v2/setup.sh | sh -s
cd docker-epgstation

# コメントアウトされている restart や user の設定を適宜変更する
vim docker-compose.yml

# Mirakurunのアドレスを変更する
# mirakurunPathを変更
vim epgstation/config/config.yml
```

## 起動

```sh
sudo docker-compose up -d
```

## 停止

```sh
sudo docker-compose down
```

## 更新

```sh
# mirakurunとdbを更新
sudo docker-compose pull
# epgstationを更新
sudo docker-compose build --pull
# 最新のイメージを元に起動
sudo docker-compose up -d
```

## 設定

### EPGStation

* ポート番号: 8888
* ポート番号: 8889

### 各種ファイル保存先

* 録画データ

```./recorded```

* サムネイル

```./epgstation/thumbnail```

* 予約情報と HLS 配信時の一時ファイル

```./epgstation/data```

* EPGStation 設定ファイル

```./epgstation/config```

* EPGStation のログ

```./epgstation/logs```

## v1からの移行について

[docs/migration.md](docs/migration.md)を参照
