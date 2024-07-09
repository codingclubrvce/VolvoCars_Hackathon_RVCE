'''
from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import datetime
import bcrypt  # Add bcrypt import

app = Flask(__name__)
CORS(app)

def get_credentials_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="credentials"
    )

def get_master_data_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="master_data"
    )

@app.route('/api/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    email = data.get('email')
    password = data.get('password')

    # Encrypt the password
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    conn = get_credentials_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)",
        (username, email, hashed_password)
    )
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"message": "User registered successfully!"}), 201

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    conn = get_credentials_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM users WHERE email=%s', (email,))
    user = cursor.fetchone()
    cursor.close()
    conn.close()

    if not user or not bcrypt.checkpw(password.encode('utf-8'), user[3].encode('utf-8')):
        return jsonify({'message': 'Invalid credentials'}), 401

    # Successful login
    return jsonify({'message': 'Login successful', 'user': user}), 200

@app.route('/api/add_asset', methods=['POST'])
def add_asset():
    data = request.json
    asset_number = int(data.get('assetid'))
    sub_number = int(data.get('assetname'))
    asset_description = data.get('description')
    cost_center = data.get('value')
    location_1 = data.get('assetlocation1')
    location_2 = data.get('assetlocation2')
    status = data.get('assetstatus')

    # Set asset creation date to current date
    asset_creation_date = datetime.date.today()

    conn = get_master_data_db_connection()
    cursor = conn.cursor()

    try:
        # Check if asset number already exists
        cursor.execute('SELECT * FROM asset_data WHERE asset_number=%s', (asset_number,))
        if cursor.fetchone():
            return jsonify({"message": "Asset number already exists"}), 400

        # Insert new asset into database
        cursor.execute(
            "INSERT INTO asset_data (asset_number, sub_number, asset_creation_date, asset_description, cost_center, location_1, location_2, status, validation_status) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
            (asset_number, sub_number, asset_creation_date, asset_description, cost_center, location_1, location_2, status, 'false')
        )
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"message": "Asset added successfully!"}), 201
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route('/api/update_asset', methods=['POST'])
def update_asset():
    data = request.json
    asset_number = data.get('assetid')
    status = data.get('status')
    current_apc = data.get('currentapc')
    comments = data.get('comments')
    validation_status = True
    if(data.get("units")):
        physically_available = True
    else:
        physically_available = False

    conn = get_master_data_db_connection()
    cursor = conn.cursor()

    try:
        # Check if asset number exists
        cursor.execute('SELECT * FROM asset_data WHERE asset_number=%s', (asset_number,))
        asset = cursor.fetchone()
        if not asset:
            return jsonify({"message": "Asset not found"}), 404

        # Update asset in the database
        cursor.execute(
            "UPDATE asset_data SET status=%s, current_apc=%s, comments=%s, validation_status=%s, physically_available=%s WHERE asset_number=%s",
            (status, current_apc, comments, validation_status, physically_available, asset_number)
        )
        conn.commit()

        # Reset validation_status to false after 1 week if it was set to true
        if validation_status == 'true':
            cursor.execute(
                "UPDATE asset_data SET validation_status='false' WHERE asset_number=%s AND asset_creation_date <= DATE_SUB(NOW(), INTERVAL 1 WEEK)",
                (asset_number,)
            )
            conn.commit()

        cursor.close()
        conn.close()
        return jsonify({"message": "Asset updated successfully!"}), 200
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route('/api/delete_asset/<int:asset_number>', methods=['DELETE'])
def delete_asset(asset_number):
    conn = get_master_data_db_connection()
    cursor = conn.cursor()

    try:
        # Check if asset number exists
        cursor.execute('SELECT * FROM asset_data WHERE asset_number=%s', (asset_number,))
        asset = cursor.fetchone()
        if not asset:
            return jsonify({"message": "Asset not found"}), 404

        # Delete asset from the database
        cursor.execute('DELETE FROM asset_data WHERE asset_number=%s', (asset_number,))
        conn.commit()

        cursor.close()
        conn.close()
        return jsonify({"message": "Asset deleted successfully!"}), 200
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route('/api/inventory', methods=['GET'])
def show_inventory():
    conn = get_master_data_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Retrieve all assets from the database
        cursor.execute('SELECT * FROM asset_data')
        assets = cursor.fetchall()

        cursor.close()
        conn.close()
        return assets, 200
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    app.run(debug=True)
'''




from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import datetime
import bcrypt

app = Flask(__name__)
CORS(app)

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="password",
        database="volvo_inventory"
    )

@app.route('/api/register', methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    email = data.get('email')
    password = data.get('password')

    # Encrypt the password
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)",
        (username, email, hashed_password)
    )
    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({"message": "User registered successfully!"}), 201

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM users WHERE email=%s', (email,))
    user = cursor.fetchone()
    cursor.close()
    conn.close()

    if not user or not bcrypt.checkpw(password.encode('utf-8'), user[3].encode('utf-8')):
        return jsonify({'message': 'Invalid credentials'}), 401

    # Successful login
    return jsonify({'message': 'Login successful', 'user': user}), 200

@app.route('/api/add_asset', methods=['POST'])
def add_asset():
    data = request.json
    asset_number = int(data.get('assetid'))
    sub_number = int(data.get('assetname'))
    asset_description = data.get('description')
    cost_center = data.get('value')
    location_1 = data.get('assetlocation1')
    location_2 = data.get('assetlocation2')
    status = data.get('assetstatus')

    # Set asset creation date to current date
    asset_creation_date = datetime.date.today()

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Check if asset number already exists
        cursor.execute('SELECT * FROM assets WHERE asset_number=%s', (asset_number,))
        if cursor.fetchone():
            return jsonify({"message": "Asset number already exists"}), 400

        # Insert new asset into database
        cursor.execute(
            "INSERT INTO assets (asset_number, sub_number, asset_creation_date, asset_description, cost_center, location_1, location_2, status, validation_status) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
            (asset_number, sub_number, asset_creation_date, asset_description, cost_center, location_1, location_2, status, 'false')
        )
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"message": "Asset added successfully!"}), 201
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route('/api/update_asset', methods=['POST'])
def update_asset():
    data = request.json
    asset_number = data.get('assetid')
    status = data.get('status')
    current_apc = data.get('currentapc')
    comments = data.get('comments')
    validation_status = True
    if(data.get("units")):
        physically_available = True
    else:
        physically_available = False

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Check if asset number exists
        cursor.execute('SELECT * FROM assets WHERE asset_number=%s', (asset_number,))
        asset = cursor.fetchone()
        if not asset:
            return jsonify({"message": "Asset not found"}), 404

        # Update asset in the database
        cursor.execute(
            "UPDATE assets SET status=%s, current_apc=%s, comments=%s, validation_status=%s, physically_available=%s WHERE asset_number=%s",
            (status, current_apc, comments, validation_status, physically_available, asset_number)
        )
        conn.commit()

        # Reset validation_status to false after 1 week if it was set to true
        if validation_status == 'true':
            cursor.execute(
                "UPDATE assets SET validation_status='false' WHERE asset_number=%s AND asset_creation_date <= DATE_SUB(NOW(), INTERVAL 1 WEEK)",
                (asset_number,)
            )
            conn.commit()

        cursor.close()
        conn.close()
        return jsonify({"message": "Asset updated successfully!"}), 200
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route('/api/delete_asset/<int:asset_number>', methods=['DELETE'])
def delete_asset(asset_number):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Check if asset number exists
        cursor.execute('SELECT * FROM assets WHERE asset_number=%s', (asset_number,))
        asset = cursor.fetchone()
        if not asset:
            return jsonify({"message": "Asset not found"}), 404

        # Delete asset from the database
        cursor.execute('DELETE FROM assets WHERE asset_number=%s', (asset_number,))
        conn.commit()

        cursor.close()
        conn.close()
        return jsonify({"message": "Asset deleted successfully!"}), 200
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route('/api/inventory', methods=['GET'])
def show_inventory():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Retrieve all assets from the database
        cursor.execute('SELECT * FROM assets')
        assets = cursor.fetchall()

        cursor.close()
        conn.close()
        return assets, 200
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    app.run(debug=True)
