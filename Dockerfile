FROM tomcat:7
MAINTAINER Arran Ubels a.ubels@base2services.com

ENV JENTRATA_HOME /opt/jentrata
ENV TOMCAT_HOME $CATALINA_HOME

ENV TOMCAT_USER_NAME corvus
ENV TOMCAT_USER_PASS corvus
ENV DB_USER_NAME corvus
ENV DB_USER_PASS corvus
ENV DB_HOST_NAME db

ENV VERSION msh-2.x-SNAPSHOT

COPY ./ContainerFiles/run.sh /opt/run.sh
# From https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
COPY ./ContainerFiles/wait-for-it.sh /opt/wait-for-it.sh

RUN mkdir -p /opt/jentrata && \
    wget https://jentrata.ci.cloudbees.com/job/jentrata-msh-master/lastBuild/artifact/Dist/target/jentrata-$VERSION-tomcat.tar.gz -O - | tar xz -C /opt/jentrata && \
    ln -s $JENTRATA_HOME/webapps/corvus $TOMCAT_HOME/webapps/jentrata && \
    chmod a+x /opt/wait-for-it.sh

CMD ["/bin/sh", "/opt/run.sh"]