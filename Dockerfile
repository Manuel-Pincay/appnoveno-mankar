# Usar una imagen de Node.js más reciente como base
FROM node:18-alpine as build-step

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build --prod


FROM nginx:1.17.1-alpine 

COPY --from=build-step /app/dist/frontend-mankar-angular /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
