docker-weechat-otr
==================

Run the [weechat](https://weechat.org) IRC client with [Off-the-Record](http://en.wikipedia.org/wiki/Off-the-Record_Messaging) (OTR) encryption.

Build and Run
-------------

1. Make sure [Docker](https://www.docker.com) is installed.
3. Check out _docker-weechat-otr_ from [GitHub](https://github.com/fstab/docker-weechat-otr)

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
   ```

The container will start up with the [weechat](https://weechat.org) client.

Use OTR Encryption
------------------

Within [weechat](https://weechat.org), you can use [OTR](http://en.wikipedia.org/wiki/Off-the-Record_Messaging) encryption as follows:

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

3. For more info, view the OTR help in the server buffer

   ```
   /help otr
   ```
