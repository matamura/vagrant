FROM centos:latest
MAINTAINER Machiko Tamura <tamura.m@5sg.jp>

## システムの更新
RUN yum -y update
RUN yum remove -y vim-minimal

RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";

env LANG=ja_JP.UTF-8




# 一般的な開発ライブラリの構築
RUN yum install -y passwd wget hostname tar make gcc zlib-devel git sudo net-tools ntp vim-enhanced gcc-c++

# MySQL関連のライブラリ
RUN yum install -y libffi-devel.x86_64 readline-devel mysql mysql-devel

# SSH関連のライブラリ
RUN yum install -y openssl-devel openssh-server

# ImageMagick関連のライブラリ
RUN yum install -y ImageMagick ImageMagick-devel libmagickcore-dev libmagickwand-dev libxml2-devel libxslt-devel

# cronインストール
RUN yum install -y cronie


## システムの設定
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime

RUN echo "PATH=\$PATH:/usr/local/bin" >> /root/.bashrc
RUN echo "export PATH" >> /root/.bashrc

## SSHの設定
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''
RUN sed -ri 's/#RSAAuthentication/RSAAuthentication/g' /etc/ssh/sshd_config
RUN sed -ri 's/#PubkeyAuthentication/PubkeyAuthentication/g' /etc/ssh/sshd_config
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
RUN sed -ri 's/#ClientAliveInterval 0/ClientAliveInterval 15/g' /etc/ssh/sshd_config
RUN sed -ri 's/#ClientAliveCountMax 3/ClientAliveCountMax 3/g' /etc/ssh/sshd_config

RUN echo 'root:root'|chpasswd

## "webapp"ユーザの追加
RUN sed -ri 's/Defaults    requiretty/# Defaults    requiretty/g' /etc/sudoers

RUN useradd -m -s /bin/bash webapp

RUN mkdir /home/webapp/.ssh
RUN chmod 700 /home/webapp/.ssh
RUN chown webapp:webapp /home/webapp/.ssh

RUN echo 'webapp ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/webapp

RUN echo "LANG=en_US" >> /home/webapp/.bash_profile
RUN echo "export LANG" >> /home/webapp/.bash_profile


## Rubyのインストール
RUN cd /usr/local/src && \
  wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.1.tar.gz && \
  tar zxvf ruby-2.2.1.tar.gz && \
  cd ruby-2.2.1 && \
  ./configure --disable-install-doc && \
  make && \
  make install
RUN echo 'gem: --no-document' > /usr/local/etc/gemrc
RUN yum install -y patch
RUN gem update --system

## Bundlerのインストール
RUN gem install bundler

RUN mkdir /opt/tmp/
RUN mkdir /opt/tmp/sockets/
RUN mkdir /opt/tmp/pids/
RUN chown webapp:webapp /opt/tmp/sockets/
RUN chown webapp:webapp /opt/tmp/pids/

## SSH、Railsの起動
EXPOSE 22 3000

ADD build/start_server /usr/bin/
RUN chmod +x /usr/bin/start_server

ADD build/unicorn_restart /usr/bin/
RUN chmod +x /usr/bin/unicorn_restart

ADD build/unicorn_start /usr/bin/
RUN chmod +x /usr/bin/unicorn_start

RUN echo 'export TERM=vt100' >> ~/.bash_profile

# CMD ["/usr/bin/start_server"]

