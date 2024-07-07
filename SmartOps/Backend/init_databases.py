import mysql.connector

def initialize_databases():
    try:
        # Connect to MySQL (assuming default local installation)
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="password"
        )

        # Create 'credentials' database if not exists
        cursor = conn.cursor()
        cursor.execute("CREATE DATABASE IF NOT EXISTS credentials")
        cursor.close()

        # Create 'users' table in 'credentials' database if not exists
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS credentials.users (
                id INT AUTO_INCREMENT PRIMARY KEY,
                username VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL,
                password VARCHAR(255) NOT NULL
            )
        """)
        cursor.close()

        # Create 'master_data' database if not exists
        cursor = conn.cursor()
        cursor.execute("CREATE DATABASE IF NOT EXISTS master_data")
        cursor.close()

        # Create 'asset_data' table in 'master_data' database if not exists
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS master_data.asset_data (
                id INT AUTO_INCREMENT PRIMARY KEY,
                asset_number INT NOT NULL,
                sub_number INT,
                asset_creation_date DATE NOT NULL,
                asset_description VARCHAR(255),
                cost_center VARCHAR(50),
                location_1 VARCHAR(50),
                location_2 VARCHAR(50),
                status VARCHAR(50),
                validation_status ENUM('true', 'false') DEFAULT 'false',
                current_apc DECIMAL(10, 2),
                comments TEXT,
                physically_available BOOLEAN
            )
        """)
        cursor.close()

        print("Databases and tables initialized successfully!")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            conn.close()

if __name__ == "__main__":
    initialize_databases()
