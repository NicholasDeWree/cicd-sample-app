#!/bin/bash
set -euo pipefail

mkdir tempdirec
mkdir tempdirec/templates
mkdir tempdirec/static

cp sample_app.py tempdirec/.
cp -r templates/* tempdirec/templates/.
cp -r static/* tempdirec/static/.

cat > tempdirec/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdirec || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
