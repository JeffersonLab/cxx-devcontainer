FROM ubuntu:jammy

RUN cd /tmp \
    && apt update \
    && apt install -y curl git vim g++ build-essential doxygen graphviz zip unzip tini \
    && apt clean \
    && curl -o /usr/local/share/ca-certificates/customcert.crt http://pki.jlab.org/JLabCA.crt \
    && update-ca-certificates \
    && curl -O https://raw.githubusercontent.com/devcontainers/features/main/src/docker-outside-of-docker/install.sh \
    && chmod +x /tmp/install.sh \
    && /tmp/install.sh \
    && curl -LO https://github.com/Kitware/CMake/releases/download/v3.29.2/cmake-3.29.2-linux-x86_64.tar.gz \
    && tar -xvzf cmake-3.29.2-linux-x86_64.tar.gz -C /opt \
    && cd /opt \
    && git clone https://github.com/microsoft/vcpkg.git \
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh

ENV VCPKG_ROOT=/opt/vcpkg
ENV CMAKE_ROOT=/opt/cmake-3.29.2-linux-x86_64
ENV PATH=$PATH:$VCPKG_ROOT:$CMAKE_ROOT/bin
ENV TZ=America/New_York
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["sleep", "infinity"]