# Step 1: Build the React app
FROM node:18 AS build
WORKDIR /app

# Copy complete project (ensures react-scripts is installed properly)
COPY . .

# Install ALL dependencies inside Docker
RUN npm install

# Build the React project
RUN npm run build


# Step 2: Serve build using nginx
FROM nginx:alpine

# Copy built static files
COPY --from=build /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
