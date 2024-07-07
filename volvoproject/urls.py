# volvo_asset_tracking/urls.py
from django.contrib import admin
from django.urls import path, include

app_name = 'myapp'

urlpatterns = [
    path('admin/', admin.site.urls),
    path('inventory/', include('inventory.urls')),
    path('spare_parts/', include('spare_parts.urls')),
    path('maintenance/', include('maintenance.urls')),
]
