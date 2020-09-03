import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_project/Models/size_config.dart';
import 'package:news_project/screens/independent_articles_screen.dart';

// ignore: must_be_immutable
class ArticleOfTheDayCard extends StatelessWidget {
  String source;
  String author;
  String title;
  String datePublished;
  String description;
  String url;
  String urlToImage;
  String content;
  ArticleOfTheDayCard(
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
    /* ScreenSizeConfig().init(context);*/

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onLongPress: () => showDialog(
          context: context,
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: Container(
              height: 340,
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
              description: description,
              urlToImage: urlToImage,
              url: url,
              source: source,
              content: content,
              datePublished: datePublished,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              /* width: MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width * .6
                  : MediaQuery.of(context).size.width,*/
              width: ScreenSizeConfig.screenWidth > 600
                  ? constraints.maxWidth / 2
                  : constraints.maxWidth,
              child: Stack(
                children: [
                  Container(
                    //  alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                    height: 100,
                    color: Colors.grey.withOpacity(.5),
                  ),
                  Container(
                    //  alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 12),
                    height: 100,
                    color: Colors.grey.withOpacity(.8),
                  ),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.only(
                        top: 20, bottom: 0, left: 10, right: 10),
                    child: Container(
                      //height: 200,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CachedNetworkImage(
                              imageUrl: urlToImage,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  LinearProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: 5,
                                      ),
                                      // width: 400,
                                      child: Text(
                                        title,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            // ignore: deprecated_member_use
                                            .title
                                            .copyWith(
                                                fontSize: ScreenSizeConfig
                                                            .screenWidth >
                                                        600
                                                    ? constraints.minHeight / 15
                                                    : constraints.minHeight /
                                                        16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Container(
                                      //padding: EdgeInsets.all(5),
                                      width: 50,
                                      alignment: Alignment.centerRight,
                                      //width: 200,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.stars),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ScreenSizeConfig.screenWidth > 600
                ? Container(
                    width: constraints.maxWidth / 2,
                    //  height: 200,
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
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}
