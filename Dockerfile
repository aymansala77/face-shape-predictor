# استخدم صورة Python 3.11
FROM python:3.11-slim

# اضبط متغير بيئة العمل
WORKDIR /app

# انسخ ملفات المشروع
COPY . /app

# حدث pip أولاً
RUN pip install --upgrade pip

# ثبت المتطلبات
RUN pip install --no-cache-dir -r requirements.txt

# اعرض البورت اللي هيشتغل عليه التطبيق
EXPOSE 8000

# أمر التشغيل
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
