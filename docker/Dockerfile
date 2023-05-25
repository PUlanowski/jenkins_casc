FROM jenkins/jenkins:alpine
ENV JENKINS_USER admin
ENV JENKINS_PASS admin
#skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false 
# Config file variable
COPY jenkins-configuration.yaml /var/jenkins_home/jenkins-configuration.yaml
ENV CASC_JENKINS_CONFIG /var/jenkins_home/jenkins-configuration.yaml
#install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/plugins.txt
COPY example.groovy /usr/local/example.groovy
#elevating to root to install apps
USER root
RUN apk add docker
RUN apk add py-pip
#user back to jenkins
USER jenkins