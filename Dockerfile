FROM amazoncorretto:17
EXPOSE 9797
COPY target/*.war gigacha.war
ENTRYPOINT ["java","-jar","gigacha.war"]