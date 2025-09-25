# استخدم Python 3.11 رسمي
FROM python:3.11-slim

# إعداد working directory
WORKDIR /app

# نسخ الملفات المهمة
COPY requirements.txt .
COPY main.py .

# تثبيت pip وأدوات البناء الأساسية
RUN apt-get update && apt-get install -y build-essential \
    && pip install --upgrade pip

# تثبيت المكتبات الضرورية والمتوافقة فقط
RUN pip install --no-cache-dir -r requirements.txt

# expose البورت اللي FastAPI بيشتغل عليه
EXPOSE 8000

# أمر التشغيل
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
