# Gets all the important stuff from httpd, version 2.4.
FROM httpd:2.4
# Copies all files from ./html/ (local) into /usr/local/apache2/htdocs/ (container).
COPY html/ /usr/local/apache2/htdocs/
# Exposes port 80 for HTTP access.
EXPOSE 80