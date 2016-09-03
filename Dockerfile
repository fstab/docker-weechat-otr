FROM ubuntu:16.04
MAINTAINER Fabian Stäber, fabian@fstab.de

ENV LAST_UPDATE=2016-09-03

RUN apt-get update && \
    apt-get upgrade -y

# Set the timezone
RUN echo "Europe/Berlin" | tee /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Set the locale for UTF-8 support
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && \
    locale-gen && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install \
    python-potr \
    weechat \
    weechat-scripts

RUN adduser --disabled-login --gecos '' guest
USER guest
WORKDIR /home/guest

RUN \
    # enable otr \
    \
    echo /python load /usr/share/weechat/python/otr.py >> config.txt && \
    echo /set weechat.bar.status.items "\"[time],[buffer_last_number],[buffer_plugin],[otr],buffer_number+:+buffer_name+(buffer_modes)+{buffer_nicklist_count}+buffer_zoom+buffer_filter,[lag],[hotlist],completion,scroll\"" >> config.txt && \
    \
    # Connect with SSL \
    \
    echo /server add freenode chat.freenode.net >> config.txt && \
    echo /set irc.server.freenode.addresses \"chat.freenode.net/7000\" >> config.txt && \
    echo /set irc.server.freenode.ssl on >> config.txt && \
    echo

# Use config.txt only if no weechat configuration exists.
# If there is already a configuration in /home/guest/.weechat, ignore config.txt

ENTRYPOINT bash -c 'if [ -f "/home/guest/.weechat/irc.conf" ] ; then weechat ; else weechat -r "`cat config.txt | tr \"\\n\" \"\;\"`" ; fi'
