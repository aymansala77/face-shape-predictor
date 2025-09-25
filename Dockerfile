FROM python:3.11.9-slim

WORKDIR /app

# نسخ الملفات الأساسية
COPY requirements.txt .
COPY main.py .

# تثبيت المكتبات الضرورية فقط
RUN apt-get update && apt-get install -y build-essential \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# expose البورت
EXPOSE 8000

# الأمر لتشغيل FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
