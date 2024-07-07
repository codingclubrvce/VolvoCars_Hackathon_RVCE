from django.shortcuts import render, redirect
from .models import Maintenance, Event
from .forms import MaintenanceForm
from myapp.models import Calendar
import calendar

c = calendar.Calendar()

def maintenance_list(request):
    maintenance_records = Maintenance.objects.all()
    return render(request, 'maintenance/maintenance_list.html', {'maintenance_records': maintenance_records})

def maintenance_add(request):
    if request.method == 'POST':
        form = MaintenanceForm(request.POST)
        if form.is_valid():
            maintenance = form.save()
            # Create a calendar event for the maintenance
            calendar = Calendar.objects.get_or_create(name='Maintenance Schedule')[0]
            Event.objects.create(
                title=f'Maintenance for {maintenance.asset.name}',
                start=maintenance.date,
                end=maintenance.date,
                calendar=calendar,
            )
            return redirect('maintenance_list')
    else:
        form = MaintenanceForm()
    return render(request, 'maintenance/maintenance_form.html', {'form': form})

def maintenance_edit(request, pk):
    maintenance = Maintenance.objects.get(pk=pk)
    if request.method == 'POST':
        form = MaintenanceForm(request.POST, instance=maintenance)
        if form.is_valid():
            form.save()
            return redirect('maintenance_list')
    else:
        form = MaintenanceForm(instance=maintenance)
    return render(request, 'maintenance/maintenance_form.html', {'form': form})

def maintenance_delete(request, pk):
    maintenance = Maintenance.objects.get(pk=pk)
    if request.method == 'POST':
        maintenance.delete()
        return redirect('maintenance_list')
    return render(request, 'maintenance/maintenance_confirm_delete.html', {'maintenance': maintenance})
