import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:news_project/Models/size_config.dart';
import 'package:news_project/screens/independent_articles_screen.dart';
import 'package:news_project/screens/web_mode.dart';

// ignore: must_be_immutable
class AlternativeArticleCard extends StatelessWidget {
  double bottomPadding = 0;

  final String source;
  final String author;
  final String title;
  final String datePublished;
  final String description;
  final String url;
  final String urlToImage;
  final String content;

  AlternativeArticleCard({
    this.bottomPadding,
    this.author,
    this.title,
    this.datePublished,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
    this.source,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return GestureDetector(
      onLongPress: () => showDialog(
        context: context,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 400,
            child: IndependentArticle(
              author: author,
              title: title,
              description: description,
              urlToImage: urlToImage,
              url: url,
              source: source,
              content: content,
              datePublished: datePublished,
            ),
          ),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IndependentArticle(
                  author: author,
                  title: title,
                  datePublished: datePublished,
                  description: description,
                  url: url,
                  urlToImage: urlToImage,
                  content: content,
                  source: source))),
      child: Card(
        color: Theme.of(context).canvasColor.withOpacity(.7),
        margin: ScreenSizeConfig.screenWidth > 600
            ? EdgeInsets.only(
                left: 70, right: 70, top: 10, bottom: bottomPadding)
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
                      child: CachedNetworkImage(
                        imageUrl: urlToImage,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            LinearProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 0, top: 5, bottom: 4),
                          child: Text(title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              // ignore: deprecated_member_use
                              style: Theme.of(context).textTheme.title.copyWith(
                                    fontSize: 16,
                                  )),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 0, top: 0, bottom: 0),
                          child: Text(description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.w300,
                                  ) /*TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              letterSpacing: .5,
                              wordSpacing: 2,
                            ),*/
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 0, bottom: 8),
                  child: Text(
                    '${DateFormat.yMMMd().format(DateTime.parse(datePublished))}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: 150,
                  padding: EdgeInsets.only(left: 0, top: 0, bottom: 8),
                  child: Text(
                    '#$source',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        //  color: Colors.grey,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 40,
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(Icons.more_vert),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor:
                                Theme.of(context).canvasColor.withOpacity(.95),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Text('Alert!'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    OutlineButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ArticleWebMode(
                                                url: url,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text('Web Mode')),
                                    OutlineButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Share.text(title, url, 'text/plain');
                                        },
                                        child: Text('Share')),
                                  ],
                                ),
                                OutlineButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Back')),
                              ],
                            ),
                          );
                        }),
                    //padding: EdgeInsets.all(3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
