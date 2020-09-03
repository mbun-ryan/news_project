import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Models/category_model.dart';
import 'package:news_project/Models/size_config.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';
import 'package:news_project/Widgets/category_card.dart';
import 'package:news_project/Widgets/search_for_articles.dart';
import 'package:news_project/screens/category_screen.dart';

import 'file:///C:/Files%20and%20Docs/Android%20Studio%20Projects/Flutter%20Projects/news_project/lib/Models/helpers.dart';

// ignore: must_be_immutable
class AllArticles extends StatefulWidget {
  String country;
  bool lockLanguageToEnglish;
  @override
  AllArticles({this.country, this.lockLanguageToEnglish});
  _AllArticlesState createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles> {
  Future<void> connection() async {
    await Future.delayed(Duration(seconds: 2));
    reloadNews(widget.country);
  }

  void reloadNews(String _) {
    widget.country = _;
    setState(() {
      news = ArticleModel(
              countryToQuery: widget.country,
              lockLanguageToEnglish: widget.lockLanguageToEnglish)
          .loadArticles();
    });
  }

  Future news;
  @override
  void initState() {
    super.initState();
    news = ArticleModel(
            countryToQuery: widget.country,
            lockLanguageToEnglish: widget.lockLanguageToEnglish)
        .loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('All Articles'),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: QueryArticles(),
              );
            }),
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: DropdownButton<String>(
            iconSize: 30,
            icon: Icon(Icons.location_on),
            iconEnabledColor: Colors.white,
            underline: Container(
              height: .3,
              color: Colors.white,
            ),
            value: widget.country,
            hint: Text('Country'),
            onChanged: (value) {
              setState(() {
                widget.country = value;
              });
              reloadNews(value);
            },
            items: (Helpers().countries.map(
                  (_country) => DropdownMenuItem<String>(
                    child: Container(
                      //margin: EdgeInsets.all(0),
                      //height: 50,
                      // width: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25,
                            height: 20,
                            child: Flag(
                              _country['symbol'],
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 105,
                            child: Text(
                              _country['name'],
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: _country['symbol'],
                  ),
                )).toList(),
          ),
        ),
      ],
    );
    ScreenSizeConfig().init(context);
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: appBar,
      body: FutureBuilder(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                widget.lockLanguageToEnglish
                    ? Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Getting And Translating News To English',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Getting News',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ),
              ],
            );
          } else if (snapshot.error != null) {
            return Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Network Error Occurred',
                    style: TextStyle(fontSize: 30, color: Colors.grey),
                  ),
                ),
                Container(
                  child: Text(
                    'Check Your Connection',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                OutlineButton(
                  onPressed: () {
                    reloadNews(widget.country);
                  },
                  child: Text('Refresh'),
                )
              ],
            ));
          } else if (snapshot.data.isEmpty) {
            return Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Internal Error Occurred',
                    style: TextStyle(fontSize: 30, color: Colors.grey),
                  ),
                ),
                Container(
                  child: Text(
                    'Sorry',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                OutlineButton(
                  onPressed: () {
                    reloadNews(
                      widget.country,
                    );
                  },
                  child: Text('Refresh'),
                )
              ],
            ));
          } else {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      //padding: EdgeInsets.symmetric(horizontal: 5),
                      //color: Colors.grey.withOpacity(.6),
                      height: ScreenSizeConfig.screenWidth > 600
                          ? (ScreenSizeConfig.blockSizeVertical -
                                  appBar.preferredSize.height) *
                              .18
                          : (ScreenSizeConfig.blockSizeVertical -
                                  appBar.preferredSize.height) *
                              .13,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: loadCategories().length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final CategoryModel currentCategory =
                              loadCategories()[index];
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return CategoryScreen(
                                    country: widget.country,
                                    lockLanguageToEnglish:
                                        widget.lockLanguageToEnglish,
                                    category: '${currentCategory.categoryName}',
                                  );
                                },
                              ),
                            ),
                            child: CategoryCard(
                              categoryName: currentCategory.categoryName,
                              imageUrl: currentCategory.imageUrl,
                            ),
                          );
                        },
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: connection,
                      child: Container(
                        height: (ScreenSizeConfig.blockSizeVertical -
                                appBar.preferredSize.height) *
                            .85,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            // ArticleModel articleModel = ArticleModel();
                            var currentArticle = snapshot.data[index];
                            return AlternativeArticleCard(
                              bottomPadding:
                                  index == snapshot.data.length ? 20 : 0,
                              author: currentArticle.author,
                              source: currentArticle.source,
                              content: currentArticle.content,
                              title: currentArticle.title,
                              datePublished: currentArticle.datePublished,
                              description: currentArticle.description,
                              url: currentArticle.url,
                              urlToImage: currentArticle.urlToImage,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
