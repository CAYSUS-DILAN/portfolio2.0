# Use the official Nginx image as the base image
FROM nginx:alpine

# Copy the website files to the Nginx HTML directory
COPY . /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
