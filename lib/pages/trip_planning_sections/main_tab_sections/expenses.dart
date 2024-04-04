import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:voyager/components/trip_planning_section/date.dart';
import 'package:voyager/components/trip_planning_section/expense_category.dart';
import 'package:voyager/components/trip_planning_section/paid_by.dart';
import 'package:voyager/components/trip_planning_section/split.dart';


class ExpenseData {
  String rupeeValue;
  Icon? selectedIcon;
  String PaidBy;
  List<String>? Split;
  DateTime? Date;
  ExpenseData(
      {required this.rupeeValue,
      required this.selectedIcon,
      required this.PaidBy,
      required this.Split,
      required this.Date});
}

class ExpensesTrips extends StatefulWidget {
  const ExpensesTrips({super.key});

  @override
  State<ExpensesTrips> createState() => _ExpensesTripsState();
}

class _ExpensesTripsState extends State<ExpensesTrips> {
  String selectedoption = 'Sort Options';
  // List<String> rupeeValues = [];
  // List<Icon?> _selectedIcons = [];
  // List<String> selectedPaidBy1 = [];
  // List<String> selectedItems = [];
  List<ExpenseData> expenses = [];

  // void _addRupeeValue(String value) {
  //   setState(() {
  //     rupeeValues.add(value);
  //   });
  // }

  // void _updateSelectedOption(String option) {
  //   setState(() {
  //     selectedoption = option;
  //   });
  // }

  void _showErrorSnackbar(String Error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //backgroundColor: kRedColor,
        // Change the background color of the snackbar
        content: Center(
          child: Text(
            Error,
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the text color
            ),
          ),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void sortExpenses(String selectedOption) {
    switch (selectedOption) {
      case 'Date (newest first)':
        expenses.sort((a, b) => b.Date!.compareTo(a.Date!));
        break;
      case 'Date (oldest first)':
        expenses.sort((a, b) => a.Date!.compareTo(b.Date!));
        break;
      case 'Amount (highest first)':
        expenses.sort((a, b) =>
            double.parse(b.rupeeValue).compareTo(double.parse(a.rupeeValue)));
        break;
      case 'Amount (lowest first)':
        expenses.sort((a, b) =>
            double.parse(a.rupeeValue).compareTo(double.parse(b.rupeeValue)));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortOptions = [
      'Date (newest first)',
      'Date (oldest first)',
      'Amount (highest first)',
      'Amount (lowest first)',
    ];

    sortOptions.insert(0, 'Sort Options');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String displayValue = expenses.isNotEmpty
        ? '\u20B9 ${expenses.map((expense) => double.parse(expense.rupeeValue)).reduce((value, element) => value + element).toStringAsFixed(2)}'
        : '\u20B9 0.00';

    List<String> _selectedNames = [];
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight / 3 - 10,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 40, 70),
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(20.0),
              //   bottomRight: Radius.circular(20.0),
              // ),
            ),
            padding: EdgeInsets.all(.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  displayValue,
                  // '000',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Set a budget',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for debt summary button
                  },
                  child: Text('Debt Summary'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 3 - 35,
            ),
            child: Container(
              width: screenWidth,
              height: 2 * screenHeight / 3 - 15,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 243, 243),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            'Expenses',
                          ),
                        ]),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Text('Sort:'),
                            SizedBox(width: 10),
                            DropdownButton<String>(
                              value: selectedoption,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedoption = newValue;
                                    sortExpenses(selectedoption);
                                  });
                                }
                              },
                              items: sortOptions.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: expenses.length,
                          itemBuilder: (context, index) {
                            // Get the selected category icon for the current index

                            return Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Display selected category icon
                                        expenses[index].selectedIcon != null
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
                                                child: expenses[index]
                                                    .selectedIcon,
                                              )
                                            : Container(),
                                        // Display rupee value
                                        Text(
                                          expenses[index].rupeeValue,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (expenses[index].Date != null)
                                          Text(DateFormat('yyyy-MM-dd')
                                              .format(expenses[index].Date!)),
                                        GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text("Delete Expense"),
                                                    content: Text(
                                                        "Are you sure you want to delete this expense?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            // Remove the selected expense and its icon
                                                            // rupeeValues.removeAt(index);
                                                            // _selectedIcons.removeAt(index);
                                                            // selectedPaidBy1.removeAt(index);
                                                            // selectedItems.removeAt(index);
                                                            expenses.removeAt(
                                                                index);
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text("Delete"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(Icons.delete)),
                                      ],
                                    ),
                                    SizedBox(
                                        height: 8), // Adjust spacing as needed
                                    Text('Paid by: ${expenses[index].PaidBy}'),
                                    if (expenses[index].Split != null)
                                      Text(
                                          'split: ${expenses[index].Split!.join(', ')}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          String? rupee = null;
                          String? selectedCategory;
                          Icon? selectedCategoryIcon;
                          String? selectedPaidBy;
                          DateTime? _selectedDate;
                          List<String>? selectedItems;
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter mystate) {
                            return SingleChildScrollView(
                              // Wrap with SingleChildScrollView
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                height: 700,
                                padding: EdgeInsets.all(10.0),
                                child: Navigator(
                                  onGenerateRoute: (RouteSettings settings) {
                                    return MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Center(
                                                child: Text(
                                                  'Add Expense',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                  //Navigator.pop(context);
                                                },
                                                child: Text('Done'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.currency_rupee),
                                                  Spacer(),
                                                  SizedBox(
                                                    width: 0.25 * screenWidth,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: '0.00',
                                                      ),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'^\d+\.?\d{0,2}')),
                                                      ],
                                                      onSubmitted: (val) {
                                                        mystate(() {
                                                          rupee = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ExpenseCategoryPage(
                                                        onCategorySelected:
                                                            (Category) {
                                                          mystate(() {
                                                            selectedCategory =
                                                                Category?[
                                                                    'category']!;
                                                            selectedCategoryIcon =
                                                                Category?[
                                                                    'icon'];
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    selectedCategoryIcon != null
                                                        ? selectedCategoryIcon!
                                                        : Icon(Icons
                                                            .file_copy), // Render selected icon if available, else default icon
                                                    Spacer(),
                                                    selectedCategoryIcon != null
                                                        ? Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 8),
                                                              Text(
                                                                selectedCategory!,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            'Select Item',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          // SizedBox(height: 12.0),
                                          SizedBox(height: 20.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        selectedPaidBy == null
                                                            ? 'paid by'
                                                            : 'paid by: $selectedPaidBy',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons.arrow_forward),
                                                      onPressed: () async {
                                                        final result =
                                                            await Navigator
                                                                .push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    PaidByPage(
                                                              selectedPaidBy:
                                                                  selectedPaidBy,
                                                            ),
                                                          ),
                                                        );
                                                        // Update the selected item if a result is received
                                                        if (result != null &&
                                                            result is String) {
                                                          // Check if result is a string
                                                          mystate(() {
                                                            selectedPaidBy =
                                                                result; // Assign the result directly to selectedPaidBy
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              SizedBox(height: 5),
                                              Divider(
                                                color: const Color.fromARGB(
                                                    255,
                                                    190,
                                                    189,
                                                    189), // Color of the line
                                                thickness:
                                                    1.0, // Thickness of the line
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      selectedItems != null
                                                          ? 'split : ${selectedItems!.join(", ")}'
                                                          : 'split:',

                                                      // Your left text
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold, // Make text bold
                                                        fontSize:
                                                            16.0, // Set font size
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .arrow_forward), // Arrow icon
                                                    onPressed: () {
                                                      // Define the action when the arrow icon is pressed
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SplitPage(
                                                            noOneSelected:
                                                                selectedItems !=
                                                                        null
                                                                    ? selectedItems!
                                                                        .contains(
                                                                            'NO ONE')
                                                                    : false,
                                                            selectedItems:
                                                                selectedItems,
                                                            onSelectedItemsChanged:
                                                                (selectedItem) {
                                                              mystate(() {
                                                                selectedItems =
                                                                    selectedItem;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Divider(
                                                color: const Color.fromARGB(
                                                    255,
                                                    190,
                                                    189,
                                                    189), // Color of the line
                                                thickness:
                                                    1.0, // Thickness of the line
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      _selectedDate != null
                                                          ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
                                                          : 'No Date Selected',
                                                      // Your left text
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold, // Make text bold
                                                        fontSize:
                                                            16.0, // Set font size
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .arrow_forward), // Arrow icon
                                                    onPressed: () {
                                                      // Define the action when the arrow icon is pressed
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DatePage(
                                                            selectedDay:
                                                                _selectedDate,
                                                            focusedDay:
                                                                DateTime.now(),
                                                            onDateSelected:
                                                                (Date) {
                                                              mystate(() {
                                                                _selectedDate =
                                                                    Date;
                                                              });
                                                            },
                                                          ), // Replace YourNewPage() with the desired new page widget
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0),
                                                child: Center(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (rupee != null &&
                                                          selectedCategoryIcon !=
                                                              null &&
                                                          selectedPaidBy !=
                                                              null &&
                                                          selectedItems !=
                                                              null &&
                                                          _selectedDate !=
                                                              null) {
                                                        setState(() {
                                                          if (selectedItems!
                                                              .contains(
                                                                  'NO ONE')) {
                                                            selectedItems!
                                                                .clear();
                                                          }
                                                          expenses.add(ExpenseData(
                                                              rupeeValue:
                                                                  rupee!,
                                                              selectedIcon:
                                                                  selectedCategoryIcon,
                                                              PaidBy:
                                                                  selectedPaidBy!,
                                                              Split: selectedItems !=
                                                                      null
                                                                  ? null
                                                                  : selectedItems,
                                                              Date:
                                                                  _selectedDate!));
                                                        });
                                                      } else {
                                                        _showErrorSnackbar(
                                                            'PLease fill all fields');
                                                      }
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Select',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Adjust the height between texts and between this row and the next
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                                  },
                                ),
                              ),
                            );
                          });
                        },
                      );
                    },
                    child: Text(
                        'Add Expenses'), // Change button text to "Add Expenses"
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
