import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';
import 'package:news_project/Widgets/helpers.dart';
import 'package:news_project/Widgets/search_for_articles.dart';

class CategoryScreen extends StatefulWidget {
  String category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<void> connection() async {
    await ArticleModel(countryToQuery: country, category: widget.category);
    reloadNews(country);
  }

  String country;
  void reloadNews(String _) {
    country = _;
    setState(() {
      categoryNews =
          ArticleModel(countryToQuery: country, category: widget.category)
              .loadArticles();
    });
  }

  Future categoryNews;
  @override
  void initState() {
    super.initState();
    categoryNews =
        ArticleModel(countryToQuery: country, category: widget.category)
            .loadCategoryArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      reloadNews(country);
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

            if (snapshot.data != null) {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 550,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
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
            } else if (snapshot.hasError) {
              return Center(
                child: Text('...Error...'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
