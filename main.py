from fastapi import FastAPI, UploadFile, File
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
import numpy as np
import io
from PIL import Image
# تحميل الموديل
model = load_model("face_shape_model_final.keras")

# أسماء الكلاسات
class_names = ["Round", "Oval", "Square", "Heart", "Oblong"]

app = FastAPI()

# ✅ إضافة CORS Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # تقدر تغيرها وتحط الدومين بتاع متجرك
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        contents = await file.read()
        img = Image.open(io.BytesIO(contents)).convert("RGB")
        img = img.resize((224, 224))

        img_array = image.img_to_array(img) / 255.0
        img_array = np.expand_dims(img_array, axis=0)

        predictions = model.predict(img_array)
        predicted_index = np.argmax(predictions[0])
        confidence = float(np.max(predictions[0]))

        result = {
            "class": class_names[predicted_index],
            "confidence": confidence
        }

        return JSONResponse(content=result)

    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)
