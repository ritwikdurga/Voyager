// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class BudInp extends StatefulWidget {
  final Function(String?) budgetselected;
  const BudInp({super.key, required this.budgetselected});

  @override
  State<BudInp> createState() => _BudInpState();
}

class CustomTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
    if (newText.contains('.')) {
      newText = newText.substring(0, newText.indexOf('.') + 1) +
          newText.substring(newText.indexOf('.') + 1).replaceAll('.', '');
    }
    return newValue.copyWith(text: newText);
  }
}

class _BudInpState extends State<BudInp> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          'Please select your budget',
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 24,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        SizedBox(
          width: 0.25 * screenWidth,
          child: TextField(
            decoration: InputDecoration(
              alignLabelWithHint: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              hintText: '0.00',
            ),
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputFormatters: <TextInputFormatter>[
              CustomTextInputFormatter(),
              LengthLimitingTextInputFormatter(5),
            ],
            textInputAction: TextInputAction.done,
            onSubmitted: (val) {
              widget.budgetselected(val);
            },
          ),
        ),
      ],
    );
  }
}
