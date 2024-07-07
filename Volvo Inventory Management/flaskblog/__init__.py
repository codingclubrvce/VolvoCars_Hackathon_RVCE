from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///volvo.db'
    app.config['SECRET_KEY'] = 'ASDFGHJKLQWERTYUIOP'  # Set your secret key here

    db.init_app(app)
    migrate.init_app(app, db)

    with app.app_context():
        # Import parts of our application
        from . import models
        
        # Create tables for our models
        db.create_all()
        
        from . import routes

    return app
