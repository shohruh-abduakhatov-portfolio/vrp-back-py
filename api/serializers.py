from rest_framework import serializers

from api.models import Order, Sprint, User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


class GeoPointSerializer(serializers.Serializer):
    lat = serializers.FloatField(source='x')
    lon = serializers.FloatField(source='y')


class OrderSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    pick_point = GeoPointSerializer()
    drop_point = GeoPointSerializer()
    status = serializers.SerializerMethodField()

    class Meta:
        model = Order
        fields = ['id', 'user', 'pick_point', 'drop_point', 'drop_time_windows', 'drop_time_window_end',
                  'pick_time_window', 'pick_time_window_end', 'created_at', 'capacity', 'weight', 'status']

    def get_status(self, object):
        return {
            "status_id": object.status,
            "status_label": object.get_status_display()
        }


class SprintSerializer(serializers.ModelSerializer):
    order = OrderSerializer(read_only=True)

    class Meta:
        model = Sprint
        fields = ['id', 'status', 'lateness', 'created_at', 'start_time', 'finish_time', 'driver_id',
                  'order_id', 'order_type', 'order']
        ordering = 'status'
