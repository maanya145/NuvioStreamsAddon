FROM node:18-alpine

# Install proxychains-ng and curl (for debugging)
RUN apk add --no-cache proxychains-ng curl

WORKDIR /app

# Copy and install dependencies
COPY package*.json ./
RUN npm install --production

COPY . .

# Set proxychains config with your proxy
RUN echo "strict_chain\n\
proxy_dns\n\
[ProxyList]\n\
https blade1.bucharest-rack489.nodes.gen4.ninja 9002\n" > /etc/proxychains.conf

# Use proxychains to start the app
CMD ["proxychains4", "npm", "start"]
