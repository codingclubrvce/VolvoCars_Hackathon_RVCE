from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_mail import Mail, Message
import mysql.connector
import datetime
import bcrypt
import random
import os

import os
import smtplib
from email.message import EmailMessage
from email.utils import formataddr
from pathlib import Path

from dotenv import load_dotenv

sender_email = 'hackvolvo@gmail.com'
password_email = 'sbwx xmnu uefj vhvu'
PORT = 587  
EMAIL_SERVER = "smtp.gmail.com" 


def send_email(subject, receiver_email, name, otp):
    # Create the base text message.
    msg = EmailMessage()
    msg["Subject"] = subject
    msg["From"] = formataddr(("Volvo email verification.", f"{sender_email}"))
    msg["To"] = receiver_email
    msg["BCC"] = sender_email

    msg.set_content(
        f"""\
        Hi {name},
        I hope you are well.
        This is the otp for the sign up process do not disclose this to anyone {otp}
        Team volvo
        """
    )
    # Add the html version.  This converts the message into a multipart/alternative
    # container, with the original text message as the first part and the new html
    # message as the second part.
    msg.add_alternative(
        f"""\
    <html>
      <body>
        <p>Hi {name},</p>
        <p>I hope you are well.</p>
        <p>This is the otp for the sign up process do not disclose this to anyone {otp}</strong>.</p>
        <p>Team volvo</p>
      </body>
    </html>
    """,
        subtype="html",
    )

    with smtplib.SMTP(EMAIL_SERVER, PORT) as server:
        server.starttls()
        server.login(sender_email, password_email)
        server.sendmail(sender_email, receiver_email, msg.as_string())

global otp
  
app = Flask(__name__)
CORS(app)


def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="password",
        database="volvo"
    )
@app.route('/api/sendOTP', methods=['POST'])
def sendOTP():
    global otp
    data = request.json
    email = data.get('email')
    username =  data.get('username')
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        'SELECT * FROM users WHERE email=%s', (email,)
    )
    user = cursor.fetchall()
    cursor.close()
    conn.close()

    if user:
        return jsonify({"message": "User email already exists!"}), 401
    
    otp = str(random.randint(100000, 999999))
    
    send_email(subject="OTP Generated!",
        name= username,
        receiver_email=email,
        otp = otp)

    return jsonify({'message': 'Check your email for the OTP code.'}), 201


@app.route('/api/register', methods=['POST'])
def register():
    global otp
    data = request.json
    username = data.get('username')
    email = data.get('email')
    password = data.get('password')
    submitted_otp = data.get('OTP')

    # Encrypt the password
    if(otp==submitted_otp):
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
    else:
        return jsonify({"message": "Wrong OTP!"}), 401
    

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
    asset_id = int(data.get('assetId'))
    asset_name = (data.get('assetName'))
    asset_description = data.get('description')
    location = data.get('assetLocation')
    maintainance_period = data.get('maintainancePeriod')

    # Set asset creation date to current date
    asset_creation_date = datetime.date.today()

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Check if asset number already exists
        cursor.execute('SELECT * FROM assets WHERE asset_id=%s', (asset_id,))
        if cursor.fetchone():
            return jsonify({"message": "Asset number already exists"}), 400

        # Insert new asset into database
        cursor.execute(
            "INSERT INTO assets (asset_id, asset_name, asset_creation_date, asset_description, branch_location, maintainance_period, active_units) VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (asset_id, asset_name, asset_creation_date, asset_description, location, maintainance_period, 0)
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

@app.route('/api/add_subasset', methods=['POST'])
def add_subasset():
    data = request.json
    asset_id = int(data.get('assetId'))
    sub_asset_id = (data.get('subassetId'))
    sub_asset_name = data.get('subassetName')
    status1 = "active"
    status2 = data.get('status2')
    cost = data.get('cost')
    vendor = data.get('vendor')
    location = data.get('location')
    issue = "None"

    # Set asset creation date to current date
    subasset_creation_date = datetime.date.today()
    maitainanceData = subasset_creation_date

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Check if asset number already exists
        cursor.execute('SELECT * FROM assets WHERE asset_id=%s', (asset_id,))
        if not (cursor.fetchone()):
            return jsonify({"message": "Asset number does not exists"}), 400

        # Insert new asset into database
        cursor.execute(
            "INSERT INTO sub_assets (sub_asset_id, asset_id, sub_asset_creation_date, status_1, status_2, cost, location, maintainance_date, vendor, issue) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
            (sub_asset_id, asset_id, subasset_creation_date, status1, status2, cost, location, maitainanceData, vendor, issue)
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
