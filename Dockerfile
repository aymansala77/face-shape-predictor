# استخدم نسخة Python ثابتة متوافقة مع مكتباتك
FROM python:3.10-slim

# حدد مجلد العمل داخل الحاوية
WORKDIR /app

# انسخ كل ملفات المشروع
COPY . /app

# حدث pip أولًا
RUN pip install --upgrade pip

# ثبّت المكتبات من ملف requirements
RUN pip install -r requirements.txt

# شغّل التطبيق باستخدام uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
