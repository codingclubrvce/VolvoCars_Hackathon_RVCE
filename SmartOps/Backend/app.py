from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

data = {
    "items": [
        {"id": 1, "name": "Risheek"},
        {"id": 2, "name": "Srivatsha"}
    ]
}

@app.route('/api/items', methods=['GET'])
def get_items():
    return jsonify(data)

@app.route('/api/items', methods=['POST'])
def add_item():
    new_item = request.json
    data["items"].append(new_item)
    return jsonify(new_item), 201

if __name__ == '__main__':
    app.run(debug=True, port=5000)
