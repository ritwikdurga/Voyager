// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

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

class Item {
  String heading;
  String? notes;
  bool isExpanded;
  bool isEditing;
  Item(
      {required this.heading,
      required this.notes,
      this.isExpanded = false,
      this.isEditing = false});
}

class OverviewTrips extends StatefulWidget {
  OverviewTrips({super.key});

  @override
  State<OverviewTrips> createState() => _OverviewTripsState();
}

class _OverviewTripsState extends State<OverviewTrips> {
  List<Item> notes = [Item(heading: 'Note 1', notes: null)];
  List<TicketData> FlightTickets = [];
  List<TrainData> TrainTickets = [];
  List<BusData> BusTickets = [];
  List<CarData> CarTickets = [];
  List<XFile?> ImagesList = [];

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
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[600],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormForOneWay(
                                            onTicketAdded: (ticketsData) {
                                              setState(() {
                                                FlightTickets.addAll(
                                                    ticketsData!);
                                              });
                                            },
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Add Manually',
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
                                  builder: (context) =>
                                      HomeScreen(initialIndex: 1)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey[600],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Search for Flights',
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
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Some Random Question?',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[600],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              _pickImageFromCamera();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Take Photo',
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _pickImageFromGallery();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey[600],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Add Photo from Gallery',
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
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Some Random Question?',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[600],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FormForTrain(
                                            onTrainTicketAdded: (traindata) {
                                              setState(() {
                                                TrainTickets.add(traindata);
                                              });
                                            },
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Add Manually',
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
                                  builder: (context) =>
                                      HomeScreen(initialIndex: 1)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey[600],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
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
                      fontSize: 17,
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
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
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
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                children: [
                  Text(
                    'Reservations and Attachments',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 80,
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
                                size: 50,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Text('Flights'),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
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
                                size: 50,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Text(
                                'Trains',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
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
                                            });
                                          },
                                        )));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Iconsax.bus5,
                                size: 50,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Text(
                                'Buses',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
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
                                            });
                                          },
                                        )));
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.car_repair_sharp,
                                size: 50,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Text(
                                'Cars',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                        child: VerticalDivider(
                          thickness: 0.25,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth / 5 - 15,
                        height: 80,
                        child: GestureDetector(
                          onTap: () {
                            AttachForAttachments(context);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.attachment_outlined,
                                size: 50,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Text(
                                'Attachment',
                                overflow: TextOverflow.ellipsis,
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
                            onDeleted: (index) {
                              setState(() {
                                BusTickets.removeAt(index);
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
                            transitCarrier: CarTickets[index].carOperater,
                            price: CarTickets[index].price,
                            operaterHeading: 'Car OPERATER',
                            index: index,
                            onDeleted: (index) {
                              setState(() {
                                CarTickets.removeAt(index);
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
