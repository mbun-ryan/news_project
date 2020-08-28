import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';
import 'package:news_project/Widgets/search_for_articles.dart';

import 'file:///C:/Files%20and%20Docs/Android%20Studio%20Projects/Flutter%20Projects/news_project/lib/Models/helpers.dart';

class CategoryScreen extends StatefulWidget {
  String category;
  String country;
  CategoryScreen({this.category, this.country});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<void> connection() async {
    await ArticleModel(
            countryToQuery: widget.country, category: widget.category)
        .loadArticles();
  }

  void reloadNews(String _) {
    widget.country = _;
    setState(() {
      categoryNews = ArticleModel(
              countryToQuery: widget.country, category: widget.category)
          .loadArticles();
    });
  }

  Future categoryNews;
  @override
  void initState() {
    super.initState();
    categoryNews =
        ArticleModel(countryToQuery: widget.country, category: widget.category)
            .loadCategoryArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            padding: const EdgeInsets.only(right: 5),
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
        title: Text(widget.category.toUpperCase()),
      ),
      body: RefreshIndicator(
        onRefresh: connection,
        child: FutureBuilder(
          future: categoryNews,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
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
                        height: 550,
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
