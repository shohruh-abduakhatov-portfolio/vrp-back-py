from django.contrib import admin
from django.urls import path, include
from rest_framework_swagger.views import get_swagger_view
from api.urls import urlpatterns as api_urlpatterns
from api.views import ReoptimizeView


schema_view = get_swagger_view(title="WIUT", url='/api/v1/', patterns=api_urlpatterns)

urlpatterns = [
    path('admin/api/order/reoptimize/', ReoptimizeView.as_view(), name='reoptimize_view'),
    path('admin/', admin.site.urls),
    path('', schema_view),
    path('api/v1/', include('api.urls'))
]
