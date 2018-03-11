FROM python:alpine

# Update OS Packages
RUN apk update && \
    apk upgrade && \
    apk add build-base postgresql postgresql-dev

# Install python packages
WORKDIR /tmp
ADD ./member_web/requirements.in .
RUN pip install pip-tools
RUN pip-compile
RUN pip uninstall pip-tools -y
RUN pip install -r requirements.txt --no-cache-dir
RUN rm /tmp/*

WORKDIR /app
ADD ./member_web/ .

EXPOSE 8000

CMD ["./docker-entrypoint.sh"]
