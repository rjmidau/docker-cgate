FROM openjdk:15-alpine

ARG APP_PATH=/cgate

ENV USER=cgate
ENV UID=24283
ENV GID=24283

EXPOSE 20023
EXPOSE 20024
EXPOSE 20025
EXPOSE 20026
EXPOSE 20123
EXPOSE 20124
EXPOSE 20125
EXPOSE 20126

# https://updates.clipsal.com/ClipsalSoftwareDownload/mainsite/cis/technical/downloads/c-gate.html
# Unzip, and re-archive as tar.xz
ADD cgate-2.11.4_3251.tar.xz /

# Create non-privilged group/user, and make working directories writable for it
RUN addgroup --gid "$GID" "$USER" && \
    adduser --disabled-password --no-create-home --gecos "" --home "$APP_PATH" --ingroup "$USER" --uid "$UID" "$USER" && \
    mkdir -p "$APP_PATH/config" "$APP_PATH/logs" "$APP_PATH/tag" && \
    chown "$UID":"$GID" "$APP_PATH/config" "$APP_PATH/logs" "$APP_PATH/tag"

# Volumes have to be declared after chown otherwise they end up root:root
VOLUME $APP_PATH/config
VOLUME $APP_PATH/logs
VOLUME $APP_PATH/tag

# Drop to non-privilged user
USER $USER
WORKDIR $APP_PATH

CMD ["java", "-jar", "cgate.jar"]
