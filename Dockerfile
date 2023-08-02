FROM debian:stable-slim

# Install dropbear
RUN apt-get update && apt-get install -y dropbear

# Add ssh-site
COPY target/x86_64-unknown-linux-gnu/release/ssh-site /srv/ssh-site
RUN echo "/srv/ssh-site" >> /etc/shells

# Add user
run groupadd -g 1009 meow
RUN adduser -q --no-create-home --gecos "" --gid 1009 --shell /srv/ssh-site meow
RUN echo "meow:meow" | chpasswd

# Run dropbear
# -F = don't go into bg
# -E = don't use syslog
# -m = disable motd
# -w = disallow root login
# -j -k = disable port forwarding
# -G 1009 = only allow logins in group meow
CMD /usr/sbin/dropbear -b /srv/banner.txt -F -E -m -w -j -k -G meow
