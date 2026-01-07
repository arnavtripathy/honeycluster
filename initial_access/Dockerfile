# Dockerfile
FROM python:3.10-slim
WORKDIR /app
# Install curl
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY app.py .
RUN pip install flask
EXPOSE 8080
CMD ["python", "app.py"]
