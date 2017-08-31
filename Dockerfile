FROM fedora:latest

LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i

RUN dnf install -y nginx && \
    dnf clean all && \
    mkdir -m 0770 /nginx && \
    mkdir -m 0770 /nginx/conf.d && \
    mkdir -m 0770 /nginx/html && \
    mkdir -m 0770 /nginx/tmp && \
    mkdir -m 0770 /nginx/log && \
    ln -sf /dev/stdout /nginx/log/access.log && \
    ln -sf /dev/stdout /nginx/log/error.log
    
COPY nginx.conf /nginx/nginx.conf
COPY s2i /usr/local/s2i

RUN chmod -R 0755 /usr/local/s2i

USER 1000

CMD ["nginx", "-c", "/nginx/nginx.conf" ]
