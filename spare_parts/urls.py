from django.urls import path
from . import views

urlpatterns = [
    path('', views.spare_part_list, name='spare_part_list'),
    path('add/', views.spare_part_add, name='spare_part_add'),
    path('edit/<int:pk>/', views.spare_part_edit, name='spare_part_edit'),
    path('delete/<int:pk>/', views.spare_part_delete, name='spare_part_delete'),
]
