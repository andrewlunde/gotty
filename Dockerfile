FROM golang:1.16

WORKDIR /gotty
COPY . /gotty
RUN CGO_ENABLED=0 make

FROM alpine:latest

RUN apk update && \
    apk upgrade && \
    apk --no-cache add ca-certificates && \
    apk add bash && \
    apk add screen && \
    apk add curl lsof jq vim && \
    apk add htop 

# RUN echo 'echo "gotty"' > /etc/hostname

RUN echo 'echo ""' > /root/.bashrc && \
    echo 'echo "Nothing is started in the background."' >> /root/.bashrc && \
    echo 'echo "Run htop command to display system info."' >> /root/.bashrc && \
    echo 'echo "Other commands: jq, vim, lsof"' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc  && \
#    echo "export PS1='\h:\w\$ '" >> /root/.bashrc
    echo "export PS1='gotty:\w\$ '" >> /root/.bashrc

WORKDIR /root
COPY --from=0 /gotty/gotty /usr/bin/
# CMD ["gotty",  "-w", "bash"]
ADD ./docker_entrypoint.sh /usr/bin/docker_entrypoint.sh
RUN chmod a+x /usr/bin/docker_entrypoint.sh

# Run docker_entrypoint.sh
ENTRYPOINT ["/usr/bin/docker_entrypoint.sh"]