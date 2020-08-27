import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Models/category_model.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';
import 'package:news_project/Widgets/category_card.dart';
import 'package:news_project/Widgets/helpers.dart';
import 'package:news_project/Widgets/search_for_articles.dart';

class AllArticles extends StatefulWidget {
  @override
  _AllArticlesState createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles> {
  Future<void> connection() async {
    await ArticleModel(
      countryToQuery: country,
    ).loadArticles();
    setState(() {
      news = ArticleModel(
        countryToQuery: country,
      ).loadArticles();
    });
  }

  String country = 'us';
  void reloadNews(String _) {
    country = _;
    setState(() {
      news = ArticleModel(
        countryToQuery: country,
      ).loadArticles();
    });
  }

  Future news;
  @override
  void initState() {
    super.initState();
    news = ArticleModel(
      countryToQuery: country,
    ).loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('All Articles'),
        actions: [
          Stack(
            children: [
              DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                iconSize: 40,
                icon: Icon(Icons.edit_location),
                iconEnabledColor: Colors.white,
                onChanged: (value) {
                  reloadNews(value);
                },
                items: (Helpers()
                    .countries
                    .map((_country) => DropdownMenuItem<String>(
                          child: Container(
                            //margin: EdgeInsets.all(0),
                            //height: 50,
                            // width: 140,
                            child: Center(
                              child: Text(
                                _country['name'],
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          value: _country['symbol'],
                        ))).toList(),
              )),
              Positioned(
                  right: 40,
                  child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: QueryArticles(),
                        );
                      })),
            ],
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
                      'Network Error Occured',
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
                      setState(() {
                        setState(() {
                          news = ArticleModel(
                                  countryToQuery: 'us',
                                  keywordToQuery: 'covid-19',
                                  sourceToQuery: 'reuters')
                              .loadArticles();
                        });
                      });
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
                            return CategoryCard(
                              categoryName: currentCategory.categoryName,
                              imageUrl: currentCategory.imageUrl,
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
