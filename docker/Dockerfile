FROM apache/spark:4.0.0-python3
USER root
WORKDIR /app
RUN pip3 install --upgrade pip "setuptools>=61" wheel
COPY docker/requirements.txt ./
RUN mkdir -p /app/artifacts && chmod 777 /app/artifacts
RUN pip3 install --no-cache-dir -r requirements.txt
COPY pyproject.toml .
COPY src/ ./src/
RUN pip3 install . --no-build-isolation

# Iceberg + AWS S3 (for MinIO) JARs
RUN curl -fL -o /opt/spark/jars/iceberg-spark-runtime-4.0_2.13-1.10.1.jar \
    https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-4.0_2.13/1.10.1/iceberg-spark-runtime-4.0_2.13-1.10.1.jar && \
    curl -fL -o /opt/spark/jars/iceberg-aws-bundle-1.10.1.jar \
    https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/1.10.1/iceberg-aws-bundle-1.10.1.jar

RUN apt-get update
