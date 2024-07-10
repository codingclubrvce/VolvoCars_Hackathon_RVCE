# Volvo Asset Manager

## Project Overview

This project is a Flutter-based application for asset management, integrated with a backend built using Java Spring Boot with Hibernate. The backend provides various API services required by the Flutter app to function. The backend and database files are included in a zipped folder attached to this project.

## Prerequisites

### Flutter Application

- Android Studio (preferred IDE)
- Flutter SDK
- Dart SDK

### Backend

- Eclipse IDE
- Java Development Kit (JDK)
- MySQL Workbench

## Setting Up the Backend

1. *Unzip the Backend Folder*
    - Unzip the provided backend folder which includes the Java Spring Boot project and the MySQL database file.

2. *Import the Spring Boot Project into Eclipse IDE*
    - Open Eclipse IDE.
    - Go to File > Import > Maven > Existing Maven Projects.
    - Select the unzipped backend project folder and click Finish.

3. *Set Up the Database*
    - Open MySQL Workbench.
    - Create a new database schema.
    - Import the provided SQL file into this schema.

4. *Configure Database Connection*
    - Open the application.properties file in the Spring Boot project.
    - Configure the database connection properties (username, password, database URL, etc.).
      properties
      spring.datasource.url=jdbc:mysql://localhost:3306/YOUR_DATABASE_NAME
      spring.datasource.username=root
      spring.datasource.password=YOUR_PASSWORD


5. *Run the Spring Boot Application*
    - Right-click the project in Eclipse IDE.
    - Select Run As > Spring Boot App.

## Setting Up the Flutter Application

1. *Clone the Flutter Project*
    - Clone or download the Flutter project repository to your local machine.

2. *Open the Project in Android Studio*
    - Open Android Studio.
    - Select Open an Existing Project.
    - Navigate to the cloned Flutter project folder and open it.

3. *Install Dependencies*
    - Open the terminal in Android Studio.
    - Run the following command to install the necessary dependencies:
      sh
      flutter pub get


4. *Configure API Endpoints*
    - Open the Flutter project and navigate to the configuration file where the API endpoints are defined.
    - Update the base URL to point to the backend server running the Spring Boot application.

5. *Run the Flutter Application*
    - Connect your Android device or start an emulator.
    - Click the Run button in Android Studio.

## System Design Architecture

(Include the system design architecture here)

## Additional Information

- *Backend*
    - Spring Boot version: x.x.x
    - Hibernate version: x.x.x

- *Database*
    - MySQL version: x.x.x

- *Flutter*
    - Flutter version: x.x.x
    - Dart version: x.x.x

Feel free to contact us for any queries or issues related to the project setup and execution.

---

This README file provides the necessary steps to set up and run the Flutter application along with the backend services. Ensure all dependencies and configurations are correctly set up to avoid any runtime issues.