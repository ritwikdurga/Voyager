import 'package:flutter/material.dart';
import 'package:voyager/utils/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'ProductSans')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            // Add functionality here to navigate back
            // For example: Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                // Editable fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 20, bottom: 1.5, top: 3),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: TextField(
                                // controller:
                                // TextEditingController(text: "John Doe" ),
                                // add a dummy text controller with white text
                                controller: TextEditingController(
                                    text: "John Doe"),
                                // make the controller text color white
                                readOnly: true,
                                // Make the TextField non-editable
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              // Add functionality to edit name
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 20, bottom: 1.5, top: 3),
                      child: Row(
                        children: [
                          Icon(
                            Icons.sms,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4.2),
                              child: TextField(
                                controller: TextEditingController(
                                    text: "JohnDeo@gmail.com"),
                                readOnly: true,
                                // Make the TextField non-editable
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ProductSans",
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 170,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          // Add functionality to add profile photo
                        },
                        child: const Text('Update Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 170,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          // Add functionality to add profile photo
                        },
                        child: const Text('Reset Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}