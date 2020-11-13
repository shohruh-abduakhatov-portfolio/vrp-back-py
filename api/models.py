from django.contrib.auth.models import AbstractUser
from django.contrib.auth.validators import UnicodeUsernameValidator
from django.contrib.gis.db import models as geo_models
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils import timezone
from rest_framework.authtoken.models import Token

from api import manager as account_manager
from middleware import settings


class User(AbstractUser):
    DRIVER = 'super_admin'
    ADMIN = 'admin'

    USER_TYPES = (
        (DRIVER, "Driver",),
        (ADMIN, "Admin",),
    )
    """
    An abstract base class implementing a fully featured User model with
    admin-compliant permissions.

    Username and password are required. Other fields are optional.
    """
    username_validator = UnicodeUsernameValidator()
    dob = models.DateField(null=True)
    phone = models.CharField(max_length=60, null=True)
    username = models.CharField(
        'username',
        max_length=150,
        unique=True,
        help_text='Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.',
        validators=[username_validator],
        error_messages={
            'unique': "A user with that username already exists.",
        },
    )
    first_name = models.CharField('first name', max_length=30, blank=True)
    last_name = models.CharField('last name', max_length=150, blank=True)
    email = models.EmailField('email address', blank=True, null=True)
    user_type = models.CharField(max_length=60, choices=USER_TYPES)

    is_active = models.BooleanField(
        'active',
        default=True,
        help_text=(
            'Designates whether this user should be treated as active. '
            'Unselect this instead of deleting accounts.'
        ),
    )
    date_joined = models.DateTimeField('date joined', default=timezone.now)

    objects = account_manager.UserManager()

    EMAIL_FIELD = 'email'
    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']


    def clean(self):
        super().clean()
        self.email = self.__class__.objects.normalize_email(self.email)


    def get_full_name(self):
        """
        Return the first_name plus the last_name, with a space in between.
        """
        full_name = '%s %s' % (self.first_name, self.last_name)
        return full_name.strip()


    def get_short_name(self):
        """Return the short name for the user."""
        return self.first_name


class Driver(models.Model):
    TRUCK = 1
    LIGHTWEIGHT = 2

    CAR_TYPES = (
        (TRUCK, "Truck"),
        (LIGHTWEIGHT, "Lightweight")
    )

    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='drivers')
    car_speed = models.IntegerField()
    car_type = models.IntegerField(choices=CAR_TYPES, default=1)
    shift_start = models.DateTimeField(null=True, blank=True)
    shift_end = models.DateTimeField(null=True, blank=True)


class Order(geo_models.Model):
    NOT_STARTED = 0
    ON_PROCESS = 1
    FINISHED = 2
    CANCELLED = 3

    STATUSES = (
        (NOT_STARTED, "Not started"),
        (ON_PROCESS, "On process"),
        (FINISHED, "Finished"),
        (CANCELLED, "Cancelled")
    )

    user = geo_models.ForeignKey('User', on_delete=models.CASCADE, related_name='user_orders')
    pick_time_window = geo_models.DateTimeField(null=True, blank=True)
    drop_time_windows = geo_models.DateTimeField(null=True, blank=True)
    pick_time_window_end = geo_models.DateTimeField(null=True, blank=True)
    drop_time_window_end = geo_models.DateTimeField(null=True, blank=True)
    pick_point = geo_models.PointField(max_length=255)
    drop_point = geo_models.PointField(max_length=255)
    created_at = geo_models.DateTimeField(auto_now=True)
    capacity = geo_models.IntegerField(default=1)
    weight = geo_models.FloatField(default=1)
    status = geo_models.IntegerField(choices=STATUSES, default=NOT_STARTED)


    def save(self, force_insert=False, force_update=False, using=None, update_fields=None):
        print('in')
        super().save(force_insert, force_update, using, update_fields)
        # todo get data from
        print('out')


class Sprint(models.Model):
    PICK = 'pick'
    DROP = 'drop'

    TYPES = (
        (PICK, "Pick",),
        (DROP, "Drop",),
    )

    status = models.IntegerField(default=1)
    lateness = models.DateTimeField(null=True, blank=True)
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='order_sprints')
    created_at = models.DateTimeField(auto_now=True)
    start_time = models.DateTimeField(null=True, blank=True)
    finish_time = models.DateTimeField(null=True, blank=True)
    driver = models.ForeignKey(Driver, on_delete=models.CASCADE, related_name='driver_sprints')
    order_type = models.CharField(max_length=10, choices=TYPES, default=DROP)


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)
