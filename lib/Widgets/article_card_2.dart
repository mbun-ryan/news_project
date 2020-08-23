import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleCard2 extends StatelessWidget {
  String f =
      'Yes Indeed, This Is A Sample Articlemmmmmmmm0000000000000000mmkkkkkkkkkkkkkkk';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[500].withOpacity(.3),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListTile(
        leading: Container(
            height: 100,
            width: 100,
            child: Image.asset('assets/images/songoku.jpg')),
        title: Text('${f.substring(0, 50)}...'),
      ),
    );
  }
}
