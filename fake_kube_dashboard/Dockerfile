# Use ultra-lightweight base
FROM nginx:alpine

# Set working directory to NGINX's root dir
WORKDIR /usr/share/nginx/html

# Remove default NGINX index page
RUN rm -rf ./*

# Copy only what you need
COPY index.html .

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]