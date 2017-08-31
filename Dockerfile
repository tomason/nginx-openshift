FROM fedora:latest

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

USER 1000

CMD ["nginx", "-c", "/nginx/nginx.conf" ]
