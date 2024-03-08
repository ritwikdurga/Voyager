import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../services/auth_service.dart';
import '../utils/constants.dart';


class SocialAuth extends StatelessWidget {
  final Function()? onPressGoogle;
  final Function()? onPressApple;
  const SocialAuth({super.key, required this.onPressGoogle, required this.onPressApple});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      // create google icon and apple icon seperately
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onPressGoogle,
            icon: Icon(
              Ionicons.logo_google,
              size: 45,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: onPressApple,
            icon: Icon(
              Ionicons.logo_apple,
              size: 47,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

