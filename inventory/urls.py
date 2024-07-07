from django.urls import path
from . import views

urlpatterns = [
    path('', views.asset_list, name='asset_list'),
    path('add/', views.asset_add, name='asset_add'),
    path('edit/<int:pk>/', views.asset_edit, name='asset_edit'),
    path('delete/<int:pk>/', views.asset_delete, name='asset_delete'),
]
