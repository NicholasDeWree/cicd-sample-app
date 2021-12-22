#!/bin/bash
set -euo pipefail

mkdir tempdire
mkdir tempdire/templates
mkdir tempdire/static

cp sample_app.py tempdire/.
cp -r templates/* tempdire/templates/.
cp -r static/* tempdire/static/.

cat > tempdire/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdire || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
