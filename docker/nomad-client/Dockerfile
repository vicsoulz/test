FROM vicsoulz/nomad:latest

RUN mkdir -p /nomad/config && \
    mkdir -p /nomad/data/

COPY ./config /nomad/config/

RUN chown -R nomad:nomad /nomad

EXPOSE 4646
EXPOSE 4647
EXPOSE 4648

CMD ["agent", "-config", "/nomad/config/server.hcl"]