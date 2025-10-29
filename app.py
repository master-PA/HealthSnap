from flask import Flask, request, jsonify
from tensorflow.keras.models import load_model
import numpy as np
import joblib

# --------------------------------
# INITIAL SETUP
# --------------------------------
app = Flask(__name__)

# Load model and preprocessors
model = load_model("symptom_cnn_lstm_model.keras")
scaler = joblib.load("scaler.pkl")
label_encoder = joblib.load("label_encoder.pkl")

# Define symptoms (must match training order)
symptoms = [
    "fever", "cough", "sore_throat", "runny_nose", "breath_shortness", "fatigue",
    "headache", "body_pain", "appetite_loss", "nausea", "stomach_pain",
    "sleep_quality", "mood_swings", "anxiety", "irritability", "concentration_loss"
]
sequence_length = 10  # number of days expected

# --------------------------------
# ROUTES
# --------------------------------
@app.route("/health", methods=["GET"])
def health_check():
    return jsonify({"status": "API is running 🚀"}), 200


@app.route("/predict", methods=["POST"])
def predict():
    """
    Example JSON input:
    {
      "data": [
        [1.2, 0.8, 0.5, 0.3, ...],  # day 1 symptom values
        [1.5, 0.7, 0.6, 0.2, ...],  # day 2 ...
        ...
        [0.9, 0.5, 0.2, 0.1, ...]   # day 10
      ]
    }
    """
    try:
        req = request.get_json()
        data = np.array(req["data"])
        
        if data.shape != (sequence_length, len(symptoms)):
            return jsonify({
                "error": f"Expected shape ({sequence_length}, {len(symptoms)}) but got {data.shape}"
            }), 400
        
        # Scale data
        data_scaled = scaler.transform(data)
        X_input = np.expand_dims(data_scaled, axis=0)  # shape (1, 10, 16)

        # Model prediction
        preds = model.predict(X_input)
        predicted_class = np.argmax(preds, axis=1)[0]
        label = label_encoder.inverse_transform([predicted_class])[0]

        confidence = float(np.max(preds))
        return jsonify({
            "prediction": label,
            "confidence": round(confidence, 3)
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# --------------------------------
# RUN SERVER
# --------------------------------

from flask import render_template

@app.route("/")
def home():
    return render_template("index.html")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
