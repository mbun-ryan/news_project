import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_project/Models/size_config.dart';
import 'package:news_project/screens/independent_articles_screen.dart';
import 'package:news_project/screens/web_mode.dart';

// ignore: must_be_immutable
class ArticleCard extends StatelessWidget {
  String source;
  String author;
  String title;
  String datePublished;
  String description;
  String url;
  String urlToImage;
  String content;

  ArticleCard(
      {this.author,
      this.title,
      this.datePublished,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.source});

  @override
  Widget build(BuildContext context) {
/*
    ScreenSizeConfig().init(context);
*/

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onLongPress: () => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).canvasColor.withOpacity(.95),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: Text('Alert!'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlineButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleWebMode(
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
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndependentArticle(
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
        child: Card(
          elevation: 2.5,
          // margin: EdgeInsets.only(left: 2, right: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              /*width: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width * .4
                  : MediaQuery.of(context).size.width * .6,*/
              width: ScreenSizeConfig.safeBlockHorizontal * 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
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
                      placeholder: (context, url) => LinearProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).canvasColor.withOpacity(.9),
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            // ignore: deprecated_member_use
                            style: Theme.of(context).textTheme.title.copyWith(
                                  fontSize: constraints.maxHeight / 17,
                                ),
                          ),
                          Expanded(
                            child: Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontSize: constraints.minHeight / 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
