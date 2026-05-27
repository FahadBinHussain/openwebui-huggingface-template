FROM ghcr.io/open-webui/open-webui:main

WORKDIR /app

COPY scripts/start-openwebui.sh /app/wrapper/start-openwebui.sh

RUN chmod +x /app/wrapper/start-openwebui.sh

ENV HOST=0.0.0.0 \
    PORT=7860 \
    DATA_DIR=/data/open-webui

EXPOSE 7860

ENTRYPOINT []
CMD ["/app/wrapper/start-openwebui.sh"]
