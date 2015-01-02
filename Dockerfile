FROM ubuntu:14.10
MAINTAINER Fabian Stäber, fabian@fstab.de

RUN apt-get update && \
    apt-get upgrade -y

# Set the locale (I want to use German Umlauts)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# The weechat otr plugin works with the following versions:
#
#  - weechat 1.0.1
#  - python-potr 1.0.0
#  - weechat-otr 1.3.0
#
# These are the versions provided with ubuntu 14.10.
# If you change the base image to ubuntu 14.04, it will not work.

RUN apt-get -y install \
    python-potr \
    weechat \
    weechat-scripts

RUN adduser --disabled-login --gecos '' otr
USER otr
WORKDIR /home/otr

RUN \
    # Connect with SSL \
    \
    echo /set irc.server.freenode.addresses \"chat.freenode.net/7000\" >> config.txt && \
    echo /set irc.server.freenode.ssl on >> config.txt && \
    echo /set irc.server.freenode.ssl_dhkey_size 1024 >> config.txt && \
    \
    # enable otr \
    \
    echo /python load /usr/share/weechat/python/otr.py >> config.txt && \
    echo /set weechat.bar.status.items "\"[time],[buffer_last_number],[buffer_plugin],[otr],buffer_number+:+buffer_name+(buffer_modes)+{buffer_nicklist_count}+buffer_zoom+buffer_filter,[lag],[hotlist],completion,scroll\"" >> config.txt && \
    echo

ENTRYPOINT weechat -r "`cat config.txt | tr \"\\n\" \"\;\"`"
