import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlternativeArticleCard extends StatelessWidget {
  double bottomPadding = 0;

  String source;
  String title;
  String datePublished;
  String description;
  String url;
  String urlToImage;
  String content;

  AlternativeArticleCard(
      {this.bottomPadding,
      this.source,
      this.title,
      this.datePublished,
      this.description,
      this.url,
      this.urlToImage,
      this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: MediaQuery.of(context).orientation == Orientation.landscape
          ? EdgeInsets.only(left: 40, right: 40, top: 10, bottom: bottomPadding)
          : EdgeInsets.only(
              left: 10, right: 10, top: 10, bottom: bottomPadding),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 12, right: 0, bottom: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(urlToImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //color: Colors.grey,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  // height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 0, top: 5, bottom: 5),
                        child: Text(title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: Theme.of(context).textTheme.title.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                )),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 0, top: 5, bottom: 0),
                        child: Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            letterSpacing: .5,
                            wordSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 0, bottom: 8),
                  child: Text(
                    '$datePublished - $source',
                    style: Theme.of(context)
                        .textTheme
                        .overline
                        .copyWith(fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                height: 40,
                child: IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                  //padding: EdgeInsets.all(3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
