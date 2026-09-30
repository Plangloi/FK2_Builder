FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ["UCP Panel Builder.dc.html", "support.js", "image-slot.js", "/usr/share/nginx/html/"]
COPY _ds /usr/share/nginx/html/_ds

EXPOSE 80
