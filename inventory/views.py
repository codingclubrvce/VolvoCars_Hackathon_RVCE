from django.shortcuts import render, redirect
from .models import Asset
from .forms import AssetForm

def asset_list(request):
    assets = Asset.objects.all()
    return render(request, 'inventory/asset_list.html', {'assets': assets})

def asset_add(request):
    if request.method == 'POST':
        form = AssetForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('asset_list')
    else:
        form = AssetForm()
    return render(request, 'inventory/asset_form.html', {'form': form})

def asset_edit(request, pk):
    asset = Asset.objects.get(pk=pk)
    if request.method == 'POST':
        form = AssetForm(request.POST, instance=asset)
        if form.is_valid():
            form.save()
            return redirect('asset_list')
    else:
        form = AssetForm(instance=asset)
    return render(request, 'inventory/asset_form.html', {'form': form})

def asset_delete(request, pk):
    asset = Asset.objects.get(pk=pk)
    if request.method == 'POST':
        asset.delete()
        return redirect('asset_list')
    return render(request, 'inventory/asset_confirm_delete.html', {'asset': asset})
