import mysql.connector

def initialize_databases():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="password"
        )

        cursor = conn.cursor()
        cursor.execute("CREATE DATABASE IF NOT EXISTS volvo")
        cursor.close()

        conn.database = "volvo"

        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS emails (
                id INT AUTO_INCREMENT PRIMARY KEY,
                username VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL
            )
        """)
        cursor.close()

        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS users (
                id INT AUTO_INCREMENT PRIMARY KEY,
                username VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL,
                password VARCHAR(255) NOT NULL
            )
        """)
        cursor.close()

        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS assets (
                asset_id INT PRIMARY KEY,
                asset_name VARCHAR(50),
                asset_creation_date DATE NOT NULL,
                asset_description VARCHAR(255),
                branch_location VARCHAR(50),
                maintainance_period INT,
                active_units INT
            )
        """)
        cursor.close()

        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS sub_assets (
                sub_asset_id INT PRIMARY KEY,
                asset_id INT,
                sub_asset_creation_date DATE NOT NULL,
                status_1 VARCHAR(10),
                status_2 VARCHAR(10),
                cost INT,
                location VARCHAR(50),
                maintainance_date DATE NOT NULL,
                vendor VARCHAR(50),
                issue VARCHAR(50)
            )
        """)
        cursor.close()

        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS spares (
                spare_id INT PRIMARY KEY,
                spare_name VARCHAR(50) NOT NULL,
                units INT,
                specification VARCHAR(50),
                cost INT,
                location VARCHAR(50),
                threshold INT,
                vendor VARCHAR(50)
            )
        """)
        cursor.close()

        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS vendors (
                number INT AUTO_INCREMENT PRIMARY KEY,
                vendor_name VARCHAR(255) NOT NULL,
                contact VARCHAR(15) NOT NULL,
                product VARCHAR(255) NOT NULL,
                id INT,
                cost INT,
                lead_time INT,
                address VARCHAR(255)
            )
        """)
        cursor.close()

        print("Database and tables initialized successfully!")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            conn.close()

if __name__ == "__main__":
    initialize_databases()
