// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/explore_section/trips_cards.dart';
import 'package:voyager/models/trip_model.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_one_way.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_trains.dart';
import 'package:voyager/utils/constants.dart';

void showBottomSheetForSelectingTrips(
  BuildContext context,
  int length,
  List<Trip> tripList,
  List<TicketData>? flightTicket,
  TrainData? trainTicket,
  int indx,
) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return length != 0
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 2 - 10,
                  child: ListView.builder(
                      itemCount: length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (bc, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 16, 16),
                          child: trips(
                            screenWidth: screenWidth,
                            trip: tripList[index],
                            isNewTripPage: true,
                            isBookmarked: tripList[index].isBookmarked,
                            index: indx,
                            flightTicket: flightTicket,
                            trainTicket: trainTicket,
                          ),
                        );
                      }),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'No active trips.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey[300]
                            : Colors.grey[700],
                        fontFamily: 'ProductSans'),
                  ),
                ),
              ],
            );
    },
  );
}
