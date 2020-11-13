from django import forms
from django.contrib.gis.geos import Point

from mapwidgets.widgets import GooglePointFieldWidget, GoogleStaticOverlayMapWidget

from api.models import Order


class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = ('drop_point', 'pick_point', 'pick_time_window', 'pick_time_window_end', 'drop_time_windows',
                  'drop_time_window_end', 'capacity', 'weight', 'user', 'status' )
        widgets = {
            'drop_point': GooglePointFieldWidget,
            'pick_point': GooglePointFieldWidget
        }
