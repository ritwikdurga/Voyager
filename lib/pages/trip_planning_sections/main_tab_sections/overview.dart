// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, must_be_immutable, no_leading_underscores_for_local_identifiers, unused_local_variable, unnecessary_import, non_constant_identifier_names, prefer_is_not_empty, avoid_print, unused_field

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/calender_picker.dart';
import 'package:voyager/components/search_section/date_section.dart';
import 'package:voyager/components/trip_planning_section/friends_icons.dart';
import 'package:voyager/components/trip_planning_section/profile_tile.dart';
import 'package:voyager/components/trip_planning_section/ticket_container.dart';
import 'package:voyager/home_screen.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_buses.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_cars.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_one_way.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_trains.dart';
import 'package:voyager/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class Item {
  String heading;
  String? notes;
  bool isExpanded;
  bool isEditing;

  Item({
    required this.heading,
    required this.notes,
    this.isExpanded = false,
    this.isEditing = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'heading': heading,
      'notes': notes,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      heading: json['heading'],
      notes: json['notes'],
      isExpanded: false,
      isEditing: false,
    );
  }
}

class OverviewTrips extends StatefulWidget {
  DocumentReference tripRef;
  OverviewTrips({required this.tripRef, super.key});
  @override
  State<OverviewTrips> createState() => _OverviewTripsState();
}

class _OverviewTripsState extends State<OverviewTrips> {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  late Stream<DocumentSnapshot> _tripStream;
  List<Item> _notes = [];
  List<TicketData> _flightTickets = [];
  List<TrainData> _trainTickets = [];
  List<BusData> _busTickets = [];
  List<CarData> _carTickets = [];
  List<XFile?> ImagesList = [];
  List<String> _imageURLs = [];
  late final MyIndexProvider _indexProvider;

  @override
  void initState() {
    super.initState();
    _tripStream = FirebaseFirestore.instance
        .collection('trips')
        .doc(widget.tripRef.id)
        .snapshots();
    _indexProvider = Provider.of<MyIndexProvider>(context, listen: false);
  }

  void updateNotesInFirestore(List<Item> notes) async {
    List<Map<String, dynamic>> notesData =
        notes.map((item) => item.toMap()).toList();
    await db.collection("trips").doc(widget.tripRef.id).set({
      'attachments': {
        'notes': notesData,
      }
    }, SetOptions(merge: true));
  }

  void updateflightTicketsInFirestore(List<TicketData> _flightTickets) async {
    List<Map<String, dynamic>> flightData =
        _flightTickets.map((item) => item.toJson()).toList();
    await db.collection("trips").doc(widget.tripRef.id).set({
      'attachments': {
        'flightTickets': flightData,
      }
    }, SetOptions(merge: true));
  }

  void updatetrainTicketsInFirestore(List<TrainData> _trainTickets) async {
    List<Map<String, dynamic>> trainData =
        _trainTickets.map((item) => item.toMap()).toList();
    await db.collection("trips").doc(widget.tripRef.id).set({
      'attachments': {
        'trainTickets': trainData,
      }
    }, SetOptions(merge: true));
  }

  void updatebusTicketsInFirestore(List<BusData> _busTickets) async {
    List<Map<String, dynamic>> busDataMap =
        _busTickets.map((item) => item.toMap()).toList();
    await db.collection("trips").doc(widget.tripRef.id).set({
      'attachments': {
        'busTickets': busDataMap,
      }
    }, SetOptions(merge: true));
  }

  void updateCarDataInFirestore(List<CarData> carData) async {
    List<Map<String, dynamic>> carDataMap =
        carData.map((item) => item.toMap()).toList();
    await db.collection("trips").doc(widget.tripRef.id).set({
      'attachments': {
        'carData': carDataMap,
      }
    }, SetOptions(merge: true));
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        ImagesList.add(returnedImage);
        uploadFile(File(returnedImage.path));
      });
    }
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        ImagesList.add(returnedImage);
        uploadFile(File(returnedImage.path));
      });
    }
  }

  Future uploadFile(File photo) async {
    final String fileName = path.basename(photo.path);
    final String fileType = path.extension(photo.path).substring(1);
    final destination =
        storage.ref().child("trip/${widget.tripRef.id}/images/$fileName");
    try {
      await destination.putFile(
          photo,
          SettableMetadata(
            contentType: "image/$fileType",
          ));
      var url = await destination.getDownloadURL();
      _imageURLs.add(url);
      await db.collection("trips").doc(widget.tripRef.id).set({
        'attachments': {
          'images': FieldValue.arrayUnion([url]),
        }
      }, SetOptions(merge: true));
    } catch (e) {
      print('error occured');
    }
  }

  void AttachForFlights(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ),
            SizedBox(
              height: screenHeight / 2 - 10,
              width: screenWidth,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Flights',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Import your flight reservation details',
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormForOneWay(
                                            onTicketAdded: (ticketsData) {
                                              setState(() {
                                                _flightTickets
                                                    .addAll(ticketsData!);
                                                updateflightTicketsInFirestore(
                                                    _flightTickets);
                                              });
                                            },
                                          )));
                            },
                            child: Text(
                              'Add Manually',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                              _indexProvider.setMyIndex(1);
                            },
                            child: Text(
                              'Search for Flights',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void AttachForAttachments(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ),
            SizedBox(
              height: screenHeight / 2 - 10,
              width: screenWidth,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Attachments',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Take a Photo or Import your photos from the gallery',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 25, 5, 5),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _pickImageFromCamera();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              'Take Photo',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _pickImageFromGallery();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              'Add Photo from Gallery',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void AttachForTrains(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ),
            SizedBox(
              height: screenHeight / 2 - 10,
              width: screenWidth,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add Trains',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Import your train reservation details',
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormForTrain(
                                            onTrainTicketAdded: (traindata) {
                                              setState(() {
                                                _trainTickets.add(traindata);
                                                updatetrainTicketsInFirestore(
                                                    _trainTickets);
                                              });
                                            },
                                          )));
                            },
                            child: Text(
                              'Add Manually',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                            _indexProvider.setMyIndex(1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              },
                              child: Text(
                                'Search for Trains',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  bool areNotesEqual(List<Item> list1, List<Item> list2) {
    if (list1.length != list2.length) {
      return false;
    }
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].heading != list2[i].heading ||
          list1[i].notes != list2[i].notes) {
        return false;
      }
    }
    return true;
  }

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

  bool areTicketDataObjectsEqual(
      TicketData ticketData1, TicketData ticketData2) {
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _tripStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (snapshot.hasData) {
            var data = snapshot.data;
            List<Item> notes = [];
            try {
              if (data?['attachments'] != null &&
                  data?['attachments']['notes'] != null) {
                notes = List<Item>.from(data?['attachments']['notes']
                    .map((item) => Item.fromJson(item)));
              }
            } catch (e) {
              notes = [];
            }
            if (!areNotesEqual(_notes, notes)) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  _notes = notes;
                });
              });
            }
            List<String> imageURLs = [];
            try {
              if (data?['attachments'] != null &&
                  data?['attachments']['images'] != null) {
                imageURLs = List<String>.from(data?['attachments']['images']);
              }
            } catch (e) {
              _imageURLs = [];
            }
            if (!listEquals(_imageURLs, imageURLs)) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  _imageURLs = imageURLs;
                });
              });
            }
            List<TicketData> flightTickets = [];
            try {
              if (data?['attachments'] != null &&
                  data?['attachments']['flightTickets'] != null) {
                flightTickets = List<TicketData>.from(data?['attachments']
                        ['flightTickets']
                    .map((item) => TicketData.fromJSON(item)));
              }
            } catch (e) {
              _flightTickets = [];
            }
            if (!areTicketDataListsEqual(_flightTickets, flightTickets)) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  _flightTickets = flightTickets;
                });
              });
            }
            List<TrainData> trainTickets = [];
            try {
              if (data?['attachments'] != null &&
                  data?['attachments']['trainTickets'] != null) {
                trainTickets = List<TrainData>.from(data?['attachments']
                        ['trainTickets']
                    .map((item) => TrainData.fromMap(item)));
              }
            } catch (e) {
              _trainTickets = [];
            }
            if (!areTrainDataListsEqual(_trainTickets, trainTickets)) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  _trainTickets = trainTickets;
                });
              });
            }
            List<BusData> busTickets = [];
            try {
              if (data?['attachments'] != null &&
                  data?['attachments']['busTickets'] != null) {
                busTickets = List<BusData>.from(data?['attachments']
                        ['busTickets']
                    .map((item) => BusData.fromMap(item)));
              }
            } catch (e) {
              _busTickets = [];
            }
            if (!areBusDataListsEqual(_busTickets, busTickets)) {
              print(_busTickets);
              print(1);
              print(busTickets);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  _busTickets = busTickets;
                });
              });
            }
            List<CarData> carTickets = [];
            try {
              if (data?['attachments'] != null &&
                  data?['attachments']['carData'] != null) {
                carTickets = List<CarData>.from(data?['attachments']['carData']
                    .map((item) => CarData.fromMap(item)));
              }
            } catch (e) {
              _carTickets = [];
            }
            if (!areCarDataListsEqual(_carTickets, carTickets)) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  _carTickets = carTickets;
                });
              });
            }
            return buildWidgetTree(context);
          }
          return const SizedBox();
        });
  }

  Widget buildWidgetTree(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                children: [
                  Text(
                    'Your Tripmates',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 8, 4),
                    child: SizedBox(
                      height: 85,
                      width: screenWidth - 50,
                      child: FriendsIcons(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Text(
                    'Reservations and Attachments',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 60,
              width: screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () {
                          AttachForFlights(context);
                        },
                        child: SizedBox(
                          width: screenWidth / 5 - 15,
                          height: 80,
                          child: Column(
                            children: [
                              Icon(
                                Iconsax.airplane,
                                size: 40,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              // Spacer(),
                              Text(
                                'Flights',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 22),
                        child: VerticalDivider(
                          thickness: 0.25,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 5 - 15,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {
                            AttachForTrains(context);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.train_outlined,
                                size: 42,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              // Spacer(),
                              Text(
                                'Trains',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 22),
                        child: VerticalDivider(
                          thickness: 0.25,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 5 - 15,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormForBuses(
                                          onBusAdded: (busdata) {
                                            setState(() {
                                              _busTickets.add(busdata);
                                              updatebusTicketsInFirestore(
                                                  _busTickets);
                                            });
                                          },
                                        )));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Iconsax.bus,
                                size: 38,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              // Spacer(),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Buses',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 22),
                        child: VerticalDivider(
                          thickness: 0.25,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 5 - 15,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormForCars(
                                          onCarAdded: (cardata) {
                                            setState(() {
                                              _carTickets.add(cardata);
                                              updateCarDataInFirestore(
                                                  _carTickets);
                                            });
                                          },
                                        )));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Iconsax.car,
                                size: 35,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              // Spacer(),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Cars',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 22),
                        child: VerticalDivider(
                          thickness: 0.25,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 5 - 15,
                        child: GestureDetector(
                          onTap: () {
                            AttachForAttachments(context);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Iconsax.attach_square4,
                                size: 40,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              // Spacer(),
                              Text(
                                'Attach',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            if (!_flightTickets.isEmpty)
              ExpansionTile(
                title: Row(
                  children: [
                    Icon(Icons.flight, color: Colors.blueAccent),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Your Flight Tickets',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                initiallyExpanded: false,
                children: [
                  SizedBox(
                    height: 395,
                    width: screenWidth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _flightTickets.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.025 * screenWidth,
                          ),
                          child: TicketContainer(
                            DepartLocation: _flightTickets[index].fromAirport,
                            topText: '',
                            fromDate: _flightTickets[index].fromDate,
                            fromTime: _flightTickets[index].fromTime,
                            ArrivalLocation: _flightTickets[index].toAirport,
                            bottomText: '',
                            toDate: _flightTickets[index].toDate,
                            toTime: _flightTickets[index].toTime,
                            transitCarrier:
                                '${_flightTickets[index].flightOperator}-${_flightTickets[index].flightNumber}',
                            price: _flightTickets[index].price,
                            operaterHeading: 'FLIGHT OPERATER',
                            index: index,
                            onDeleted: (index) {
                              setState(() {
                                _flightTickets.removeAt(index);
                                updateflightTicketsInFirestore(_flightTickets);
                              });
                            },
                            updateNotes: (value) {
                              setState(() {
                                _flightTickets[index].note = value;
                                updateflightTicketsInFirestore(_flightTickets);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            if (!_trainTickets.isEmpty)
              ExpansionTile(
                title: Row(
                  children: [
                    Icon(Icons.train, color: Colors.blueAccent),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Your Train Tickets',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                initiallyExpanded: false,
                children: [
                  SizedBox(
                    height: 395,
                    width: screenWidth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _trainTickets.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.025 * screenWidth,
                          ),
                          child: TicketContainer(
                            DepartLocation: _trainTickets[index].fromStation,
                            topText: '',
                            fromDate: _trainTickets[index].fromDate,
                            fromTime: _trainTickets[index].fromTime,
                            ArrivalLocation: _trainTickets[index].toStation,
                            bottomText: '',
                            toDate: _trainTickets[index].toDate,
                            toTime: _trainTickets[index].toTime,
                            transitCarrier:
                                '${_trainTickets[index].trainOperator}-${_trainTickets[index].trainNumber}',
                            price: _trainTickets[index].price,
                            operaterHeading: 'TRAIN OPERATER',
                            index: index,
                            onDeleted: (index) {
                              setState(() {
                                _trainTickets.removeAt(index);
                                updatetrainTicketsInFirestore(_trainTickets);
                              });
                            },
                            updateNotes: (value) {
                              setState(() {
                                _trainTickets[index].note = value;
                                updatetrainTicketsInFirestore(_trainTickets);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            if (!_busTickets.isEmpty)
              ExpansionTile(
                title: Row(
                  children: [
                    Icon(Iconsax.bus, color: Colors.blueAccent),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Your Bus Tickets',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                initiallyExpanded: false,
                children: [
                  SizedBox(
                    height: 395,
                    width: screenWidth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _busTickets.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.025 * screenWidth,
                          ),
                          child: TicketContainer(
                            DepartLocation: _busTickets[index].fromBusStop,
                            topText: '',
                            fromDate: _busTickets[index].fromDate,
                            fromTime: _busTickets[index].fromTime,
                            ArrivalLocation: _busTickets[index].toBusStop,
                            bottomText: '',
                            toDate: _busTickets[index].toDate,
                            toTime: _busTickets[index].toTime,
                            transitCarrier: _busTickets[index].busOperator,
                            price: _busTickets[index].price,
                            operaterHeading: 'BUS OPERATER',
                            index: index,
                            updateNotes: (value) {
                              setState(() {
                                _busTickets[index].note = value;
                                updatebusTicketsInFirestore(_busTickets);
                              });
                            },
                            onDeleted: (index) {
                              setState(() {
                                _busTickets.removeAt(index);
                                updatebusTicketsInFirestore(_busTickets);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            if (!_carTickets.isEmpty)
              ExpansionTile(
                title: Row(
                  children: [
                    Icon(Iconsax.car, color: Colors.blueAccent),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Your Car Tickets',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                initiallyExpanded: false,
                children: [
                  SizedBox(
                    height: 395,
                    width: screenWidth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _carTickets.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.025 * screenWidth,
                          ),
                          child: TicketContainer(
                            DepartLocation: _carTickets[index].fromPlace,
                            topText: '',
                            fromDate: _carTickets[index].fromDate,
                            fromTime: _carTickets[index].fromTime,
                            ArrivalLocation: _carTickets[index].toPlace,
                            bottomText: '',
                            toDate: _carTickets[index].toDate,
                            toTime: _carTickets[index].toTime,
                            transitCarrier: _carTickets[index].carOperator,
                            price: _carTickets[index].price,
                            operaterHeading: 'Car OPERATER',
                            index: index,
                            onDeleted: (index) {
                              setState(() {
                                _carTickets.removeAt(index);
                                updateCarDataInFirestore(_carTickets);
                              });
                            },
                            updateNotes: (value) {
                              setState(() {
                                _carTickets[index].note = value;
                                updateCarDataInFirestore(_carTickets);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            if (_imageURLs.isNotEmpty)
              ExpansionTile(
                title: Row(
                  children: [
                    Icon(Iconsax.attach_square4, color: Colors.blueAccent),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Your Attachments',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                initiallyExpanded: false,
                children: [
                  SizedBox(
                    height: 395,
                    width: screenWidth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _imageURLs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.025 * screenWidth,
                          ),
                          child: Image.network(
                            _imageURLs[index],
                            height: 350,
                            width: 0.95 * screenWidth,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.notes,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        _notes.add(Item(
                            heading: 'Note ${_notes.length + 1}', notes: null));
                        updateNotesInFirestore(_notes);
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _notes[index].isExpanded = isExpanded;
                    if (isExpanded == false) {
                      _notes[index].isEditing = false;
                    }
                  });
                },
                elevation: 0,
                materialGapSize: 5,
                children: _notes.asMap().entries.map<ExpansionPanel>((entry) {
                  Item item = entry.value;
                  TextEditingController _controller =
                      TextEditingController(text: item.heading);
                  bool _isEditing = item.isEditing;
                  TextEditingController _controllerForBody =
                      TextEditingController();
                  if (item.notes != null) {
                    _controllerForBody.text = item.notes!;
                  }
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.grey.shade800
                        : Colors.grey.shade100,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Row(
                        children: [
                          Expanded(
                            child: _isEditing
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 38.0),
                                    child: TextFormField(
                                        initialValue: item.heading,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            _isEditing = false;
                                            item.isEditing = false;
                                            item.heading = value;
                                            updateNotesInFirestore(_notes);
                                          });
                                        }),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 38.0),
                                    child: Text(
                                      item.heading,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                          ),
                          if (isExpanded)
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    setState(() {
                                      _isEditing = !_isEditing;
                                      item.isEditing = !item.isEditing;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _notes.removeWhere((Item currentItem) =>
                                          item == currentItem);
                                      updateNotesInFirestore(_notes);
                                    });
                                  },
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                    body: TextField(
                        controller: _controllerForBody,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText:
                              item.notes != null ? null : 'Tap to write notes',
                        ),
                        maxLines: null,
                        onSubmitted: (value) {
                          setState(() {
                            item.notes = value;
                            updateNotesInFirestore(_notes);
                          });
                        }),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  final themeProvider = Provider.of<ThemeProvider>(context);
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          SizedBox(
            height: screenHeight / 2 - 10,
            child: ListView.builder(
              itemCount: 100,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (bc, index) {
                return ProfileTile();
              },
            ),
          ),
        ],
      );
    },
  );
}
