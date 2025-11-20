# Use an official Tomcat image with Java 11
FROM tomcat:9.0.86-jdk17-temurin

# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from your target directory to the Tomcat webapps directory
# Make sure your pom.xml builds a WAR file named myjspapp.war
COPY target/myjspapp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# ENV JAVA_TOOL_OPTIONS="-Dcgroupv2.enabled=false"

# Start Tomcat
CMD ["catalina.sh", "run"]

