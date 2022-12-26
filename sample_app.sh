#!/bin/bash
set -euo pipefail

mkdir tempdirectory
mkdir tempdirectory/templates
mkdir tempdirectory/static

cp sample_app.py tempdirectory/.
cp -r templates/* tempdirectory/templates/.
cp -r static/* tempdirectory/static/.

cat > tempdirectory/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdir || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
