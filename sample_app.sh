#!/bin/bash
set -euo pipefail

mkdir tempdirecto
mkdir tempdirecto/templates
mkdir tempdirecto/static

cp sample_app.py tempdirecto/.
cp -r templates/* tempdirecto/templates/.
cp -r static/* tempdirecto/static/.

cat > tempdirecto/Dockerfile << _EOF_
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
