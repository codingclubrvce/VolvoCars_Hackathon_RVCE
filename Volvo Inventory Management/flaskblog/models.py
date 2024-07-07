from flaskblog import db

class AssetInventory(db.Model):
    __tablename__ = 'AssetInventory'
    asset_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20))
    sub_number = db.Column(db.Integer)
    creation_date = db.Column(db.Date)
    desc = db.Column(db.String(50))
    cost_center = db.Column(db.String(20))
    plant_location = db.Column(db.String(30))
    location = db.Column(db.String(25))
    current_apc = db.Column(db.Integer)
    status = db.Column(db.String(20))
    validation_24w11 = db.Column(db.String(5))
    physically_avail = db.Column(db.String(5))
    comments = db.Column(db.String(250))

class SpareParts(db.Model):
    __tablename__ = 'SpareParts'
    part_id = db.Column(db.Integer, primary_key=True)
    asset_id = db.Column(db.Integer, db.ForeignKey('AssetInventory.asset_id'))
    location = db.Column(db.String(25))
    number = db.Column(db.Integer)
    vendor = db.Column(db.String(50))
    lead_time = db.Column(db.String(20))
    cost = db.Column(db.Integer)
    
class MaintenanceSchedule(db.Model):
    __tablename__ = 'MaintenanceSchedule'
    asset_id = db.Column(db.Integer, db.ForeignKey('AssetInventory.asset_id'), primary_key=True)
    type = db.Column(db.String(25), primary_key=True)
    schedule = db.Column(db.String(25))
    last_date = db.Column(db.Date)
    instructions = db.Column(db.String(100))
    
class PartsUsed(db.Model):
    __tablename__ = 'PartsUsed'
    asset_id = db.Column(db.Integer, db.ForeignKey('AssetInventory.asset_id'), primary_key=True)
    part_id = db.Column(db.Integer, db.ForeignKey('SpareParts.part_id'), primary_key=True)
    date = db.Column(db.Date, primary_key=True)