# Runtime stage
FROM thies88/1-base-ubuntu:focal

ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Thies88"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y --no-install-recommends \
	nginx-light \
	nginx-common && \
echo "**** cleanup ****" && \
apt-get autoremove -y --purge && \
# Clean more temp/junk files
apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/cache/apt/* \
	/var/tmp/* \
	/var/log/* \
	/usr/share/doc/* \
	/usr/share/info/* \
	/var/cache/debconf/* \
	/usr/share/man/* \ 
	# clean nginx, we replace tese later on
	/etc/nginx/sites-available/default \
	/etc/nginx/nginx.conf
	
# add local files
COPY root/ /

ENTRYPOINT ["/init"]
