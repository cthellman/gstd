FROM ubuntu:groovy
RUN apt update && apt install -y net-tools iproute2 iputils-ping gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly


# GSTD
RUN apt install -y automake libtool pkg-config libgstreamer1.0-dev  libgstreamer-plugins-base1.0-dev libglib2.0-dev libjson-glib-dev gtk-doc-tools libreadline-dev libncursesw5-dev libdaemon-dev libjansson-dev libsoup2.4-dev python3-pip git sudo

# 319 and 320 are PTP
# 5001 - GSTD
EXPOSE 5001 319 320 

# Fetch the code
# RUN git clone https://github.com/RidgeRun/gstd-1.x.git
RUN git clone https://github.com/cthellman/gstd.git

# Build and install 
WORKDIR /gstd
RUN sh ./autogen.sh
RUN ./configure
RUN make
RUN sudo make install

CMD ["gstd", "--enable-http-protocol", "--http-address=0.0.0.0"]