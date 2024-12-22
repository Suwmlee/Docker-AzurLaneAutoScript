FROM python:3.7-slim

ENV TZ=Asia/Shanghai
ENV PYROOT=/app/pyroot
ENV ALAS_URL=https://github.com/LmeSzinc/AzurLaneAutoScript
ENV FIX_MXNET=0
EXPOSE 22267

# Install dependencies
RUN apt-get update && \
    apt-get install -y git adb libgomp1 wget

# update TZ
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

WORKDIR /app

RUN git clone $ALAS_URL /app/AzurLaneAutoScript && \
    cp /app/AzurLaneAutoScript/deploy/docker/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

RUN cd /app/AzurLaneAutoScript/config/ && \
    cp -f deploy.template-docker.yaml deploy.yaml && \
    mkdir /app/config && \
    cp /app/AzurLaneAutoScript/config/* /app/config/

# clean
RUN rm -rf /tmp/* && \
    rm -r ~/.cache/pip

# Install latest adb
RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip platform-tools-latest-linux.zip && \
    rm platform-tools-latest-linux.zip && \
    ln -s /platform-tools/adb /usr/bin/adb

VOLUME /app/AzurLaneAutoScript/config

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

CMD [ "/app/entrypoint.sh" ]
