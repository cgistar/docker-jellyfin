# syntax=docker/dockerfile:1
FROM clion007/alpine

ENV BRANCH="edge"

# install packages
RUN set -eux; \
  #install build packages
  apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/main \
    # --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/testing \
    --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/community \
  su-exec \
  jellyfin \
  jellyfin-web \
  # jellyfin-ffmpeg \
  mesa-va-gallium \
  # libva-intel-driver \
  font-noto-cjk-extra; \

  # set jellyfin process user and group
  chown jellyfin:jellyfin /usr/bin/jellyfin; \
  
  # Make dir for config and data
  mkdir -p /config; \
  chown jellyfin:jellyfin /config;

# add local files
COPY --chmod=755 root/ /

# ports
EXPOSE 8096 8920

CMD ["--configdir=/config", \
"--logdir=/config/log", \
"--datadir=/config/data", \
"--cachedir=/config/cache", \
"--webdir=/usr/share/webapps/jellyfin-web"]
