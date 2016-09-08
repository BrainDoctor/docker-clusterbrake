FROM mcpayment/ubuntu-java8

ENV CB_DIR "/opt/clusterbrake"
ENV CB_DEFAULT_DIR "/opt/clusterbrake.defaults"
ENV CB_CONFIG "/etc/clusterbrake/clusterbrake.properties"
ENV CB_CONFIG_DIR "/config"
ENV CB_VERSION "1.0.3"

WORKDIR ${CB_DIR}

RUN wget https://github.com/BrainDoctor/clusterbrake/releases/download/${CB_VERSION}/clusterbrake-${CB_VERSION}-release.tar.gz \
	&& tar -zxf clusterbrake-${CB_VERSION}-release.tar.gz \
	&& rm clusterbrake-${CB_VERSION}-release.tar.gz \
	&& rm clusterbrake.properties; \
	chmod -R -x * \
	&& add-apt-repository ppa:stebbins/handbrake-releases \
	&& apt-get update \
	&& apt-get install -y handbrake-cli \
	&& apt-get clean

ADD clusterbrake.properties ${CB_CONFIG}
ADD common*.properties ${CB_DEFAULT_DIR}/
ADD templates/* ${CB_DEFAULT_DIR}/templates/hd.x265.conf
ADD start.sh /start.sh

ENTRYPOINT ["/start.sh"]
