FROM node:10

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY index.js ./

EXPOSE 8080

CMD [ "nodejs", "index.js" ]
