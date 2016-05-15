FROM java:openjdk-8u72-jdk


#RUN rpm --import http://repos.azulsystems.com/RPM-GPG-KEY-azulsystems
#UN curl -s -o /etc/yum.repos.d/zulu.repo http://repos.azulsystems.com/rhel/zulu.repo
#RUN yum -y update
#RUN yum -y install zulu-8-8.13.0.5-1
#RUN curl -s -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x /usr/bin/jq

#ENV JAVA_HOME /usr/lib/jvm/zulu-8

ADD ./build/distributions /opt/portal-de-servicos
WORKDIR /opt/portal-de-servicos

#RUN curl -L -u ${SNAP_API_KEY} https://api.snap-ci.com/project/servicosgovbr/portal-de-servicos/branch/master/pipelines/${SNAP_PIPELINE_COUNTER} | jq '.stages[].workers[].artifacts[].download_url' | grep rpm | x
#args curl -o portal-de-servicos-latest.rpm -L -u ${SNAP_API_KEY} && yum install -y portal-de-servicos-latest.rpm



RUN tar xvf portal-de-servicos-1.0.0.tar

WORKDIR /opt/portal-de-servicos/portal-de-servicos-1.0.0/bin

EXPOSE 8080
CMD ./portal-de-servicos
