import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"  # disable GPU search on Render

from flask import Flask, request, jsonify, render_template
from tensorflow.keras.models import load_model
import numpy as np
import joblib

# --------------------------------
# INITIAL SETUP
# --------------------------------
app = Flask(__name__)

# Lazy load model (for Render stability)
model = None
scaler = None
label_encoder = None

def get_model():
    """Load the model and preprocessors once (lazy loading)."""
    global model, scaler, label_encoder
    if model is None:
        print("🔄 Loading model and preprocessors...")
        model = load_model("symptom_cnn_lstm_model.keras")
        scaler = joblib.load("scaler.pkl")
        label_encoder = joblib.load("label_encoder.pkl")
        print("✅ Model and preprocessors loaded successfully!")
    return model, scaler, label_encoder


# --------------------------------
# SYMPTOMS DEFINITION
# --------------------------------
symptoms = [
    "fever", "cough", "sore_throat", "runny_nose", "breath_shortness", "fatigue",
    "headache", "body_pain", "appetite_loss", "nausea", "stomach_pain",
    "sleep_quality", "mood_swings", "anxiety", "irritability", "concentration_loss"
]
max_sequence_length = 10  # expected number of days


# --------------------------------
# ROUTES
# --------------------------------
@app.route("/health", methods=["GET"])
def health_check():
    """Simple API health check."""
    return jsonify({"status": "API is running 🚀"}), 200


@app.route("/predict", methods=["POST"])
def predict():
    """
    Example JSON input:
    {
      "data": [
        [1.2, 0.8, 0.5, ...],  # day 1
        [1.0, 0.7, 0.4, ...],  # day 2
        ...
      ]
    }
    """
    try:
        # Load model lazily
        model, scaler, label_encoder = get_model()

        # Parse request data
        req = request.get_json()
        if "data" not in req:
            return jsonify({"error": "Missing 'data' field in JSON input"}), 400

        data = np.array(req["data"], dtype=float)

        # Validate feature dimension
        if data.shape[1] != len(symptoms):
            return jsonify({
                "error": f"Expected {len(symptoms)} features per day, got {data.shape[1]}"
            }), 400

        num_days = data.shape[0]
        if num_days < 2:
            return jsonify({
                "error": "At least 2 days of symptom data are required"
            }), 400

        # Scale the data
        data_scaled = scaler.transform(data)

        # Pad or truncate to 10 days
        if num_days < max_sequence_length:
            pad_len = max_sequence_length - num_days
            padding = np.zeros((pad_len, len(symptoms)))
            data_scaled = np.vstack([padding, data_scaled])  # pad at beginning
        elif num_days > max_sequence_length:
            data_scaled = data_scaled[-max_sequence_length:]  # last 10 days

        X_input = np.expand_dims(data_scaled, axis=0)  # shape: (1, 10, 16)

        # Prediction
        preds = model.predict(X_input)
        predicted_class = np.argmax(preds, axis=1)[0]
        label = label_encoder.inverse_transform([predicted_class])[0]
        confidence = float(np.max(preds))

        return jsonify({
            "days_provided": num_days,
            "prediction": label,
            "confidence": round(confidence, 3)
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# --------------------------------
# HOME ROUTE
# --------------------------------
@app.route("/")
def home():
    return render_template("index.html")


# --------------------------------
# RUN SERVER
# --------------------------------
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=port)
