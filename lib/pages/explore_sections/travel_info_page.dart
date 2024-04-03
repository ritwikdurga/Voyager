// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TravelInfoPage extends StatefulWidget {
  late String heading;
  TravelInfoPage({super.key, required this.heading});

  @override
  State<TravelInfoPage> createState() => _TravelInfoPageState();
}

class _TravelInfoPageState extends State<TravelInfoPage> {
  var loadingPercentage = 0;
  late WebViewController controller = WebViewController();

  Map<String, String> headingParameters = {
    'Understand': 'Understand',
    'Travel': 'Get_in',
    'Get around': 'Get_around',
    'Events': 'See',
    'Safety': 'Stay_safe',
  };

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  
  void initializeController() async {
  final String headingParameter = headingParameters[widget.heading] ?? '';
  final String url = 'https://wikitravel.org/en/Paris#${headingParameter}';

  controller = WebViewController();
  
  controller.setNavigationDelegate(NavigationDelegate(
    onPageStarted: (url) {
      if (mounted) {
        setState(() {
          loadingPercentage = 0;
        });
      }
    },
    onProgress: (progress) {
      if (mounted) {
        setState(() {
          loadingPercentage = progress;
        });
      }
    },
    onPageFinished: (url) {
      if (mounted) {
        setState(() {
          loadingPercentage = 100;
        });
      }
    },
  ));

  controller.loadRequest(
    Uri.parse(url),
  );
}


  @override
  void dispose() {
    super.dispose();
    controller.clearCache();
    controller.clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.heading,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
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
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
