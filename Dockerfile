FROM eclipse-temurin:11-jdk-focal
RUN apt-get update && \
    apt-get install -y unzip curl && \
    adduser --uid 1001 --home /home/sunbird --disabled-password sunbird && \
    mkdir -p /home/sunbird && \
    chown -R sunbird:sunbird /home/sunbird

USER sunbird
COPY ./controller/target/userorg-service-1.0-SNAPSHOT-dist.zip /home/sunbird/
RUN unzip /home/sunbird/userorg-service-1.0-SNAPSHOT-dist.zip -d /home/sunbird/

WORKDIR /home/sunbird/
CMD java -XX:+PrintFlagsFinal $JAVA_OPTIONS -Dplay.server.http.idleTimeout=180s -Dlog4j2.formatMsgNoLookups=true -cp '/home/sunbird/userorg-service-1.0-SNAPSHOT/lib/*' play.core.server.ProdServerStart /home/sunbird/userorg-service-1.0-SNAPSHOT
