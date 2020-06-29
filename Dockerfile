FROM node:12 AS builder
WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .
# RUN cd client && rm yarn.lock && npm install && npm run build && cd ..
RUN rm yarn.lock
RUN npm install
RUN npm run build


FROM node:12 AS production
RUN npm install -g serve
WORKDIR /app
# COPY --from=builder ./app/client/build ./client/build
COPY --from=builder ./app/build .

EXPOSE 3000

CMD ["serve", "-s", ".", "-p", "3000"]