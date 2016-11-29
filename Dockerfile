FROM centos:centos7

#pŕepare environment
RUN rpm --import http://repos.azulsystems.com/RPM-GPG-KEY-azulsystems && \
    curl -s -o /etc/yum.repos.d/zulu.repo http://repos.azulsystems.com/rhel/zulu.repo && \
    yum -y update && \
    yum -y install zulu-8-8.13.0.5-1 epel-release && \
    yum -y install nodejs  && \
    curl -s -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x /usr/bin/jq

# environment default env
ENV JAVA_HOME "/usr/lib/jvm/zulu-8"
ENV JAVA_OPTS: '-Dfile.encoding=UTF-8 -Xms256M -Xmx1G -Djava.awt.headless=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC'
ENV SPRING_THYMELEAF_CACHE 'true'
ENV FLAGS_GIT_PUSH 'true'
ENV ENDPOINTS_ENABLED 'false'
ENV ENDPOINTS_JOLOKIA_ENABLED 'false'
ENV ENDPOINTS_INFO_ENABLED 'true'
ENV ENDPOINTS_HEALTH_ENABLED 'true'
ENV ENDPOINTS_HEALTH_SENSITIVE 'false'

#build
ADD . build
WORKDIR build
RUN ./gradlew assembleMainDist && \
    cp -rf ./build/distributions/*.tar / && \
    mkdir /portal && \
    tar xvf /*.tar -C /editor --strip-components=1
    #rm -rf ./build
EXPOSE 8080
#run cmd
CMD /portal/bin/portal-de-servicos


