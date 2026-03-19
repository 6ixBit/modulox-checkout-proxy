FROM nginx:1.27-alpine

# Official nginx image auto-renders templates from /etc/nginx/templates
# into /etc/nginx/conf.d at startup using envsubst.
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

ENV PORT=8080
ENV UPSTREAM_URL=https://modulo-api.onrender.com
ENV UPSTREAM_HOST=modulo-api.onrender.com
