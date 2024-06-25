FROM debian:bookworm-20240423
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install \
    git default-jdk-headless ant \
    libcommons-lang3-java libbcprov-java ivy

WORKDIR /work-area
RUN git clone https://gitlab.com/pdftk-java/pdftk.git
RUN cd pdftk && mkdir lib && \
    ln -st lib /usr/share/java/commons-lang3.jar /usr/share/java/bcprov.jar
RUN cd pdftk && ant jar

RUN echo "alias pdftk='java -cp /work-area/pdftk/build/jar/pdftk.jar:lib/bcprov.jar:lib/commons-lang3.jar com.gitlab.pdftk_java.pdftk'" >> /etc/bash.bashrc

# djvups input.djvu | ps2pdf - output.pdf
RUN apt-get -y install djvulibre-bin ghostscript
