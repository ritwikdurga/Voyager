// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, must_be_immutable, no_leading_underscores_for_local_identifiers, unused_local_variable, unnecessary_import, non_constant_identifier_names, prefer_is_not_empty

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
}

class OverviewTrips extends StatefulWidget {
  DocumentReference? tripRef;
  OverviewTrips({required this.tripRef, super.key});

  @override
  State<OverviewTrips> createState() => _OverviewTripsState();
}

class _OverviewTripsState extends State<OverviewTrips> {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  List<Item> notes = [];
  List<TicketData> FlightTickets = [];
  List<TrainData> TrainTickets = [];
  List<BusData> BusTickets = [];
  List<CarData> CarTickets = [];
  List<XFile?> ImagesList = [];
  late final MyIndexProvider _indexProvider;
  void updateNotesInFirestore(List<Item> notes) async {
    List<Map<String, dynamic>> notesData =
        notes.map((item) => item.toMap()).toList();
    await widget.tripRef?.collection('attachments').doc('notes').update({
      'data': notesData,
    });
  }

  void updateFlightTicketsInFirestore(List<TicketData> flightTickets) async {
    List<Map<String, dynamic>> flightData =
        flightTickets.map((item) => item.toJson()).toList();
    await widget.tripRef
        ?.collection('attachments')
        .doc('flightTickets')
        .update({
      'data': flightData,
    });
  }

  void updateTrainTicketsInFirestore(List<TrainData> trainTickets) async {
    List<Map<String, dynamic>> trainData =
        trainTickets.map((item) => item.toMap()).toList();
    await widget.tripRef?.collection('attachments').doc('trainTickets').update({
      'data': trainData,
    });
  }

  void updateBusTicketsInFirestore(List<BusData> busTickets) async {
    List<Map<String, dynamic>> busDataMap =
        busTickets.map((item) => item.toMap()).toList();
    await widget.tripRef?.collection('attachments').doc('busTickets').update({
      'data': busDataMap,
    });
  }

  void updateCarDataInFirestore(List<CarData> carData) async {
    List<Map<String, dynamic>> carDataMap =
        carData.map((item) => item.toMap()).toList();
    await widget.tripRef?.collection('attachments').doc('carTickets').update({
      'data': carDataMap,
    });
  }

  @override
  void initState() {
    super.initState();
    _indexProvider = Provider.of<MyIndexProvider>(context, listen: false);
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        ImagesList.add(returnedImage);
      });
    }
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        ImagesList.add(returnedImage);
      });
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
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Some Random Question?',
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
                                                FlightTickets.addAll(
                                                    ticketsData!);
                                                updateFlightTicketsInFirestore(
                                                    FlightTickets);
                                              });
                                            },
                                          )));
                            },
                            child: Text(
                              'Add Manually',
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
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Some Random Question?',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
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
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Some Random Question?',
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
                                                TrainTickets.add(traindata);
                                                updateTrainTicketsInFirestore(
                                                    TrainTickets);
                                              });
                                            },
                                          )));
                            },
                            child: Text(
                              'Add Manually',
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

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 4),
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
                                Icons.flight_takeoff,
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
                                Icons.train,
                                size: 40,
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
                                              BusTickets.add(busdata);
                                              updateBusTicketsInFirestore(
                                                  BusTickets);
                                            });
                                          },
                                        )));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Iconsax.bus5,
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
                                              CarTickets.add(cardata);
                                              updateCarDataInFirestore(
                                                  CarTickets);
                                            });
                                          },
                                        )));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Iconsax.car5,
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
                                Icons.attachment_outlined,
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
            if (!FlightTickets.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text('Your Flight Tickets'),
                  initiallyExpanded: false,
                  children: [
                    SizedBox(
                      height: 384,
                      width: screenWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: FlightTickets.length,
                        itemBuilder: (context, index) {
                          return TicketContainer(
                            DepartLocation: FlightTickets[index].fromAirport,
                            topText: FlightTickets[index].topText,
                            fromDate: FlightTickets[index].fromDate,
                            fromTime: FlightTickets[index].fromTime,
                            ArrivalLocation: FlightTickets[index].toAirport,
                            bottomText: FlightTickets[index].bottomText,
                            toDate: FlightTickets[index].toDate,
                            toTime: FlightTickets[index].toTime,
                            transitCarrier:
                                '${FlightTickets[index].flightOperator}-${FlightTickets[index].flightNumber}',
                            price: FlightTickets[index].price,
                            operaterHeading: 'FLIGHT OPERATER',
                            index: index,
                            onDeleted: (index) {
                              setState(() {
                                FlightTickets.removeAt(index);
                                updateFlightTicketsInFirestore(FlightTickets);
                              });
                            },
                            updateNotes: (value) {
                              setState(() {
                                FlightTickets[index].note = value;
                                updateFlightTicketsInFirestore(FlightTickets);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (!TrainTickets.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text('Your Train Tickets'),
                  initiallyExpanded: false,
                  children: [
                    SizedBox(
                      height: 384,
                      width: screenWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: TrainTickets.length,
                        itemBuilder: (context, index) {
                          return TicketContainer(
                            DepartLocation: TrainTickets[index].fromStation,
                            topText: TrainTickets[index].topText,
                            fromDate: TrainTickets[index].fromDate,
                            fromTime: TrainTickets[index].fromTime,
                            ArrivalLocation: TrainTickets[index].toStation,
                            bottomText: TrainTickets[index].bottomText,
                            toDate: TrainTickets[index].toDate,
                            toTime: TrainTickets[index].toTime,
                            transitCarrier:
                                '${TrainTickets[index].trainOperater}-${TrainTickets[index].trainNumber}',
                            price: TrainTickets[index].price,
                            operaterHeading: 'TRAIN OPERATER',
                            index: index,
                            onDeleted: (index) {
                              setState(() {
                                TrainTickets.removeAt(index);
                                updateTrainTicketsInFirestore(TrainTickets);
                              });
                            },
                            updateNotes: (value) {
                              setState(() {
                                TrainTickets[index].note = value;
                                updateFlightTicketsInFirestore(FlightTickets);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (!BusTickets.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text('Your Bus Tickets'),
                  initiallyExpanded: false,
                  children: [
                    SizedBox(
                      height: 384,
                      width: screenWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: BusTickets.length,
                        itemBuilder: (context, index) {
                          return TicketContainer(
                            DepartLocation: BusTickets[index].fromBusStop,
                            topText: '',
                            fromDate: BusTickets[index].fromDate,
                            fromTime: BusTickets[index].fromTime,
                            ArrivalLocation: BusTickets[index].toBusStop,
                            bottomText: '',
                            toDate: BusTickets[index].toDate,
                            toTime: BusTickets[index].toTime,
                            transitCarrier: BusTickets[index].busOperater,
                            price: BusTickets[index].price,
                            operaterHeading: 'BUS OPERATER',
                            index: index,
                            updateNotes: (value) {
                              setState(() {
                                BusTickets[index].note = value;
                                updateBusTicketsInFirestore(BusTickets);
                              });
                            },
                            onDeleted: (index) {
                              setState(() {
                                BusTickets.removeAt(index);
                                updateBusTicketsInFirestore(BusTickets);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (!CarTickets.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text('Your Car Tickets'),
                  initiallyExpanded: false,
                  children: [
                    SizedBox(
                      height: 384,
                      width: screenWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: CarTickets.length,
                        itemBuilder: (context, index) {
                          return TicketContainer(
                            DepartLocation: CarTickets[index].fromPlace,
                            topText: '',
                            fromDate: CarTickets[index].fromDate,
                            fromTime: CarTickets[index].fromTime,
                            ArrivalLocation: CarTickets[index].toPlace,
                            bottomText: '',
                            toDate: CarTickets[index].toDate,
                            toTime: CarTickets[index].toTime,
                            transitCarrier: CarTickets[index].carOperator,
                            price: CarTickets[index].price,
                            operaterHeading: 'Car OPERATER',
                            index: index,
                            onDeleted: (index) {
                              setState(() {
                                CarTickets.removeAt(index);
                                updateCarDataInFirestore(CarTickets);
                              });
                            },
                            updateNotes: (value) {
                              setState(() {
                                CarTickets[index].note = value;
                                updateFlightTicketsInFirestore(FlightTickets);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (!ImagesList.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text('Your Attachments'),
                  initiallyExpanded: false,
                  children: [
                    SizedBox(
                      height: 384,
                      width: screenWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: ImagesList.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(ImagesList[index]!.path),
                            height: 350,
                            width: 0.95 * screenWidth,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                Text('Notes'),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    setState(() {
                      notes.add(Item(
                          heading: 'Note ${notes.length + 1}', notes: null));
                      updateNotesInFirestore(notes);
                    });
                  },
                ),
              ],
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  notes[index].isExpanded = isExpanded;
                  if (isExpanded == false) {
                    notes[index].isEditing = false;
                  }
                });
              },
              elevation: 0,
              materialGapSize: 5,
              children: notes.asMap().entries.map<ExpansionPanel>((entry) {
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
                  backgroundColor: Colors.grey[800],
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Row(
                      children: [
                        Expanded(
                          child: _isEditing
                              ? TextFormField(
                                  initialValue: item.heading,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      _isEditing = false;
                                      item.isEditing = false;
                                      item.heading = value;
                                      updateNotesInFirestore(notes);
                                    });
                                  })
                              : Text(
                                  item.heading,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                    notes.removeWhere((Item currentItem) =>
                                        item == currentItem);
                                    updateNotesInFirestore(notes);
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
                          updateNotesInFirestore(notes);
                        });
                      }),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
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
