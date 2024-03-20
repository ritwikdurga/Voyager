import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';
import 'user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key}); // Added key parameter

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String name;
  late String uid;
  late String email;
  bool isEditing = false;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    name = auth.currentUser?.displayName as String;
    email = auth.currentUser?.email as String;
    uid = auth.currentUser?.uid as String;
    nameController = TextEditingController(text: name);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      appBar: AppBar(
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'ProductSans',
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(
                      'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? darkColorScheme.background
                          : lightColorScheme.background,
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
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Consumer<UserProvider>(
                                builder: (context, userProvider, _) {
                                  return isEditing
                                      ? TextFormField(
                                          autofocus: true,
                                          controller: nameController,
                                          onChanged: (value) {
                                            userProvider.updateName(
                                                value); // Update name in UserProvider
                                          },
                                          style: TextStyle(
                                            fontFamily: "ProductSans",
                                            fontWeight: FontWeight.bold,
                                            color: themeProvider.themeMode ==
                                                    ThemeMode.dark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        )
                                      : Text(
                                          userProvider
                                              .name, // Use name from UserProvider
                                          style: TextStyle(
                                            fontFamily: "ProductSans",
                                            fontWeight: FontWeight.bold,
                                            color: themeProvider.themeMode ==
                                                    ThemeMode.dark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        );
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(isEditing ? Icons.check : Icons.edit,
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                                size: 20),
                            onPressed: () async {
                              if (isEditing) {
                                FirebaseAuth.instance
                                    .authStateChanges()
                                    .listen((User? user) async {
                                  if (user != null) {
                                    await user.updateDisplayName(name);
                                    nameUpdated();
                                    final FirebaseFirestore db =
                                        FirebaseFirestore.instance;
                                    var userdata = db.collection("users");
                                    await userdata
                                        .doc(user.uid)
                                        .update({'name': name});
                                  }
                                });
                              }
                              setState(() {
                                if (isEditing) {
                                  name = nameController.text;
                                }
                                isEditing = !isEditing;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? darkColorScheme.background
                          : lightColorScheme.background,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 1.5, top: 3),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4.2),
                              child: Text(
                                email,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ProductSans",
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email);
                          emailSent();
                        },
                        child: Text('Reset Password',
                            style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.white,
                                fontWeight: FontWeight.bold)),
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

  void nameUpdated() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              'Successfully Updated',
              style: TextStyle(
                fontSize: 16, // Change the font size as needed
                fontFamily: 'ProductSans', // Change the font family as needed
              ),
            ),
          ),
        ),
      );
    }
  }

  void emailSent() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              'Email sent successfully. Check your inbox!',
              style: TextStyle(
                fontSize: 16, // Change the font size as needed
                fontFamily: 'ProductSans', // Change the font family as needed
              ),
            ),
          ),
        ),
      );
    }
  }
}
