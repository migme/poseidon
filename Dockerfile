FROM ruby:2.3
RUN apt-get update -qq && apt-get install -y --fix-missing wget libpq-dev lsof

# Install Kafka
# http://kafka.apache.org/082/documentation.html#quickstart
# Download https://www.apache.org/dyn/closer.cgi?path=/kafka/0.8.2.0/kafka_2.10-0.8.2.0.tgz
RUN wget http://apache.stu.edu.tw/kafka/0.8.2.0/kafka_2.10-0.8.2.0.tgz
# COPY ./kafka_2.10-0.8.2.0.tgz /
RUN ls
RUN tar -xzf kafka_2.10-0.8.2.0.tgz

# Install Java
# https://www.digitalocean.com/community/tutorials/how-to-manually-install-oracle-java-on-a-debian-or-ubuntu-vps
RUN wget  wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.tar.gz
# COPY ./jdk-8u5-linux-x64.tar.gz /
RUN mkdir /opt/jdk
RUN tar -zxf jdk-8u5-linux-x64.tar.gz -C /opt/jdk
RUN update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_05/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_05/bin/javac 100
RUN update-alternatives --display java
RUN update-alternatives --display javac
RUN java -version

# Copy Poseidon
RUN mkdir /poseidon
WORKDIR /poseidon
ADD . /poseidon/
RUN bundle check || bundle install

# Setup kafka path for test
ENV KAFKA_PATH /kafka_2.10-0.8.2.0
