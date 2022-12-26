#!/bin/bash
set -euo pipefail

mkdir tempdirectorystra
mkdir tempdirectorystra/templates
mkdir tempdirectorystra/static

cp sample_app.py tempdirectorystra/.
cp -r templates/* tempdirectorystra/templates/.
cp -r static/* tempdirectorystra/static/.

cat > tempdirectorystra/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdirectorystra || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
