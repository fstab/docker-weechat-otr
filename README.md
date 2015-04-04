docker-weechat-otr
==================

Run the [WeeChat](https://weechat.org) IRC client with [Off-the-Record](http://en.wikipedia.org/wiki/Off-the-Record_Messaging) (OTR) encryption.

Run from Docker Hub
-------------------

A pre-built image is available on [Docker Hub](https://registry.hub.docker.com/u/fstab/weechat-otr) and can be run as follows:

    docker run -t -i fstab/weechat-otr

The container will start up with the [WeeChat](https://weechat.org) client.

Build from Source
-----------------

1. Make sure [Docker](https://www.docker.com) is installed.
3. Clone _docker-weechat-otr_ from [GitHub](https://github.com/fstab/docker-weechat-otr)

   ```bash
   git clone https://github.com/fstab/docker-weechat-otr.git
   ```
4. Build the docker image

   ```bash
   cd docker-weechat-otr
   docker build -t="fstab/weechat-otr" .
   ```

5. Run a docker container with that image

   ```bash
   docker run -t -i fstab/weechat-otr
   ```

Use OTR Encryption
------------------

Within [WeeChat](https://weechat.org), you can use [OTR](http://en.wikipedia.org/wiki/Off-the-Record_Messaging) encryption as follows:

1. Set the nick name, connect to freenode, and start a private conversation without encryption:
 
   ```
   /set irc.server.freenode.nicks alice
   /connect freenode
   /query bob hello
   ```

2. Within the private chat buffer, start the encrypted session

   ```
   /otr start
   ```
   It may take a few seconds until the encrypted conversation is established.

For more info, run `/help otr` in the server buffer to view the OTR help.

Storing Configuration Permanently
---------------------------------

The instructions above show an easy way to try out [WeeChat](https://weechat.org) and [OTR](http://en.wikipedia.org/wiki/Off-the-Record_Messaging) encryption.

However, if you use [WeeChat](https://weechat.org) regularly, you may soon find it annoying that all data in the [Docker](http://docker.io) container is lost as soon as [WeeChat](https://weechat.org) exits:


  * You need to configure your nick each time you start the container (`/set irc.server.freenode.nicks alice`)
  * [WeeChat](https://weechat.org) generates new [OTR](http://en.wikipedia.org/wiki/Off-the-Record_Messaging) keys and fingerprints each time it starts.
  * All conversation logs are gone once [WeeChat](https://weechat.org) quits.

If you start using [WeeChat](https://weechat.org) regularly, you want to store data permanently. In order to do that, you need to create a directory on your host computer and map that directory to `/home/otr/.weechat` in the [Docker](http://docker.io) container:

    mkdir ~/.weechat
    chmod 700 ~/.weechat
    docker run -v ~/.weechat:/home/otr/.weechat -t -i fstab/weechat-otr

That way, all [WeeChat](https://weechat.org) data is stored in `~/.weechat` on the host system, and can be re-used in the next docker run.

When the _weechat-otr_ docker container is run without the `~/.weechat` volume, it will configure some defaults automatically. When _weechat-otr_ is run for the first time with the `~/.weechat` volume, the initial configuration must be set up manually:

```
/set irc.server.freenode.addresses "chat.freenode.net/7000"
/set irc.server.freenode.ssl on
/set irc.server.freenode.ssl_dhkey_size 1024
/script install otr.py
/set weechat.bar.status.items "[time],[buffer_last_number],[buffer_plugin],[otr],buffer_number+:+buffer_name+(buffer_modes)+{buffer_nicklist_count}+buffer_zoom+buffer_filter,[lag],[hotlist],completion,scroll"
```

Then, of course, you need to set your nick:

```
/set irc.server.freenode.nicks alice
```

To run a command after connection to server, for example to authenticate with nickserv

```
/set irc.server.freenode.command "/msg nickserv identify xxxxxxx"
```

Why OTR?
--------

Spiegel Online has an [interesting article](http://spon.de/aeo0j) on how intelligence agencies crack encrypted Internet communication. As the linked documents from the Snowden archives suggest, the NSA seems to have major problems with decrypting OTR messages.
