FROM jboss/base-jdk:8
MAINTAINER Carlos Escobar cuellar <carlosfescobar@hotmail.com>

# Install java 1.6
USER root
RUN yum -y install java-1.6.0-openjdk --nogpgcheck && \
    alternatives --set java /usr/lib/jvm/jre-1.6.0-openjdk.x86_64/bin/java

# Install JBOSS 4.2.3
RUN yum -y install wget
USER jboss
#RUN cd $home && wget http://sourceforge.net/projects/jboss/files/JBoss/JBoss-4.2.3.GA/jboss-4.2.3.GA.zip && unzip jboss-4.2.3.GA.zip && rm jboss-4.2.3.GA.zip
RUN cd $home && wget http://portal.senasofiaplus.edu.co/emprendimiento/jboss-4.2.2.GA.zip && unzip jboss-4.2.2.GA.zip && rm jboss-4.2.2.GA.zip
#RUN cd $home && wget http://sourceforge.net/projects/jboss/files/JBoss/JBoss-4.2.2.GA/jboss-4.2.2.GA.zip && unzip jboss-4.2.2.GA.zip && rm jboss-4.2.2.GA.zip

RUN chmod -R +x jboss-4.2.2.GA/bin/

# Enable remote debugging 
ENV JAVA_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000

# Expose the ports we're interested in
# Webserver is running on 8080 
# Adminserver is running on 9990
# Remote debug port can be accessed on 8000
EXPOSE 8080 9990 8000

# Configurations
ENV JBOSS_HOME=/opt/jboss/jboss-4.2.2.GA
ENV JAVA_HOME /usr/lib/jvm/jre-1.6.0-openjdk.x86_64


# Set the default command to run on boot
# CMD ["/opt/jboss/jboss-4.2.2.GA/bin/run.sh", "-b", "0.0.0.0"]
CMD ["/opt/jboss/jboss-4.2.2.GA/bin/run.sh", "-b", "0.0.0.0"]
