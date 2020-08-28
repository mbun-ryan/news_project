import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Models/category_model.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';
import 'package:news_project/Widgets/category_card.dart';
import 'package:news_project/Widgets/search_for_articles.dart';
import 'package:news_project/screens/category_screen.dart';

import 'file:///C:/Files%20and%20Docs/Android%20Studio%20Projects/Flutter%20Projects/news_project/lib/Models/helpers.dart';

class AllArticles extends StatefulWidget {
  String country;
  @override
  AllArticles({this.country});
  _AllArticlesState createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles> {
  Future<void> connection() async {
    await ArticleModel(
      countryToQuery: widget.country,
    ).loadArticles();
    setState(() {
      news = ArticleModel(
        countryToQuery: widget.country,
      ).loadArticles();
    });
  }

  void reloadNews(String _) {
    widget.country = _;
    setState(() {
      news = ArticleModel(
        countryToQuery: widget.country,
      ).loadArticles();
    });
  }

  Future news;
  @override
  void initState() {
    super.initState();
    news = ArticleModel(
      countryToQuery: widget.country,
    ).loadArticles();
  }

  String _country;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
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
      ),
      body: RefreshIndicator(
        onRefresh: connection,
        child: FutureBuilder(
          future: news,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
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
                      reloadNews(widget.country);
                    },
                    child: Text('Refresh'),
                  )
                ],
              ));
            } else {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        //padding: EdgeInsets.symmetric(horizontal: 5),
                        //color: Colors.grey.withOpacity(.6),
                        height: 90,
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
                                      category:
                                          '${currentCategory.categoryName}',
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
                      Container(
                        height: 471,
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
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
