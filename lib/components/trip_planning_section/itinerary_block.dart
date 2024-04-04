// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:provider/provider.dart';
// import 'package:voyager/utils/constants.dart';

// class BlockIti extends StatefulWidget {
//   final DateTime startDate;
//   final DateTime endDate;

//   const BlockIti({Key? key, required this.startDate, required this.endDate})
//       : super(key: key);

//   @override
//   _BlockItiState createState() => _BlockItiState();
// }

// class _BlockItiState extends State<BlockIti> {
//   List<BlockData> blockDataList = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     // clear the blockDataList
//     blockDataList.clear();
//     for (var i = 0;
//         i <= widget.endDate.difference(widget.startDate).inDays;
//         i++) {
//       blockDataList
//           .add(BlockData(date: widget.startDate.add(Duration(days: i))));
//     }
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             for (var blockData in blockDataList)
//               Slidable(
//                 endActionPane: ActionPane(
//                   motion: ScrollMotion(),
//                   extentRatio: 0.42,
//                   children: [
//                     SlidableAction(
//                       onPressed: (BuildContext context) {
//                         _onDeleteBlock(blockData);
//                       },
//                       label: 'Delete',
//                       icon: Icons.delete,
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                     ),
//                   ],
//                 ),
//                 child: BlockWidget(
//                   startDate: widget.startDate,
//                   endDate: widget.endDate,
//                   blockData: blockData,
//                   onDelete: () {
//                     setState(() {
//                       blockDataList.remove(blockData);
//                     });
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onDeleteBlock(BlockData blockData) {
//     setState(() {
//       int index =
//           blockDataList.indexWhere((element) => element.date == blockData.date);
//       if (index != -1) {
//         blockDataList.removeAt(index);
//         blockData.locations.clear();
//       }
//     });
//   }
// }

// class BlockData {
//   final DateTime date;
//   List<String> locations = [];

//   BlockData({required this.date});
// }

// class BlockWidget extends StatefulWidget {
//   final BlockData blockData;
//   final VoidCallback onDelete;
//   final DateTime startDate;
//   final DateTime endDate;

//   const BlockWidget({
//     required this.blockData,
//     required this.onDelete,
//     required this.startDate,
//     required this.endDate,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _BlockWidgetState createState() => _BlockWidgetState();
// }

// class _BlockWidgetState extends State<BlockWidget> {
//   late TextEditingController _locationController;
//   bool _expanded = false;

//   @override
//   void initState() {
//     super.initState();
//     _locationController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _locationController.dispose();
//     super.dispose();
//   }

//   void _removeLocation(String location) {
//     setState(() {
//       widget.blockData.locations.remove(location);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 2300),
//       curve: Curves.easeInOut,
//       key: UniqueKey(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 _expanded = !_expanded;
//               });
//             },
//             child: Container(
//               padding: EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Center(
//                 child: Text(
//                   DateFormat('dd MMM yyyy').format(widget.blockData.date).toUpperCase(),
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     color: themeProvider.themeMode == ThemeMode.dark
//                         ? Colors.white
//                         : Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: GoogleFonts.righteous().fontFamily,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           if (_expanded) ...[
//             SizedBox(height: 10.0),
//             for (var location in widget.blockData.locations) ...[
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 margin: EdgeInsets.symmetric(vertical: 5.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey,
//                   ),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.location_on),
//                         SizedBox(width: 10.0),
//                         Text(location,
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               color: Colors.deepOrange[500],
//                               fontWeight: FontWeight.bold,
//                             ),
//                         ),
//                         Spacer(),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _removeLocation(location),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Text(
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec odio vitae libero tincidunt aliquam. Donec nec odio vitae libero tincidunt aliquam.',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'ProductSans',
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[400],
//                       ),
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: [
//                         Icon(Icons.access_time, color: Colors.blueAccent,),
//                         SizedBox(width: 10.0),
//                         Text('9:00 AM - 5:00 PM',
//                             style: TextStyle(
//                               fontSize: 14.0,
//                               color: Colors.grey[400],
//                               fontWeight: FontWeight.bold,
//                             ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: [
//                         Icon(Icons.star, color: Colors.blueAccent),
//                         SizedBox(width: 10.0),
//                         Text('4.5/5', style: TextStyle(
//                           fontSize: 14.0,
//                           color: Colors.grey[400],
//                           fontWeight: FontWeight.bold,
//                         ),),
//                         SizedBox(width: 10.0),
//                         Icon(
//                           Ionicons.logo_google,
//                           size: 15,
//                           // add google color
//                           color: Colors.green,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on, color: Colors.blueAccent),
//                         SizedBox(width: 10.0),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Text(
//                               '123, Lorem Ipsum, Dolor Sit Amet, Consectetur Adipiscing Elit.',
//                               style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.grey[400],
//                                 fontWeight: FontWeight.bold,
//                             ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: [
//                         Icon(Icons.link, color: Colors.blueAccent),
//                         SizedBox(width: 10.0),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Text(
//                               'www.example.com',
//                               style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.grey[400],
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: [
//                         Icon(Icons.phone, color: Colors.blueAccent),
//                         SizedBox(width: 10.0),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Text(
//                               '+91 1234567890',
//                               style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.grey[400],
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () {},
//                             child: Text('Get Directions',
//                               style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.deepOrange[500],
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.0),
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () {},
//                             child: Text('View on Map',
//                               style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.deepOrange[500],
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//             SizedBox(height: 10.0),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _locationController,
//                       decoration: InputDecoration(
//                         hintText: 'Add a location',
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 15.0),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: () {
//                       setState(() {
//                         widget.blockData.locations
//                             .add(_locationController.text);
//                         _locationController.clear();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class BlockIti extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  const BlockIti({Key? key, required this.startDate, required this.endDate})
      : super(key: key);

  @override
  _BlockItiState createState() => _BlockItiState();
}

class _BlockItiState extends State<BlockIti>
    with AutomaticKeepAliveClientMixin {
  List<BlockData> blockDataList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // clear the blockDataList
    blockDataList.clear();
    for (var i = 0;
        i <= widget.endDate.difference(widget.startDate).inDays;
        i++) {
      blockDataList
          .add(BlockData(date: widget.startDate.add(Duration(days: i))));
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (var blockData in blockDataList)
              Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  extentRatio: 0.42,
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        _onDeleteBlock(blockData);
                      },
                      label: 'Delete',
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
                child: BlockWidget(
                  startDate: widget.startDate,
                  endDate: widget.endDate,
                  blockData: blockData,
                  onDelete: () {
                    setState(() {
                      blockDataList.remove(blockData);
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onDeleteBlock(BlockData blockData) {
    setState(() {
      int index =
          blockDataList.indexWhere((element) => element.date == blockData.date);
      if (index != -1) {
        blockDataList.removeAt(index);
        blockData.locations.clear();
      }
    });
  }
}

class BlockData {
  final DateTime date;
  List<String> locations = [];

  BlockData({required this.date});
}

class BlockWidget extends StatefulWidget {
  final BlockData blockData;
  final VoidCallback onDelete;
  final DateTime startDate;
  final DateTime endDate;

  const BlockWidget({
    required this.blockData,
    required this.onDelete,
    required this.startDate,
    required this.endDate,
    Key? key,
  }) : super(key: key);

  @override
  _BlockWidgetState createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget>
    with SingleTickerProviderStateMixin {
  late TextEditingController _locationController;
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust duration as needed
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _removeLocation(String location) {
    setState(() {
      widget.blockData.locations.remove(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: Duration(milliseconds: 750), // Adjust duration as needed
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
                if (_expanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade400,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  DateFormat('dd MMM yyyy')
                      .format(widget.blockData.date)
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.righteous().fontFamily,
                  ),
                ),
              ),
            ),
          ),
          if (_expanded) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.route,
                      size: 15.0,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Optimize Route',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'ProductSans',
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            for (var location in widget.blockData.locations) ...[
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kGreenColor,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 10.0),
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.deepOrange[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeLocation(location),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec odio vitae libero tincidunt aliquam. Donec nec odio vitae libero tincidunt aliquam.',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'ProductSans',
                        fontWeight: FontWeight.bold,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey.shade400
                            : Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.blueAccent),
                        SizedBox(width: 10.0),
                        Text(
                          '9:00 AM - 5:00 PM',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey.shade400
                            : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.blueAccent),
                        SizedBox(width: 10.0),
                        Text(
                          '4.5/5',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey.shade400
                            : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Ionicons.logo_google,
                          size: 15,
                          // add google color
                          color: Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blueAccent),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '123, Lorem Ipsum, Dolor Sit Amet, Consectetur Adipiscing Elit.',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey.shade400
                            : Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.link, color: Colors.blueAccent),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'www.example.com',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey.shade400
                            : Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.blueAccent),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '+91 1234567890',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey.shade400
                            : Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Get Directions',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.deepOrange[500],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'View on Map',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.deepOrange[500],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        hintText: 'Add a location',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_locationController.text.isNotEmpty)
                        setState(() {
                          widget.blockData.locations
                              .add(_locationController.text);
                          _locationController.clear();
                        });
                      else {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: kRedColor,
                            // Change the background color of the snackbar
                            content: Center(
                              child: Text(
                                'Please enter a location',
                                style: TextStyle(
                                  fontSize:
                                      16, // Change the font size as needed
                                  fontFamily: 'ProductSans',
                                  color: Colors
                                      .white, // Change the font family as needed
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
