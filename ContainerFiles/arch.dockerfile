FROM quay.io/toolbx/arch-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="An example ContainerFile to demonstrate multiple image builds." \
      maintainer="patricklyc@berkeley.edu"

# Copy the setup scripts and package list
COPY ../scripts/arch-build.sh /
COPY ../scripts/distrobox-shims.sh /
COPY ../packages/arch.packages /

# Run the setup scripts
RUN chmod +x arch-build.sh distrobox-shims.sh && /arch-build.sh
RUN rm /arch-build.sh /distrobox-shims.sh /arch.packages

RUN mkdir -p /tmp/yay-build
COPY ../scripts/arch-build-nonroot.sh /tmp/yay-build/

RUN useradd -m -G wheel -s /bin/bash builder && passwd -d builder
RUN chown -R builder:builder /tmp/yay-build
RUN echo 'builder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER builder
WORKDIR /tmp/yay-build
RUN ./arch-build-nonroot.sh

USER root
RUN rm -rf /tmp/yay-build
RUN sed -i '$d' /etc/sudoers
