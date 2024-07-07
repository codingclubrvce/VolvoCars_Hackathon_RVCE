from django.db import models
from inventory.models import Asset

class Maintenance(models.Model):
    maintenance_id = models.AutoField(primary_key=True)
    asset = models.ForeignKey(Asset, on_delete=models.CASCADE)
    scheduled_date = models.DateField()
    maintenance_status = models.CharField(max_length=50)
    notes = models.TextField()

    def __str__(self):
        return f"{self.asset.name} - {self.scheduled_date}"
