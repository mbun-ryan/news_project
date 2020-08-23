import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/screens/dashboard_screen.dart';

void main() {
  runApp(NewsProject());
}

class NewsProject extends StatefulWidget {
  @override
  _NewsProjectState createState() => _NewsProjectState();
}

class _NewsProjectState extends State<NewsProject> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Project',
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
