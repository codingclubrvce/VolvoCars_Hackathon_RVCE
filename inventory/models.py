from django.db import models

class Asset(models.Model):
    asset_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    description = models.TextField()
    quantity = models.IntegerField()
    location = models.CharField(max_length=255)
    status = models.CharField(max_length=50)

    def __str__(self):
        return self.name

