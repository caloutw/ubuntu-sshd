# 注意
原分支來自 [aoudiamoncef/ubuntu-sshd](https://github.com/aoudiamoncef/ubuntu-sshd)

此項目專門為了 Visual Studio Code SSH 所生

直接內建包含 Workspace 資料夾

# ubuntu-sshd

[![Docker Image CI](https://github.com/aoudiamoncef/ubuntu-sshd/actions/workflows/ci.yml/badge.svg)](https://github.com/aoudiamoncef/ubuntu-sshd/actions/workflows/ci.yml)
[![Docker Image Deployment](https://github.com/aoudiamoncef/ubuntu-sshd/actions/workflows/cd.yml/badge.svg)](https://github.com/aoudiamoncef/ubuntu-sshd/actions/workflows/cd.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/aoudiamoncef/ubuntu-sshd.svg)](https://hub.docker.com/r/aoudiamoncef/ubuntu-sshd)
[![Maintenance](https://img.shields.io/badge/Maintained-Yes-green.svg)](https://github.com/aoudiamoncef/ubuntu-sshd)

這個 Docker 映像提供 Ubuntu 24.04 基礎環境並啟用了 SSH 伺服器。
它允許你輕鬆建立可透過 SSH 金鑰或預設使用者名稱與密碼登入的容器。

## 使用方式

### 複製（Clone）此專案

首先複製包含 Dockerfile 和相關腳本的 GitHub [專案](https://github.com/aoudiamoncef/ubuntu-sshd)：

```bash
git clone https://github.com/caloutw/ubuntu-sshd
cd ubuntu-sshd
```

### 建置 Docker 映像

在複製下來的資料夾中執行以下指令來建置 Docker 映像：

```bash
docker build -t my-ubuntu-sshd:latest .
```

### 啟動容器

使用以下指令啟動基於此映像的容器：

```bash
docker run -d \
  -p 主機埠號:22 \
  -e SSH_USERNAME=myuser \
  -e SSH_PASSWORD=mysecretpassword \
  -e SUDO_PASSWORD=mysecretpassword \
  -e AUTHORIZED_KEYS="$(cat path/to/authorized_keys_file)" \
  -e SSHD_CONFIG_ADDITIONAL="你的額外設定" \
  -e SSHD_CONFIG_FILE="/path/to/your/sshd_config_file" \
  my-ubuntu-sshd:latest
```

* `-d`：以背景模式（detach）執行容器。
* `-p 主機埠號:22`：將主機的指定埠號對應到容器的 22 埠（SSH 預設埠）。請將 `主機埠號` 替換成你想使用的埠號。
* `-e SSH_USERNAME=myuser`：設定容器內的 SSH 使用者名稱，將 `myuser` 換成你想用的帳號。
* `-e SSH_PASSWORD=mysecretpassword`：設定該使用者的密碼。**此環境變數為必填**，將 `mysecretpassword` 替換為你的密碼。
* `-e SUDO_PASSWORD=mysecretpassword`：設定ROOT的密碼。**此環境變數為必填**，將 `mysecretpassword` 替換為你的密碼。
* `-e AUTHORIZED_KEYS="$(cat path/to/authorized_keys_file)"`：設定授權的 SSH 公鑰，將 `path/to/authorized_keys_file` 替換成你的 authorized\_keys 檔案路徑。
* `-e SSHD_CONFIG_ADDITIONAL="你的額外設定"`：允許你傳入額外的 SSHD 設定內容，替換成你需要的設定字串。
* `-e SSHD_CONFIG_FILE="/path/to/your/sshd_config_file"`：指定包含額外 SSHD 設定的檔案路徑。
* `my-ubuntu-sshd:latest`：替換成你建置的 Docker 映像名稱和標籤。

### 透過 SSH 連線

容器啟動後，可用以下指令 SSH 連線：

```bash
ssh -p 主機埠號 myuser@localhost
```

* `主機埠號` 要和你執行容器時設定的埠號一致。
* 使用設定的密碼或 SSH 金鑰進行驗證，視你的設定而定。

### 注意事項

* 若啟動時 `AUTHORIZED_KEYS` 環境變數為空，容器仍會啟動 SSH 伺服器，但不會配置任何授權金鑰。此時你需要自行掛載 authorized\_keys 檔案或在容器內手動設定。
* 當提供 `AUTHORIZED_KEYS` 時，為提升安全性，密碼驗證將會被停用。

## 授權條款

本 Docker 映像依據 [MIT 授權條款](LICENSE) 提供。
