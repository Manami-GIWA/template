# 基本的なDockerfileです
# これを使えばとりあえず動く
# 初めて使うとき
# docker build -t dockertest .
# 普段使うとき
# docker run --mount type=bind,src=$PWD,dst=$PWD --workdir $PWD -it --ipc host --rm -p 8888:8888 -p 5910:5900 --name `whoami`_dockertest dockertest /bin/bash
# nohup jupyter lab --port 8888 --ip=0.0.0.0 --allow-root >> jupyter.log &
# cat jupyter.log

# Python 3.10イメージをベースに使用
FROM python:3.10

# 作業ディレクトリを/rootに設定
WORKDIR /root

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# JupyterLabのインストール
RUN pip install --no-cache-dir jupyterlab

# JupyterLabを起動するためのポート8888を開放
EXPOSE 8888

# JupyterLab起動用のコマンド
CMD ["jupyter", "lab", "--port=8888", "--ip=0.0.0.0", "--allow-root", "--ServerApp.token=''"]
