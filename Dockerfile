FROM alpine:3.5

LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i

RUN apk add --no-cache \
      nginx \
      nginx-mod-stream && \
    mkdir -m 0770 -p \
      /nginx/http.conf.d \
      /nginx/stream.conf.d \
      /nginx/html \
      /nginx/tmp \
      /nginx/logs && \
    ln -sf /dev/stdout /nginx/logs/access.log && \
    ln -sf /dev/stdout /nginx/logs/error.log && \
    ln -sf /usr/lib/nginx/modules /nginx/modules
    
COPY nginx.conf /nginx/nginx.conf
COPY s2i /usr/local/s2i

RUN chmod -R 0755 /usr/local/s2i

USER 1000

CMD ["nginx", "-p", "/nginx", "-c", "/nginx/nginx.conf" ]
