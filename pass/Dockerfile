# Dockerfile
FROM python:3.8-slim

RUN apk update

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY pass_app.py ./

CMD ["python", "pass_app.py"]

