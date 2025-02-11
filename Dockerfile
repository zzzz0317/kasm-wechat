FROM ghcr.io/zzzz0317/kasm-core-ubuntu-noble-latest:main

USER root

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y sudo xfce4-terminal xdg-utils \
    && apt-get install -y libxcb-icccm4 libxcb-image0 libxcb-render-util0 libxcb-keysyms1 \
    && rm -rf /var/lib/apt/list/*
RUN echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV DONT_PROMPT_WSL_INSTALL "No_Prompt_please"
WORKDIR $HOME

COPY ./src/install_wechat.sh /tmp/install_wechat.sh
RUN bash -x /tmp/install_wechat.sh && rm /tmp/install_wechat.sh

COPY ./src/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh
RUN chmod 755 $STARTUPDIR/custom_startup.sh

# Update the desktop environment to be optimized for a single application
RUN cp $HOME/.config/xfce4/xfconf/single-application-xfce-perchannel-xml/* $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
RUN cp /usr/share/backgrounds/bg_kasm.png /usr/share/backgrounds/bg_default.png
RUN apt-get remove -y xfce4-panel

######### End Customizations ###########

RUN chown 1000:0 $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
