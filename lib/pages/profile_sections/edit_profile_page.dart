import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';
import 'user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String name;
  late String photoURL;
  late String email;
  bool isEditing = false;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    name = auth.currentUser?.displayName ?? '';
    email = auth.currentUser?.email ?? '';
    photoURL = auth.currentUser?.photoURL ?? '';
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(photoURL),
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
                            child: isEditing
                                ? TextFormField(
                                    autofocus: true,
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
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
                                      hintText: "Name",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "ProductSans",
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  )
                                : Text(
                                    name,
                                    style: TextStyle(
                                      fontFamily: "ProductSans",
                                      fontWeight: FontWeight.bold,
                                      color: themeProvider.themeMode ==
                                              ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
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
                              setState(() {
                                isEditing = !isEditing;
                                if (!isEditing &&
                                    nameController.text.isNotEmpty) {
                                  updateName(nameController.text);
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .updateName(nameController.text);
                                } else if (nameController.text.isEmpty) {
                                  emptyName();
                                }
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

  void updateName(String newName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      try {
        setState(() {
          name = newName;
        });
        await user.updateDisplayName(newName);
        final db = FirebaseFirestore.instance;
        var userdata = db.collection("users");
        await userdata.doc(user.uid).update({'name': newName});
        nameUpdated();
      } catch (e) {
        print('Error updating name: $e');
      }
    }
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
                fontSize: 16,
                fontFamily: 'ProductSans',
              ),
            ),
          ),
        ),
      );
    }
  }

  void emptyName() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Center(
            child: Text(
              'Name Cannot be Empty',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'ProductSans',
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
