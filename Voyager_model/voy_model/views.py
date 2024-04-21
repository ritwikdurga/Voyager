import json
from django.http import JsonResponse
from django.views import View
from . import x

class ListView(View):
    def get(self, request, *args, **kwargs):
        param1 = request.GET.get('param1', '').split(',')
        param2 = int(request.GET.get('param2', 0))
        param3 = int(request.GET.get('param3', 0))
        param4 = request.GET.get('param4', '')
        param5 = request.GET.get('param5', '')
        param6 = request.GET.get('param6', '')
        json_string = x.FINAL(param1, param2, param3, param4, param5, param6)
        json_data = json.loads(json_string)
        return JsonResponse(json_data)


class LocView(View):
    def get(self, request, *args, **kwargs):
        param1 = request.GET.get('param1', '')
        param2 = request.GET.get('param2', '')
        json_string = x.location(param1, param2)
        return JsonResponse(json_string)
    
class LocsView(View):
    def get(self, request, *args, **kwargs):
        param1 = request.GET.get('param1', '')
        json_string = x.getallloc(param1)
        return JsonResponse(json_string)

