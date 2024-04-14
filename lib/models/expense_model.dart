// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String getCategoryFromIcon(Icon icon) {
  switch (icon.icon) {
    case Icons.airplanemode_active:
      return 'Flights';
    case Icons.hotel:
      return 'Lodging';
    case Icons.directions_car:
      return 'Car Rental';
    case Icons.directions_transit:
      return 'Transit';
    case Icons.restaurant:
      return 'Food';
    case Icons.local_bar:
      return 'Drinks';
    case Icons.landscape:
      return 'Sightseeing';
    case Icons.local_activity:
      return 'Activities';
    case Icons.shopping_bag:
      return 'Shopping';
    case Icons.local_gas_station:
      return 'Gas';
    case Icons.local_grocery_store:
      return 'Groceries';
    default:
      return 'Other';
  }
}

Icon _getIconForCategory(String category) {
  switch (category) {
    case 'Flights':
      return const Icon(Icons.airplanemode_active);
    case 'Lodging':
      return const Icon(Icons.hotel);
    case 'Car Rental':
      return const Icon(Icons.directions_car);
    case 'Transit':
      return const Icon(Icons.directions_transit);
    case 'Food':
      return const Icon(Icons.restaurant);
    case 'Drinks':
      return const Icon(Icons.local_bar);
    case 'Sightseeing':
      return const Icon(Icons.landscape);
    case 'Activities':
      return const Icon(Icons.local_activity);
    case 'Shopping':
      return const Icon(Icons.shopping_bag);
    case 'Gas':
      return const Icon(Icons.local_gas_station);
    case 'Groceries':
      return const Icon(Icons.local_grocery_store);
    default:
      return const Icon(Icons.category);
  }
}

class ExpenseData {
  String rupeeValue;
  Icon? selectedIcon;
  Map<String, dynamic> PaidBy;
  List<Map<String, dynamic>>? Split;
  DateTime? Date;
  DateTime? creationTime;

  ExpenseData({
    required this.rupeeValue,
    required this.selectedIcon,
    required this.PaidBy,
    required this.Split,
    required this.Date,
    required this.creationTime,
  });

  factory ExpenseData.fromMap(Map<String, dynamic> map) {
    Timestamp creationTimestamp = map['creationTime'];
    return ExpenseData(
      rupeeValue: map['rupeeValue'],
      selectedIcon: _getIconForCategory(map['selectedIcon']),
      PaidBy: map['PaidBy'],
      Split: map['Split'] != null
          ? List<Map<String, dynamic>>.from(map['Split'].map((item) {
              return {'name': item['name'], 'uid': item['uid']};
            }))
          : null,
      Date: map['Date'] != null ? DateTime.parse(map['Date']) : null,
      creationTime: creationTimestamp.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rupeeValue': rupeeValue,
      'selectedIcon': getCategoryFromIcon(selectedIcon!),
      'PaidBy': PaidBy,
      'Split': Split,
      'Date': Date?.toIso8601String(),
      'creationTime': creationTime,
    };
  }

  bool isEqualTo(ExpenseData other) {
    return rupeeValue == other.rupeeValue &&
        selectedIcon == other.selectedIcon &&
        PaidBy == other.PaidBy &&
        _compareSplit(Split, other.Split) &&
        Date == other.Date &&
        creationTime == other.creationTime;
  }

  bool _compareSplit(
      List<Map<String, dynamic>>? list1, List<Map<String, dynamic>>? list2) {
    if (list1 == null && list2 == null) {
      return true;
    }
    if (list1 == null || list2 == null || list1.length != list2.length) {
      return false;
    }
    for (int i = 0; i < list1.length; i++) {
      if (list1[i]['name'] != list2[i]['name'] ||
          list1[i]['uid'] != list2[i]['uid']) {
        return false;
      }
    }
    return true;
  }
}
