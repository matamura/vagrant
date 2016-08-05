FROM centos:latest
MAINTAINER Machiko Tamura <tamura.m@5sg.jp>

## system setting
RUN \cp -p /usr/share/zoneinfo/Japan /etc/localtime

## update system
RUN yum -y update
RUN yum -y install wget hostname

## add yum repository
RUN yum -y install epel-release
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

## install mysql
RUN wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
RUN rpm -Uvh mysql-community-release-el7-5.noarch.rpm
RUN yum -y --enablerepo=mysql56-community install mysql-server


EXPOSE 3306


RUN mkdir -p /opt/mysql
RUN chown mysql:mysql /opt/mysql

RUN mkdir -p /mysql

ADD files/my.cnf /etc/
ADD files/init.sh /mysql/init.sh
RUN chmod +x /mysql/init.sh

ADD files/start /mysql
RUN chmod +x /mysql/start

