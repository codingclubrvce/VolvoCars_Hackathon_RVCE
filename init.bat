@echo off

xcopy /s "application_default_credentials.json" "%APPDATA%/gcloud"

@echo on