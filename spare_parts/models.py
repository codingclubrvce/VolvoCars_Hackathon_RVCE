from django.db import models
from inventory.models import Asset

class SparePart(models.Model):
    part_id = models.AutoField(primary_key=True)
    asset = models.ForeignKey(Asset, on_delete=models.CASCADE)
    alias_name = models.CharField(max_length=255)
    description = models.TextField()
    quantity = models.IntegerField()
    location = models.CharField(max_length=255)

    def __str__(self):
        return self.alias_name

