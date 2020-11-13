from django.urls import path

from api import views as api_view
from api.views import OrderDeliveredView


urlpatterns = [
    path('api-auth-token/', api_view.AuthTokenView.as_view(), name='auth_token'),
    path('orders/', api_view.OrderListView.as_view(), name='order_list_view'),
    path('orders/<int:order_id>/', api_view.OrderRetrieveView.as_view(), name='order_list_view'),
    path('orders/<int:order_id>/update-status/', OrderDeliveredView.as_view()),
    path('drivers/<int:driver_id>/sprints/', api_view.SprintListView.as_view(), name='sprint_list_view'),
    path('sprints/<int:sprint_id>/', api_view.SprintRetrieveView.as_view(), name='sprint_list_view'),
    path('fb_update/', api_view.FirebaseUpdateView.as_view(), name='fb_update'),
    # path('reoptimize/', ReoptimizeView.as_view(), name='reoptimize_view'),
]
