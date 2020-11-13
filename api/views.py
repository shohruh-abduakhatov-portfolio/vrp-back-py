import json
import traceback

import requests
from datetime import datetime
from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import redirect
from rest_framework import generics
from rest_framework import status
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.response import Response
from rest_framework.views import APIView

from api.models import *
from api.serializers import OrderSerializer, SprintSerializer
from helper.firebase import push_to_firebase
from helper.model import _deserilize, save_sprint


class AuthTokenView(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'email': user.email
        })


class OrderListView(generics.ListAPIView):
    serializer_class = OrderSerializer


    # authentication_classes = [TokenAuthentication]
    # permission_classes = [IsAuthenticated]

    def get_queryset(self):
        print(self.request.user)
        # return Order.objects.all()
        return Order.objects.filter(status__in=[0, 1])


class OrderDeliveredView(APIView):
    def post(self, request, order_id):
        order_type = self.request.query_params.get('order_type')
        if not order_type: return Response("Order type not specified")
        try:
            sprint_node = Sprint.objects.get(status=0, order_id=order_id, order_type=order_type)
            try:
                sprint_node.status = 1
                sprint_node.save()
            except ObjectDoesNotExist as ex:
                return Response("could not save sprint", status=status.HTTP_404_NOT_FOUND)
        except:
            str(traceback.print_exc())
            return Response("Such Sprint not found", status=status.HTTP_404_NOT_FOUND)
        if order_type == 'drop':
            try:
                order = Order.objects.get(id=order_id)
                order.status = 1
                order.save()
            except ObjectDoesNotExist as ex:
                return Response("could does not save order", status=status.HTTP_304_NOT_MODIFIED)
        return Response({
            "order_id": order_id,
            "order_status": 1,
            "order_status_text": 'completed',
            "order_status_code": 1
        })


class OrderRetrieveView(generics.RetrieveAPIView):
    serializer_class = OrderSerializer


    def get_object(self):
        try:
            order = Order.objects.get(id=self.kwargs.get('order_id'))
        except ObjectDoesNotExist as ex:
            raise Exception(ex)
        return order


class SprintRetrieveView(generics.RetrieveAPIView):
    serializer_class = SprintSerializer


    def get_object(self):
        return Sprint.objects.get(id=self.kwargs.get("order_id"))


class SprintListView(generics.ListAPIView):
    serializer_class = SprintSerializer


    def get_queryset(self):
        _driver_id = self.kwargs.get('driver_id')
        print(_driver_id)
        sprint = Sprint.objects.filter(driver_id=_driver_id, status=0)
        return sprint


class ReoptimizeView(APIView):

    def get(self, request):
        _input = _deserilize()
        url = settings.VRP_IP + 'optimize_route'
        _param = json.dumps(_input)
        response = requests.get(url, params={'data': _param})
        if response.status_code != 200: return
        save_sprint(data=json.loads(response.text))
        key = 'update'
        push_to_firebase(key, key, key, datetime.now().timestamp())
        print('redirect to admin')
        return redirect('/admin')

class FirebaseUpdateView(APIView):

    def get(self, request):
        key = 'update'
        _now=  datetime.now().timestamp()
        push_to_firebase(key, key, key, _now)
        return Response(str(_now))
