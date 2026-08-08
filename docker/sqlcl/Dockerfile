FROM eclipse-temurin:21-jre

USER root

RUN apt-get update \
    && apt-get install -y curl unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN curl -L \
    https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip \
    -o /tmp/sqlcl.zip \
    && unzip /tmp/sqlcl.zip -d /opt \
    && rm /tmp/sqlcl.zip

ENV PATH="/opt/sqlcl/bin:${PATH}"

WORKDIR /workspace

ENTRYPOINT ["sql"]
