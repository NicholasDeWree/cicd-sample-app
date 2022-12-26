#!/bin/bash
set -euo pipefail

mkdir tempdirectorystr
mkdir tempdirectorystr/templates
mkdir tempdirectorystr/static

cp sample_app.py tempdirectorystr/.
cp -r templates/* tempdirectorystr/templates/.
cp -r static/* tempdirectorystr/static/.

cat > tempdirectorystr/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdirectorystr || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
