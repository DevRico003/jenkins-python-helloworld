FROM jenkins/jenkins:lts

USER root

# Installieren von notwendigen Paketen inklusive sudo
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common sudo python3 python3-pip

# Docker GPG Key und Repository hinzufügen
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Docker und Docker Compose installieren
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Jenkins-Benutzer zur Docker-Gruppe hinzufügen
RUN usermod -aG docker jenkins

# Setzen von Sudo ohne Passwort für den Jenkins-Benutzer
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins

EXPOSE 8080