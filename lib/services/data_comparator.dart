import 'package:voyager/models/expense_model.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_buses.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_cars.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_one_way.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_trains.dart';

bool areBusDataListsEqual(List<BusData> list1, List<BusData> list2) {
  if (list1.length != list2.length) {
    return false;
  }
  for (int i = 0; i < list1.length; i++) {
    if (!areBusDataObjectsEqual(list1[i], list2[i])) {
      return false;
    }
  }
  return true;
}

bool areBusDataObjectsEqual(BusData busData1, BusData busData2) {
  return busData1.fromBusStop == busData2.fromBusStop &&
      busData1.toBusStop == busData2.toBusStop &&
      busData1.price == busData2.price &&
      busData1.busOperator == busData2.busOperator &&
      busData1.fromDate == busData2.fromDate &&
      busData1.toDate == busData2.toDate &&
      busData1.fromTime == busData2.fromTime &&
      busData1.toTime == busData2.toTime &&
      busData1.note == busData2.note;
}

bool areCarDataListsEqual(List<CarData> list1, List<CarData> list2) {
  if (list1.length != list2.length) {
    return false;
  }
  for (int i = 0; i < list1.length; i++) {
    if (!areCarDataObjectsEqual(list1[i], list2[i])) {
      return false;
    }
  }
  return true;
}

bool areCarDataObjectsEqual(CarData carData1, CarData carData2) {
  return carData1.fromPlace == carData2.fromPlace &&
      carData1.toPlace == carData2.toPlace &&
      carData1.price == carData2.price &&
      carData1.carOperator == carData2.carOperator &&
      carData1.fromDate == carData2.fromDate &&
      carData1.toDate == carData2.toDate &&
      carData1.fromTime == carData2.fromTime &&
      carData1.toTime == carData2.toTime &&
      carData1.note == carData2.note;
}

bool areTrainDataListsEqual(List<TrainData> list1, List<TrainData> list2) {
  if (list1.length != list2.length) {
    return false;
  }
  for (int i = 0; i < list1.length; i++) {
    if (!areTrainDataObjectsEqual(list1[i], list2[i])) {
      return false;
    }
  }
  return true;
}

bool areTrainDataObjectsEqual(TrainData trainData1, TrainData trainData2) {
  return trainData1.fromStation == trainData2.fromStation &&
      trainData1.toStation == trainData2.toStation &&
      trainData1.topText == trainData2.topText &&
      trainData1.bottomText == trainData2.bottomText &&
      trainData1.price == trainData2.price &&
      trainData1.trainNumber == trainData2.trainNumber &&
      trainData1.trainOperator == trainData2.trainOperator &&
      trainData1.fromDate == trainData2.fromDate &&
      trainData1.toDate == trainData2.toDate &&
      trainData1.fromTime == trainData2.fromTime &&
      trainData1.toTime == trainData2.toTime &&
      trainData1.note == trainData2.note;
}

bool areTicketDataListsEqual(List<TicketData> list1, List<TicketData> list2) {
  if (list1.length != list2.length) {
    return false;
  }
  for (int i = 0; i < list1.length; i++) {
    if (!areTicketDataObjectsEqual(list1[i], list2[i])) {
      return false;
    }
  }
  return true;
}

bool areTicketDataObjectsEqual(TicketData ticketData1, TicketData ticketData2) {
  return ticketData1.fromAirport == ticketData2.fromAirport &&
      ticketData1.toAirport == ticketData2.toAirport &&
      ticketData1.topText == ticketData2.topText &&
      ticketData1.bottomText == ticketData2.bottomText &&
      ticketData1.price == ticketData2.price &&
      ticketData1.isLastItem == ticketData2.isLastItem &&
      ticketData1.passengers == ticketData2.passengers &&
      ticketData1.duration == ticketData2.duration &&
      ticketData1.flightNumber == ticketData2.flightNumber &&
      ticketData1.flightOperator == ticketData2.flightOperator &&
      ticketData1.fromDate == ticketData2.fromDate &&
      ticketData1.toDate == ticketData2.toDate &&
      ticketData1.fromTime == ticketData2.fromTime &&
      ticketData1.toTime == ticketData2.toTime &&
      ticketData1.note == ticketData2.note;
}

bool areArraysEqual(List<dynamic> array1, List<dynamic> array2) {
  if (array1.length != array2.length) {
    return false;
  }
  for (int i = 0; i < array1.length; i++) {
    if (array1[i] != array2[i]) {
      return false;
    }
  }
  return true;
}

bool areExpenseDataListsEqual(
    List<ExpenseData> list1, List<ExpenseData> list2) {
  if (list1.length != list2.length) {
    return false;
  }

  for (int i = 0; i < list1.length; i++) {
    if (list1[i].creationTime != (list2[i].creationTime) ||
        list1[i].PaidBy['uid'] != list2[i].PaidBy['uid']) {
      return false;
    }
  }

  return true;
}
