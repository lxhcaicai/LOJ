FROM openjdk:8

COPY *.jar /app.jar

COPY check_nacos.sh /check_nacos.sh

COPY run.sh /run.sh

ENV TZ=Asia/Shanghai

ENV JUDGER_SERVER_PORT=5588

VOLUME ["/judge/test_case","/judge/run"]

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["bash","/check_nacos.sh"]

EXPOSE $JUDGER_SERVER_PORT