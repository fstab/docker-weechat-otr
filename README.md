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
   docker build -t="fstab/weechat-otr:v1" .
   ```

5. Run a docker container with that image

   ```bash
   docker run -t -i fstab/weechat-otr:v1

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


  * You need to configure your nick each time you start the container

    ```
    /set irc.server.freenode.nicks alice
    ```
  * [WeeChat](https://weechat.org) generates new [OTR](http://en.wikipedia.org/wiki/Off-the-Record_Messaging) keys and fingerprints each time it starts.
  * All conversation logs are gone once [WeeChat](https://weechat.org) quits.

If you start using [WeeChat](https://weechat.org) regularly, you want to store data permanently. In order to do that, you need to create a directory on your host computer and map that directory to `/home/otr/.weechat` in the [Docker](http://docker.io) container:

    mkdir ~/.weechat
    chmod 700 ~/.weechat
    docker run -v ~/.weechat:/home/otr/.weechat -t -i fstab/weechat-otr:v1

That way, all [WeeChat](https://weechat.org) data is stored in `~/.weechat` on the host system, and can be re-used in the next docker run.

Why OTR?
--------

Spiegel Online has an [interesting article](http://spon.de/aeo0j) on how intelligence agencies crack encrypted Internet communication. As the linked documents from the Snowden archives suggest, the NSA seems to have major problems with decrypting OTR messages.
