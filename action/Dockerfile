ARG IMAGE
FROM $IMAGE
ADD steps /steps
ADD entrypoint.sh /entrypoint.sh
RUN chmod -R +x /steps /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
