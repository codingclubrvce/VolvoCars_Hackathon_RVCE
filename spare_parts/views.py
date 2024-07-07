from django.shortcuts import render, redirect
from .models import SparePart
from .forms import SparePartForm

def spare_part_list(request):
    spare_parts = SparePart.objects.all()
    return render(request, 'spare_parts/spare_part_list.html', {'spare_parts': spare_parts})

def spare_part_add(request):
    if request.method == 'POST':
        form = SparePartForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('spare_part_list')
    else:
        form = SparePartForm()
    return render(request, 'spare_parts/spare_part_form.html', {'form': form})

def spare_part_edit(request, pk):
    spare_part = SparePart.objects.get(pk=pk)
    if request.method == 'POST':
        form = SparePartForm(request.POST, instance=spare_part)
        if form.is_valid():
            form.save()
            return redirect('spare_part_list')
    else:
        form = SparePartForm(instance=spare_part)
    return render(request, 'spare_parts/spare_part_form.html', {'form': form})

def spare_part_delete(request, pk):
    spare_part = SparePart.objects.get(pk=pk)
    if request.method == 'POST':
        spare_part.delete()
        return redirect('spare_part_list')
    return render(request, 'spare_parts/spare_part_confirm_delete.html', {'spare_part': spare_part})
