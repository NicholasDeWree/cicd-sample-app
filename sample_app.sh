#!/bin/bash
set -euo pipefail

mkdir tempdirectoryst
mkdir tempdirectoryst/templates
mkdir tempdirectoryst/static

cp sample_app.py tempdirectoryst/.
cp -r templates/* tempdirectoryst/templates/.
cp -r static/* tempdirectoryst/static/.

cat > tempdirectoryst/Dockerfile << _EOF_
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
