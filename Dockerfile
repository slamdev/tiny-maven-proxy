FROM openjdk:8-jre-alpine

WORKDIR /opt

RUN apk add --no-cache curl \
 && wget https://timboudreau.com/builds/job/tiny-maven-proxy/lastSuccessfulBuild/artifact/tiny-maven-proxy/target/tiny-maven-proxy.jar

EXPOSE 5956

VOLUME /var/lib/maven

HEALTHCHECK \
 CMD curl --fail http://localhost:5956 || exit 1

ENTRYPOINT ["java",\
            "-Djava.security.egd=file:/dev/./urandom",\
            "-Dhttp.nonProxyHosts=localhost",\
            "-XX:+UnlockExperimentalVMOptions",\
            "-XX:+UseCGroupMemoryLimitForHeap",\
            "-XX:MaxRAMFraction=1",\
            "-jar",\
            "tiny-maven-proxy.jar",\
            "--maven.dir", "/var/lib/maven",\
            "--mirror", "https://jcenter.bintray.com,https://repo1.maven.org/maven2,https://plugins.gradle.org/m2"\
]
