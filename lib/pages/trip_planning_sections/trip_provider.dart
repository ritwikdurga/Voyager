import 'package:flutter/cupertino.dart';
import 'package:voyager/models/trip_model.dart';

class TripsProvider extends ChangeNotifier {
  List<Trip> _tripList = [];

  List<Trip> get tripList => _tripList;

  set tripList(List<Trip> value) {
    _tripList = value;
    notifyListeners();
  }
}
