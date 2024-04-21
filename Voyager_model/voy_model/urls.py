from django.urls import path
from .views import ListView,LocView,LocsView

urlpatterns = [
    path('', ListView.as_view(), name='model'),
    path('getloc/',LocView.as_view(),name='loc'),
    path('getallloc/',LocsView.as_view(),name='all_loc'),
]
