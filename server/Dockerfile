FROM python:3.8.18-slim-bullseye

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY . /app

WORKDIR /app

CMD ["python3", "main.py"]

