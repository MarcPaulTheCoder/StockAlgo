FROM apache/spark:4.0.0-python3
USER root

WORKDIR /app
COPY requirements.txt ./
RUN mkdir -p /app/artifacts && chmod 777 /app/artifacts
RUN pip3 install --no-cache-dir -r requirements.txt
RUN apt-get update
