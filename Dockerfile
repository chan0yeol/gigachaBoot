FROM amazoncorretto:17
EXPOSE 9797
COPY target/*.jar gigacha.jar
ENTRYPOINT ["java","-jar","gigacha.jar"]