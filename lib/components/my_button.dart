import 'package:flutter/material.dart';
import 'package:group9_auth/utils/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5,
            spreadRadius: 3,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kGreenColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlackColor,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
