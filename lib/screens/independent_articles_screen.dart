import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:news_project/screens/web_mode.dart';

class IndependentArticle extends StatefulWidget {
  final String source;
  final String author;
  final String title;
  final String datePublished;
  final String description;
  final String url;
  final String urlToImage;
  final String content;

  IndependentArticle({
    @required this.author,
    @required this.title,
    @required this.datePublished,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.content,
    @required this.source,
  });

  @override
  _IndependentArticleState createState() => _IndependentArticleState();
}

class _IndependentArticleState extends State<IndependentArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(Icons.more_vert),
              iconEnabledColor: Colors.white,
              // value: 'Open In Web mode',
              items: [
                DropdownMenuItem(
                  child: Container(
                      margin: EdgeInsets.all(0),
                      height: 50,
                      width: 90,
                      child: Center(
                          child: Text(
                        'Open In Web Mode',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w300),
                      ))),
                  value: widget.url,
                ),
              ],
              onChanged: (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleWebMode(
                            url: value,
                          ))),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        //padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(1),
              child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * .38
                        : MediaQuery.of(context).size.height * .5,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.blueGrey),
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.urlToImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => LinearProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: Card(
                          margin: EdgeInsets.only(right: 5),
                          elevation: 100,
                          color: Colors.white70,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text('Author - ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline
                                        .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.grey[900])),
                                Expanded(
                                  child: Text(
                                    widget.author,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 2, bottom: 1, left: 3, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          top: 0, bottom: 2, left: 10, right: 0),
                      title: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              'Source - ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                widget.source,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                      subtitle: Text(
                        '${DateFormat().add_yMMMEd().format(DateTime.parse(widget.datePublished))}',
                      ),
                      // color: Colors.grey.withOpacity(.03),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Center(
                      child: Divider(
                        height: 0,
                        thickness: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text(
                      widget.description, // textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text(
                      widget.content,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.grey,
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 10),
                    child: OutlineButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticleWebMode(
                                        url: widget.url,
                                      )));
                        },
                        child: Text('Open In Web Mode')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
