FROM condaforge/mambaforge:4.12.0-0

ENV PYROOT=/app/pyroot
ENV ALAS_URL=https://github.com/LmeSzinc/AzurLaneAutoScript
ENV FIX_MXNET=0
EXPOSE 22267

# Install dependencies
RUN apt update && \
    apt install -y netcat unzip

# Install latest adb (41)
RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip platform-tools-latest-linux.zip && \
    rm platform-tools-latest-linux.zip && \
    ln -s /platform-tools/adb /usr/bin/adb

WORKDIR /app

# Install the base conda environment
RUN mamba create --prefix $PYROOT python==3.7.6 -y

RUN git clone $ALAS_URL /app/AzurLaneAutoScript
RUN $PYROOT/bin/pip install -r /app/AzurLaneAutoScript/deploy/docker/requirements.txt
# Initial download of UIAutomator2 is really slow with appetizer mirror (outside of China), switch to github
RUN sed -i "s#path = mirror_download(url,#path = cache_download(url,#" $PYROOT/lib/python3.7/site-packages/uiautomator2/init.py

RUN cd /app/AzurLaneAutoScript/config/ && \
    cp -f deploy.template-docker.yaml deploy.yaml && \
    mkdir /app/config && \
    cp /app/AzurLaneAutoScript/config/* /app/config/

VOLUME /app/AzurLaneAutoScript/config

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

CMD [ "/app/entrypoint.sh" ]
