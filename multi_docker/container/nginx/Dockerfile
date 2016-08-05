FROM nginx:1.7.5

EXPOSE 80

#COPY build/nginx.conf /etc/nginx/nginx.conf


RUN mkdir nginx
ADD build/start_server /nginx
RUN chmod +x /nginx/start_server

