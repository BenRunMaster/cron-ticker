FROM node:19.2-alpine3.16 AS dependencies
# FROM  --platform=$BUILDPLATFORM node:19.2-alpine3.16 AS dependencies
#cd app
WORKDIR /app
#Destino /app
COPY package.json ./
#Instalar dependencias
RUN npm install


#Nueva etapa----------------------------------------------------------------
FROM node:19.2-alpine3.16 AS builder
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
#Destino /app
COPY . .
#Realizar testing
RUN npm run test


#Nueva etapa----------------------------------------------------------------
FROM node:19.2-alpine3.16 AS prod-dependencies
WORKDIR /app
#Unicamente dependencias de produccion
COPY package.json ./
RUN npm install --prod



#Nueva etapa ejecutar la app-------------------------------------------------
FROM node:19.2-alpine3.16 AS runner
WORKDIR /app
COPY --from=prod-dependencies /app/node_modules ./node_modules

#Destino /app
COPY app.js ./
COPY tasks/ ./tasks
#Comando run de la aplicacion
CMD [ "node", "app.js" ] 