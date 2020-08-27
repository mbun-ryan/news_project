import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_project/screens/independent_articles_screen.dart';
import 'package:news_project/screens/web_mode.dart';

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
    return GestureDetector(
      onLongPress: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Alert!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Do You Want To View the Article\'s website?',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No')),
                      OutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticleWebMode(
                                          url: url,
                                        )));
                          },
                          child: Text('Yes')),
                    ],
                  ),
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
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * .4
                : MediaQuery.of(context).size.width * .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisAlignment: MainAxisAlignment.start,
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
                  // flex: 1,
                  // height: (200 * .3).toDouble(), width: double.infinity,
                  child: Container(
                    color: Colors.grey,
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w300),
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
  }
}
