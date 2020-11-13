from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as DjangoUserAdmin

from api import models as account_models
# Register your models here.
from api.forms import OrderForm


@admin.register(account_models.User)
class UserAdmin(DjangoUserAdmin, admin.ModelAdmin):
    fieldsets = (
        ('Main', {'fields': ('username', 'password')}),
        ('Personal info', {'fields': ('first_name', 'last_name', 'user_type', 'phone', 'email',)}),
        ('Permissions', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login',)}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'password1', 'password2', 'phone', 'first_name', 'last_name', 'user_type',),
        }),
    )
    list_display = ('get_fullname', 'user_type', 'date_joined',)
    list_filter = ('user_type',)
    search_fields = ('email', 'first_name', 'last_name', 'phone',)
    ordering = ('email',)


    @staticmethod
    def get_fullname(obj):
        if obj.first_name or obj.last_name:
            return "{} {}".format(obj.first_name, obj.last_name)
        return "{}".format(obj.username)


class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'created_at', 'capacity', 'weight', 'status')
    search_fields = ('created_at',)
    form = OrderForm
    change_list_template = "reoptimize.html"


class DriverAdmin(admin.ModelAdmin):
    list_display = ('id', 'car_type', 'car_speed', 'shift_start', 'shift_end')
    search_fields = ('car_type',)


class SprintAdmin(admin.ModelAdmin):
    list_display = ('id', 'status', 'start_time', 'finish_time', 'order_type')
    search_fields = ('created_at',)


# class MyAdminSite(admin.AdminSite):
#     index_template = "admin.html"
#     # app_index_template = "admin.html"
#     site_header = 'Vehicle Route Optimization administration'
#
#
# mysite = MyAdminSite()
# admin.site = mysite
# admin.sites.site = mysite
admin.site.register(account_models.Order, OrderAdmin)
admin.site.register(account_models.Driver, DriverAdmin)
admin.site.register(account_models.Sprint, SprintAdmin)
