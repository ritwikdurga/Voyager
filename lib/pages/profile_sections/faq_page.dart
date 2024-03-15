import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

final List<FAQItem> _data = [
  FAQItem(
      title: 'Can I search for flights and trains in one place?',
      answer:
          'Yes! Our app allows you to search and compare options for all your travel needs in a single platform.'),
  FAQItem(
      title: 'Can I create a personalized itinerary?',
      answer:
          'Absolutely! You can build your dream trip by adding destinations, activities, and transportation to your itinerary.'),
  FAQItem(
      title: 'Can I share my itinerary with others?',
      answer:
          'Yes, you can easily share your itinerary with friends, family, or travel companions for collaborative planning.'),
  FAQItem(
      title: 'How can I track my travel expenses?',
      answer:
          'Our expense tracking tool allows you to log your spending throughout your trip, helping you stay within budget.'),
  FAQItem(
      title: 'Does the app integrate with maps?',
      answer:
          'Yes, it seamlessly integrates with maps and navigation services.'),
  FAQItem(
      title: 'Can I see reviews and ratings?',
      answer: 'Yes, you can access reviews and ratings from other travelers.'),
  FAQItem(
      title: 'Will I receive personalized alerts?',
      answer:
          'Yes, you\'ll get alerts for any kind of travel updates and reminders, weather updates, and reminders.'),
  FAQItem(
      title: 'Can I categorize my expenses?',
      answer:
          'Yes, you can categorize your expenses for flights, accommodation, food, activities, and more for better budgeting insights.'),
  FAQItem(
      title:
          'Will I be able to access my itinerary without internet connection?',
      answer:
          'Yes! Essential details like your itinerary schedule and saved locations can be accessed offline.'),
  FAQItem(
      title: 'How does the AI itinerary builder work?',
      answer:
          'Our AI assistant considers your preferences, travel constraints, and real-time data to suggest optimized itineraries, maximizing your travel experience.'),
  FAQItem(
      title: 'Can I customize the AI-suggested itinerary?',
      answer:
          'Yes! The AI provides suggestions, but you have complete control to personalize and adjust the itinerary to your liking.'),
];

class FAQItem {
  final String title;
  final String answer;

  FAQItem({required this.title, required this.answer});
}

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: themeProvider.themeMode == ThemeMode.dark
              ? Colors.white
              : Colors.black, size: 20,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
        title: Text(
          'FAQ',
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.bold,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final item = _data[index];
          return ExpansionTile(
            title: Text(item.title,
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 16.0,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
                textAlign: TextAlign.left),
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(item.answer,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    textAlign: TextAlign.left),
              ),
            ],
          );
        },
      ),
    );
  }
}
