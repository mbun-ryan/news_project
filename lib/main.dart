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
      title: 'News++',
      theme: ThemeData(
        fontFamily: 'QuickSand',
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.grey,
        canvasColor: Color.fromRGBO(215, 218, 220, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                title: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
