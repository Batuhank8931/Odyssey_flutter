import 'package:flutter/material.dart';
import 'screens/webinar_list_screen.dart';

void main() {
  runApp(WebinarApp());
}

class WebinarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webinar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebinarListScreen(),
    );
  }
}
