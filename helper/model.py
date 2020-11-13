from datetime import datetime

from api.models import *


def _deserilize():
    drivers = Driver.objects.all()
    orders = Order.objects.filter(status__in=[0,1])
    _input = {}
    _drivers_dict = {}
    for driver in drivers:
        _drivers_dict[str(driver.id)] = {
            'car_speed': driver.car_speed,
            'car_type': driver.car_type
        }

    _orders_dict = {}
    for order in orders:
        _orders_dict[str(order.id)] = {
            'pick_time_window': order.pick_time_window.timestamp(),
            'drop_time_window': order.drop_time_windows.timestamp(),
            'pick_time_window_end': order.pick_time_window_end.timestamp(),
            'drop_time_window_end': order.drop_time_window_end.timestamp(),
            'pick_lat': order.pick_point[1],
            'pick_long': order.pick_point[0],
            'drop_lat': order.drop_point[1],
            'drop_long': order.drop_point[0],
            'capacity': order.capacity,
            'weight': order.weight,
        }
    _input['drivers'] = _drivers_dict
    _input['orders'] = _orders_dict
    return _input


def save_sprint(data):
    _driver_id_list = list(data['solution'].keys())

    for driver_id in _driver_id_list:
        sprint_list = Sprint.objects.filter(driver_id=driver_id, status=0)
        if not sprint_list: continue
        for sprint in sprint_list:
            sprint.status = 1
            sprint.save()

    for driver_id, route in list(data['solution'].items()):
        # new_sprint_list = []
        driver = Driver.objects.get(pk=int(driver_id))
        if not driver: continue
        for order_id, order in route['route'].items():
            try:
                _order = Order.objects.get(pk=int(order['order_id']))
            except:
                continue
            sprint = Sprint()
            sprint.driver_id = driver.pk
            sprint.order_id = _order.pk
            sprint.created_at = datetime.now()
            sprint.lateness = datetime.now()
            sprint.start_time = datetime.fromtimestamp(order['time_min'])
            sprint.finish_time = datetime.fromtimestamp(order['time_max'])
            sprint.order_type = order['type']
            sprint.status = 0
            sprint.save()
        print('ok')
        # Sprint.objects.bulk_create(new_sprint_list)
