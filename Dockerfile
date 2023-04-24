FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

# Use the above created unprivileged user
USER 10014

EXPOSE 3000

CMD [ "node", "index.js" ]