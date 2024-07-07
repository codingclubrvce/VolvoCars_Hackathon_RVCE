from flask import flash, redirect, render_template, url_for, request
from flaskblog.models import *
from flask import current_app as app
from datetime import datetime

@app.route("/")
@app.route("/home")
def home():
    return render_template('home.html', title = 'Home')

@app.route("/asset")
def asset():
    assets = AssetInventory.query.all()
    return render_template('asset.html', title = 'Assets Inventory', assets=assets)

@app.route('/update_asset', methods=['GET', 'POST'])
def update_asset():
    if request.method == 'POST':
        asset_ids = request.form.getlist('asset_id')
        names = request.form.getlist('name')
        sub_numbers = request.form.getlist('sub_number')
        # Get list of date strings and convert to date objects
        creation_dates_str = request.form.getlist('creation_date')
        creation_dates = [datetime.strptime(date_str, '%Y-%m-%d').date() for date_str in creation_dates_str]
        descs = request.form.getlist('desc')
        cost_centers = request.form.getlist('cost_center')
        plant_locations = request.form.getlist('plant_location')
        locations = request.form.getlist('location')
        current_apcs = request.form.getlist('current_apc')
        statuses = request.form.getlist('status')
        validation_24w11s = request.form.getlist('validation_24w11')
        physically_avails = request.form.getlist('physically_avail')
        comments = request.form.getlist('comments')
        
        # Assuming all lists have the same length
        for i in range(len(asset_ids)):
            asset_id = asset_ids[i]
            asset = AssetInventory.query.get_or_404(asset_id)
            asset.name = names[i]
            asset.sub_number = sub_numbers[i]
            asset.creation_date = creation_dates[i]
            asset.desc = descs[i]
            asset.cost_center = cost_centers[i]
            asset.plant_location = plant_locations[i]
            asset.location = locations[i]
            asset.current_apc = current_apcs[i]
            asset.status = statuses[i]
            asset.validation_24w11 = validation_24w11s[i]
            asset.physically_avail = physically_avails[i]
            asset.comments = comments[i]

            db.session.commit()

        flash('Asset inventory updated successfully!', 'success')
        return redirect(url_for('asset'))

    assets = AssetInventory.query.all()
    return render_template('update_asset.html', assets=assets)

@app.route('/add_asset', methods=['GET', 'POST'])
def add_asset():
    if request.method == 'POST':
        name = request.form['name']
        sub_number = request.form['sub_number']
        creation_date_str = request.form.get('creation_date')
        creation_date = datetime.strptime(creation_date_str, '%Y-%m-%d').date()  # Convert string to date
        desc = request.form['desc']
        cost_center = request.form['cost_center']
        plant_location = request.form['plant_location']
        location = request.form['location']
        current_apc = request.form['current_apc']
        status = request.form['status']
        validation_24w11 = request.form['validation_24w11']
        physically_avail = request.form['physically_avail']
        comments = request.form['comments']

        asset = AssetInventory(
            name=name,
            sub_number=sub_number,
            creation_date=creation_date,
            desc=desc,
            cost_center=cost_center,
            plant_location=plant_location,
            location=location,
            current_apc=current_apc,
            status=status,
            validation_24w11=validation_24w11,
            physically_avail=physically_avail,
            comments=comments
        )
        db.session.add(asset)
        db.session.commit()
        return redirect(url_for('asset'))
    return render_template('add_asset.html')

@app.route("/spare")
def spare():
    parts = SpareParts.query.all()
    return render_template('spare.html', title = 'Spare Parts Inventory', parts=parts)

@app.route('/update_spare', methods=['GET', 'POST'])
def update_spare():
    if request.method == 'POST':
        part_ids = request.form.getlist('part_id')
        locations = request.form.getlist('location')
        numbers = request.form.getlist('number')
        vendors = request.form.getlist('vendor')
        lead_times = request.form.getlist('lead_time')
        costs = request.form.getlist('cost')

        # Assuming all lists have the same length
        for i in range(len(part_ids)):
            part_id = part_ids[i]
            part = SpareParts.query.get_or_404(part_id)
            part.location = locations[i]
            part.number = numbers[i]
            part.vendor = vendors[i]
            part.lead_time = lead_times[i]
            part.cost = costs[i]

            db.session.commit()

        flash('Spare parts updated successfully!', 'success')
        return redirect(url_for('spare'))

    parts = SpareParts.query.all()
    return render_template('update_spare.html', parts=parts)

@app.route('/add_spare', methods=['GET', 'POST'])
def add_spare():
    if request.method == 'POST':
        asset_id = request.form['asset_id']
        location = request.form['location']
        number = request.form['number']
        vendor = request.form['vendor']
        lead_time = request.form['lead_time']
        cost = request.form['cost']

        spare_part = SpareParts(
            asset_id=asset_id,
            location=location,
            number=number,
            vendor=vendor,
            lead_time=lead_time,
            cost=cost
        )
        db.session.add(spare_part)
        db.session.commit()
        flash('Spare Part entry has been created!', 'success')
        return redirect(url_for('spare'))
    return render_template('add_spare.html')

@app.route("/regmaint")
def regmaint():
    schedules = MaintenanceSchedule.query.all()
    return render_template('regmaint.html', title = 'Regular Maintenance Schedule', schedules=schedules)

@app.route('/update_regmaint', methods=['GET', 'POST'])
def update_regmaint():
    if request.method == 'POST':
        asset_ids = request.form.getlist('asset_id')
        types = request.form.getlist('type')
        schedules = request.form.getlist('schedule')
        # Get list of date strings and convert to date objects
        last_dates_str = request.form.getlist('last_date')
        last_dates = [datetime.strptime(date_str, '%Y-%m-%d').date() for date_str in last_dates_str]
        instructions = request.form.getlist('instructions')

        # Assuming all lists have the same length
        for i in range(len(asset_ids)):
            asset_id = asset_ids[i]
            type = types[i]
            maintenance = MaintenanceSchedule.query.get((asset_id, type))
            maintenance.schedule = schedules[i]
            maintenance.last_date = last_dates[i]
            maintenance.instructions = instructions[i]

            db.session.commit()

        flash('Maintenance schedules updated successfully!', 'success')
        return redirect(url_for('regmaint'))

    schedules = MaintenanceSchedule.query.all()
    return render_template('update_regmaint.html', schedules=schedules)

@app.route('/add_regmaint', methods=['GET', 'POST'])
def add_regmaint():
    if request.method == 'POST':
        asset_id = request.form['asset_id']
        type = request.form['type']
        schedule = request.form['schedule']
        last_date_str = request.form.get('last_date')
        last_date = datetime.strptime(last_date_str, '%Y-%m-%d').date()  # Convert string to date
        instructions = request.form['instructions']

        maintenance_schedule = MaintenanceSchedule(
            asset_id=asset_id,
            type=type,
            schedule=schedule,
            last_date=last_date,
            instructions=instructions
        )
        db.session.add(maintenance_schedule)
        db.session.commit()
        flash('Maintenance Schedule entry has been created!', 'success')
        return redirect(url_for('regmaint'))
    return render_template('add_regmaint.html')

@app.route("/maint")
def maint():
    parts_used = PartsUsed.query.all()
    return render_template('maint.html', title = 'Maintenance History', parts_used=parts_used)

@app.route('/update_maint', methods=['GET', 'POST'])
def update_maint():
    if request.method == 'POST':
        asset_ids = request.form.getlist('asset_id')
        part_ids = request.form.getlist('part_id')
        # Get list of date strings and convert to date objects
        dates_str = request.form.getlist('date')
        dates = [datetime.strptime(date_str, '%Y-%m-%d').date() for date_str in dates_str]

        # Assuming all lists have the same length
        for i in range(len(asset_ids)):
            asset_id = asset_ids[i]
            part_id = part_ids[i]
            date = dates[i]

            part_used = PartsUsed.query.get((asset_id, part_id))
            part_used.date = date

            db.session.commit()

        flash('Maintenace Information updated successfully!', 'success')
        return redirect(url_for('maint'))

    parts_used = PartsUsed.query.all()
    return render_template('update_maint.html', parts_used=parts_used)

@app.route('/add_maint', methods=['GET', 'POST'])
def add_maint():
    if request.method == 'POST':
        asset_id = request.form['asset_id']
        part_id = request.form['part_id']
        date_str = request.form.get('date')
        date = datetime.strptime(date_str, '%Y-%m-%d').date()  # Convert string to date

        parts_used = PartsUsed(
            asset_id=asset_id,
            part_id=part_id,
            date=date
        )
        db.session.add(parts_used)
        db.session.commit()
        flash('Parts Used entry has been created!', 'success')
        return redirect(url_for('add_maint'))
    return render_template('add_maint.html')