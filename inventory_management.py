import streamlit as st
from google.cloud.sql.connector import Connector
import pymysql
import pandas as pd

# Google Cloud SQL connection details
instance_connection_name = "splendid-sonar-428607-b2:asia-south1:volvo"
db_user = "root"
db_password = "volvo2024"
db_name = "inventory_management"

# Function to establish a connection to the MySQL database using Google Cloud SQL Connector
def get_connection():
    connector = Connector()
    conn = connector.connect(
        instance_connection_name,
        "pymysql",
        user=db_user,
        password=db_password,
        db=db_name
    )
    return conn

# Function to execute SQL commands
def execute_query(query, params=None):
    conn = get_connection()
    try:
        with conn.cursor(pymysql.cursors.DictCursor) as cursor:
            cursor.execute(query, params)
            conn.commit()
            return cursor.fetchall()
    finally:
        conn.close()

# Streamlit UI
st.title("Asset Management System")

menu = ["Asset Inventory", "Spare Parts Management", "Maintenance Management", "Reports & Dashboard"]
choice = st.sidebar.selectbox("Menu", menu)

if choice == "Asset Inventory":
    st.subheader("Manage Asset Inventory")
    
    # Add new asset
    with st.form(key="add_asset_form"):
        location = st.text_input("Location")
        cost_value = st.number_input("Cost/Value", min_value=0.0)
        physical_verification_status = st.selectbox("Physical Verification Status", ["Verified", "Not Verified"])
        description = st.text_area("Description")
        submit_button = st.form_submit_button(label="Add Asset")
        
        if submit_button:
            query = "INSERT INTO asset_inventory (location, cost_value, physical_verification_status, description) VALUES (%s, %s, %s, %s)"
            execute_query(query, (location, cost_value, physical_verification_status, description))
            st.success("Asset added successfully")
    
    # Display and manage asset inventory
    assets = execute_query("SELECT * FROM asset_inventory")
    if assets:
        df_assets = pd.DataFrame(assets)
        st.write(df_assets)

if choice == "Spare Parts Management":
    st.subheader("Manage Spare Parts")
    
    # Add new spare part
    with st.form(key="add_spare_form"):
        item_master = st.text_input("Item Master")
        asset_spare_relationship = st.text_input("Asset & Spare Relationship")
        issue_transfer = st.text_input("Issue and Transfer")
        location = st.text_input("Location")
        vendor_info = st.text_input("Vendor Info")
        lead_time = st.number_input("Lead Time (days)", min_value=0)
        spare_part_cost = st.number_input("Spare Part Cost", min_value=0.0)
        description = st.text_area("Description")
        submit_button = st.form_submit_button(label="Add Spare Part")
        
        if submit_button:
            query = "INSERT INTO spare_parts (item_master, asset_spare_relationship, issue_transfer, location, vendor_info, lead_time, spare_part_cost, description) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
            execute_query(query, (item_master, asset_spare_relationship, issue_transfer, location, vendor_info, lead_time, spare_part_cost, description))
            st.success("Spare part added successfully")
    
    # Display and manage spare parts
    spares = execute_query("SELECT * FROM spare_parts")
    if spares:
        df_spares = pd.DataFrame(spares)
        st.write(df_spares)

if choice == "Maintenance Management":
    st.subheader("Manage Maintenance")
    
    # Schedule new maintenance
    with st.form(key="add_maintenance_form"):
        maintenance_type = st.text_input("Maintenance Type")
        maintenance_planning = st.text_input("Maintenance Planning")
        maintenance_schedule = st.date_input("Maintenance Schedule")
        maintenance_instructions = st.text_area("Maintenance Instructions")
        status = st.selectbox("Status", ["Scheduled", "In Progress", "Completed"])
        submit_button = st.form_submit_button(label="Schedule Maintenance")
        
        if submit_button:
            query = "INSERT INTO maintenance (maintenance_type, maintenance_planning, maintenance_schedule, maintenance_instructions, status) VALUES (%s, %s, %s, %s, %s)"
            execute_query(query, (maintenance_type, maintenance_planning, maintenance_schedule, maintenance_instructions, status))
            st.success("Maintenance scheduled successfully")
    
    # Display and manage maintenance schedule
    maintenance = execute_query("SELECT * FROM maintenance")
    if maintenance:
        df_maintenance = pd.DataFrame(maintenance)
        st.write(df_maintenance)

if choice == "Reports & Dashboard":
    st.subheader("Reports and Dashboard")
    
    # Display asset inventory summary
    st.write("### Asset Inventory Summary")
    assets_summary = execute_query("SELECT location, COUNT(*) as count, SUM(cost_value) as total_value FROM asset_inventory GROUP BY location")
    if assets_summary:
        df_assets_summary = pd.DataFrame(assets_summary)
        st.write(df_assets_summary)
    
    # Display spare parts summary
    st.write("### Spare Parts Summary")
    spares_summary = execute_query("SELECT location, COUNT(*) as count, SUM(spare_part_cost) as total_cost FROM spare_parts GROUP BY location")
    if spares_summary:
        df_spares_summary = pd.DataFrame(spares_summary)
        st.write(df_spares_summary)
    
    # Display maintenance schedule
    st.write("### Maintenance Schedule")
    maintenance_schedule = execute_query("SELECT * FROM maintenance")
    if maintenance_schedule:
        df_maintenance_schedule = pd.DataFrame(maintenance_schedule)
        st.write(df_maintenance_schedule)
    
    # Generate reports
    st.write("### Generate Report")
    with st.form(key="add_report_form"):
        report_date = st.date_input("Report Date")
        report_content = st.text_area("Report Content")
        submit_button = st.form_submit_button(label="Generate Report")
        
        if submit_button:
            query = "INSERT INTO reports (report_date, report_content) VALUES (%s, %s)"
            execute_query(query, (report_date, report_content))
            st.success("Report generated successfully")
    
    # Display reports
    st.write("### Reports")
    reports = execute_query("SELECT * FROM reports")
    if reports:
        df_reports = pd.DataFrame(reports)
        st.write(df_reports)
