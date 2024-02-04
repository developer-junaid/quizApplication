# FROM node:lts-alpine
# ADD . /app
# WORKDIR /app
# COPY package*.json ./
# RUN npm install

# COPY . .

# EXPOSE 80

# CMD ["npm", "start"]





FROM node:14 as builder
WORKDIR /app
COPY package*.json /app/

RUN npm install

COPY ./ /app/

RUN npm run build

# Serve stage
FROM nginx:alpine as production-stage

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
