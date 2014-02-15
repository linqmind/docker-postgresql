#PostgreSQL Server
#version 1.0

#use the centos base image provided by dotCloud
FROM centos

MAINTAINER hipin.zhao, zhaohaibin@outlook.com

#make sure the package repository is up to date.
RUN yum update -y

#install wget
RUN yum install wget telnet git -y

#install epel
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && yum install epel-release-*.rpm -y

#make sure the package repository is up to date.
RUN yum update -y

#install postgresql-server postgresql-client
RUN wget http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm && yum install pgdg-redhat93-9.3-1.noarch.rpm -y
RUN yum install postgresql93-server postgresql93 postgresql93-devel -y

#add postgresql config file
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

#add start postgresql script
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

#special a volumn for data persistent
VOLUME ["/var/lib/postgresql"]

#specify port for postgresql service
EXPOSE 5432

#exec run shell script
CMD ["/usr/local/bin/run"]

