FROM debian:9.5-slim


# Update
RUN apt-get update


# Install packages
RUN apt-get -yq install rsync openssh-client sshpass


# Label
LABEL "com.github.actions.name"="rsync deployments"
LABEL "com.github.actions.description"="For deploying code to a webserver via rsync over ssh"


LABEL "repository"="http://github.com/firstandthird/rsync-deployments"
LABEL "homepage"="https://github.com/firstandthird/rsync-deployments"
LABEL "maintainer"="First+Third <team@firstandthird.com>"


# Copy entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]