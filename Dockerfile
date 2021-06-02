# building node image to generate build folder
FROM node:12-alpine as build

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# building NGINX image to serve static files
FROM nginx:1.21.0-alpine
EXPOSE 80
# from--build here refers to the tag we provided while building node image
# that is, node:12-alipine as "build"
COPY --from=build /app/build /usr/share/nginx/html