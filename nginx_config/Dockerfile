FROM nginx:stable

# Create log directory inside container
RUN mkdir -p /var/log/nginx/logs

# Copy your config files and script into the image
COPY nginx.conf /etc/nginx/nginx.conf
COPY self.crt /etc/nginx/self.crt
COPY self.key /etc/nginx/self.key
COPY falco_sidekick.sh /usr/local/bin/falco_sidekick.sh
RUN mkdir -p /var/log/nginx/audit && \
    touch /var/log/nginx/audit/falco_sidekick.log && \
    chown -R www-data:www-data /var/log/nginx/audit

# Make script executable
RUN chmod +x /usr/local/bin/falco_sidekick.sh

# Expose HTTPS port
EXPOSE 8443

# Run both Nginx and your sidekick script using a shell
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;' & /usr/local/bin/falco_sidekick.sh"]
# CMD ["nginx", "-g", "daemon off;"]
