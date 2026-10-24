FROM python:3.11-slim

WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

COPY AgriSmart-deploy.zip /tmp/AgriSmart-deploy.zip
RUN python -c "import zipfile; zipfile.ZipFile('/tmp/AgriSmart-deploy.zip').extractall('/app')" \
    && pip install --no-cache-dir -r requirements.txt \
    && rm /tmp/AgriSmart-deploy.zip

EXPOSE 10000
CMD ["sh", "-c", "uvicorn server:app --host 0.0.0.0 --port ${PORT:-10000}"]
