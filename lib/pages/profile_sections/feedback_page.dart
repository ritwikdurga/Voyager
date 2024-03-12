import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: Text('Feedback',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProductSans')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            TextFormField(
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              decoration: InputDecoration(
                hintText: 'Enter your feedback',
                hintStyle: TextStyle(
                    color: Colors.grey.shade800, fontFamily: 'ProductSans'),
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                // Submit feedback logic
              },
              child: Text('Submit', style: TextStyle(fontSize:16,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'ProductSans')),
            ),
          ],
        ),
      ),
    );
  }
}
