FROM nginx

## Step 1:
# Copy source code to working directory
COPY ./Application_Code /usr/share/nginx/html

## Step 2:
# Expose port 80
EXPOSE 80

## Step 3:
# Run app code at container launch
CMD ["nginx", "-g", "daemon off;"]