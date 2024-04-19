// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/trip_planning_section/date.dart';
import 'package:voyager/components/trip_planning_section/expense_category.dart';
import 'package:voyager/components/trip_planning_section/paid_by.dart';
import 'package:voyager/components/trip_planning_section/split.dart';
import 'package:voyager/models/expense_model.dart';
import 'package:voyager/models/user_model.dart';
import 'package:voyager/services/data_comparator.dart';
import 'package:voyager/services/fetch_userdata.dart';
import 'package:voyager/utils/constants.dart';

class ExpensesTrips extends StatefulWidget {
  final String tripId;
  const ExpensesTrips({super.key, required this.tripId});

  @override
  State<ExpensesTrips> createState() => _ExpensesTripsState();
}

class _ExpensesTripsState extends State<ExpensesTrips> {
  String selectedoption = 'Sort Options';
  List<ExpenseData> expenses = [];
  List<dynamic> _collabList = [];
  List<UserModel> userData = [];
  double currentUserSpendings = 0.0;
  late Stream<DocumentSnapshot> _tripStream;

  @override
  void initState() {
    super.initState();
    _tripStream = FirebaseFirestore.instance
        .collection('trips')
        .doc(widget.tripId)
        .snapshots();
  }

  void updateExpenseData(List<ExpenseData> expenses) {
    DocumentReference tripDocument =
        FirebaseFirestore.instance.doc('trips/${widget.tripId}');

    List<Map<String, dynamic>> expensesList = expenses.map((expense) {
      return expense.toMap();
    }).toList();
    tripDocument.set({'expenses': expensesList}, SetOptions(merge: true));
    currentUserSpendings =
        calculateCurrentUserSpending(expenses, firebaseAuth.currentUser!.uid);
  }

  void fetchUserData(List<dynamic> uids) async {
    for (String uid in uids) {
      try {
        DocumentSnapshot userDocRef =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDocRef.exists) {
          UserModel user =
              UserModel.fromMap(userDocRef.data() as Map<String, dynamic>);
          setState(() {
            userData.add(user);
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  double calculateCurrentUserSpending(
      List<ExpenseData> expenses, String currentUserUid) {
    double currentUserSpending = 0;
    for (var expense in expenses) {
      List<Map<String, dynamic>>? split = expense.Split;
      if (split != null) {
        var currentUserInSplit =
            split.where((item) => item['uid'] == currentUserUid);
        if (currentUserInSplit.isNotEmpty) {
          for (var item in split) {
            if (item['uid'] == currentUserUid && item['name'] == 'None') {
              currentUserSpending += double.parse(expense.rupeeValue);
            } else {
              double amountPerPerson =
                  double.parse(expense.rupeeValue) / split.length;
              if (item['uid'] == currentUserUid) {
                currentUserSpending += amountPerPerson;
              }
            }
          }
        }
      }
    }
    debugPrint(currentUserSpending.toString());
    return currentUserSpending;
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
        var data = snapshot.data;
        List<dynamic> collabList = [];
        try {
          if (data!.get('collaborators') != null) {
            collabList = data.get('collaborators');
          }
        } catch (error) {
          print(error);
          collabList = [];
        }
        if (!areArraysEqual(collabList, _collabList)) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            setState(() {
              _collabList = collabList;
              userData.clear();
              fetchUserData(collabList);
            });
          });
        }

        List<ExpenseData> expensesList = [];
        try {
          if (data!.get('expenses') != null) {
            List<dynamic> expensesData = data.get('expenses');
            expensesList = expensesData.map((expenseMap) {
              return ExpenseData.fromMap(expenseMap);
            }).toList();
          }
        } catch (error) {
          print(error);
          expensesList = [];
        }

        if (!areExpenseDataListsEqual(expenses, expensesList)) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            setState(() {
              expenses = expensesList;
              currentUserSpendings = calculateCurrentUserSpending(
                  expenses, firebaseAuth.currentUser!.uid);
            });
          });
        }

        List<String> sortOptions = [
          'Date (newest first)',
          'Date (oldest first)',
          'Amount (highest first)',
          'Amount (lowest first)',
        ];
        sortOptions.insert(0, 'Sort Options');
        String displayValue = NumberFormat.currency(
          symbol: '\u20B9',
          decimalDigits: 2,
        ).format(currentUserSpendings);
        // List<String> selectedNames = [];
        return buildWidgetTree(
          context,
          displayValue,
          sortOptions,
        );
      },
    );
  }

  Widget buildWidgetTree(
      BuildContext context, String displayValue, List<String> sortOptions) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight / 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Text(
                  'Budget Summary',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'ProductSans',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  displayValue,
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: screenHeight / 5 - 30,
          ),
          child: Container(
            width: screenWidth,
            height: 3 * screenHeight / 4,
            decoration: BoxDecoration(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Row(children: [
                        Text(
                          'Expenses',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'ProductSans',
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                      Row(
                        children: [
                          Text(
                            'Sort:',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'ProductSans',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                            underline: Container(), // Remove the underline
                            items: sortOptions.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                      // SizedBox(height: 10),
                      SizedBox(
                        height: screenHeight / 2.59,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: expenses.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (expenses[index].Date != null)
                                        Center(
                                          child: Text(
                                            DateFormat('dd-MM-yy')
                                                .format(expenses[index].Date!),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          expenses[index].selectedIcon ??
                                              Container(),
                                          Text(
                                            '\u20B9${expenses[index].rupeeValue}',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CupertinoAlertDialog(
                                                      title: Text(
                                                          "Delete Expense"),
                                                      content: Text(
                                                          "Are you sure you want to delete this expense?"),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text("Cancel"),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            setState(() {
                                                              expenses.removeAt(
                                                                  index);
                                                              updateExpenseData(
                                                                  expenses);
                                                            });
                                                            Navigator.of(
                                                                    context)
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
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text('Paid By:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent,
                                                fontFamily: 'ProductSans',
                                              )),
                                          Text(
                                            ' ${expenses[index].PaidBy['name']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'ProductSans',
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (expenses[index].Split != null)
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text('Split:',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueAccent,
                                                    fontFamily: 'ProductSans',
                                                  )),
                                              Text(
                                                expenses[index]
                                                    .Split!
                                                    .map((item) => item['name'])
                                                    .join(', '),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'ProductSans',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.black
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          String? rupee;
                          String? selectedCategory;
                          Icon? selectedCategoryIcon;
                          Map<String, dynamic>? selectedPaidBy;
                          DateTime? selectedDate;
                          List<Map<String, dynamic>>? selectedItems;
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter mystate) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.black
                                          : Colors.white,
                                ),
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
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.silkscreen()
                                                            .fontFamily,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
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
                                                        alignLabelWithHint:
                                                            true,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.0,
                                                                    horizontal:
                                                                        25.0),
                                                        hintText: '0.00',
                                                      ),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              signed: true,
                                                              decimal: true),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      textInputAction:
                                                          TextInputAction.done,
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
                                                            .category_outlined),
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
                                          SizedBox(height: 20.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Paid By:',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        selectedPaidBy == null
                                                            ? ''
                                                            : '  ${selectedPaidBy!['name']}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0,
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
                                                              userdata:
                                                                  userData,
                                                            ),
                                                          ),
                                                        );

                                                        if (result != null) {
                                                          mystate(() {
                                                            selectedPaidBy =
                                                                result;
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
                                                    255, 190, 189, 189),
                                                thickness: 1.0,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Split: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                      color: Colors.blueAccent,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      selectedItems != null
                                                          ? ' ${selectedItems!.map((item) => item['name']).join(", ")}'
                                                          : '',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.arrow_forward),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SplitPage(
                                                            userData: userData,
                                                            noOneSelected: selectedItems != null
                                                                ? selectedItems!.any((item) =>
                                                                    item['name'] ==
                                                                        'None' &&
                                                                    item['photoURL'] ==
                                                                        '' &&
                                                                    item['uid'] ==
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .uid)
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
                                                    255, 190, 189, 189),
                                                thickness: 1.0,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    selectedDate != null
                                                        ? 'Selected Date:'
                                                        : 'No Date Selected',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                      color: Colors.blueAccent,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      selectedDate != null
                                                          ? ' ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'
                                                          : '',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0,
                                                        color: themeProvider
                                                                    .themeMode ==
                                                                ThemeMode.dark
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.arrow_forward),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DatePage(
                                                            selectedDay:
                                                                selectedDate,
                                                            focusedDay:
                                                                DateTime.now(),
                                                            onDateSelected:
                                                                (Date) {
                                                              mystate(() {
                                                                selectedDate =
                                                                    Date;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 50.0),
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
                                                          selectedDate !=
                                                              null) {
                                                        setState(() {
                                                          if (selectedItems != null &&
                                                              selectedItems!.any((item) =>
                                                                  item['name'] ==
                                                                      'None' &&
                                                                  item['photoURL'] ==
                                                                      '' &&
                                                                  item['uid'] ==
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)) {
                                                            selectedItems!
                                                                .clear();
                                                          } else {
                                                            for (int i = 0;
                                                                i <
                                                                    selectedItems!
                                                                        .length;
                                                                i++) {
                                                              if (selectedItems![
                                                                          i][
                                                                      'name'] ==
                                                                  'None') {
                                                                selectedItems![
                                                                            i][
                                                                        'name'] =
                                                                    selectedPaidBy![
                                                                        'name'];
                                                                selectedItems![
                                                                            i][
                                                                        'photoURL'] =
                                                                    selectedPaidBy![
                                                                        'photoURL'];
                                                                selectedItems![
                                                                            i][
                                                                        'uid'] =
                                                                    selectedPaidBy![
                                                                        'uid'];
                                                              }
                                                            }
                                                          }
                                                          expenses
                                                              .add(ExpenseData(
                                                            rupeeValue: rupee!,
                                                            selectedIcon:
                                                                selectedCategoryIcon,
                                                            PaidBy:
                                                                selectedPaidBy!,
                                                            Split:
                                                                selectedItems,
                                                            Date: selectedDate!,
                                                            creationTime:
                                                                DateTime.now(),
                                                          ));
                                                        });
                                                        updateExpenseData(
                                                            expenses);
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                      } else {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                        _showErrorSnackbar(
                                                            'Please fill all fields');
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Text(
                                                        'Add Expense',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontFamily:
                                                              'ProductSans',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                    child: Text('Add Expenses',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                          fontFamily: 'ProductSans',
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorSnackbar(String Error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        content: Center(
          child: Text(
            Error,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'ProductSans',
              color: Colors.white,
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
}
