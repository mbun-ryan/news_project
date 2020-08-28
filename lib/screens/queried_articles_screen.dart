import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Models/helpers.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';

class QueriedScreen extends StatefulWidget {
  String keyword;
  QueriedScreen({@required this.keyword});
  @override
  _QueriedScreenState createState() => _QueriedScreenState();
}

class _QueriedScreenState extends State<QueriedScreen> {
  Future<void> connection() async {
    await ArticleModel(
      keywordToQuery: widget.keyword,
      language: language,
      sortBy: sortBy,
    ).loadQueriedArticles();
    setState(() {
      reloadNews(lLanguage: language, sSortBy: sortBy);
    });
  }

  String sortBy;
  String language;
  void reloadNews({String lLanguage, String sSortBy}) {
    language = lLanguage;
    sortBy = sSortBy;
    setState(() {
      queriedNews = ArticleModel(
        keywordToQuery: widget.keyword,
        language: language,
        sortBy: sortBy,
      ).loadQueriedArticles();
    });
  }

  Future queriedNews;
  @override
  void initState() {
    super.initState();
    language = 'en';
    sortBy = 'publishedAt';
    queriedNews = ArticleModel(
      keywordToQuery: widget.keyword,
      language: language,
      sortBy: sortBy,
    ).loadQueriedArticles();
  }

  String _sortBy, _language;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: DropdownButton<String>(
              // iconSize: 30,
              icon: Icon(Icons.arrow_drop_down_circle),
              hint: Text('Language'),
              underline: Container(
                height: .3,
                color: Colors.white,
              ),
              iconEnabledColor: Colors.white,
              value: _language,
              onChanged: (value) {
                setState(() {
                  _language = value;
                });
                language = value;
                reloadNews(lLanguage: language, sSortBy: sortBy);
              },
              items: (Helpers()
                  .languages
                  .map((_language) => DropdownMenuItem<String>(
                        child: Container(
                          //margin: EdgeInsets.all(0),
                          //height: 50,
                          // width: 140,
                          child: Center(
                            child: Text(
                              _language['language'],
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        value: _language['symbol'],
                      ))).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: DropdownButton<String>(
              //iconSize: 30,
              icon: Icon(Icons.arrow_drop_down_circle),
              iconEnabledColor: Colors.white,
              value: _sortBy,
              hint: Text('Sort By'),
              underline: Container(
                height: .3,
                color: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _sortBy = value;
                });
                sortBy = value;
                reloadNews(lLanguage: language, sSortBy: sortBy);
              },
              items: (Helpers().sorting.map((_sort) => DropdownMenuItem<String>(
                    child: Container(
                      //margin: EdgeInsets.all(0),
                      //height: 50,
                      // width: 140,
                      child: Center(
                        child: Text(
                          _sort['name'],
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    value: _sort['value'],
                  ))).toList(),
            ),
          ),
        ],
        title: Text(widget.keyword.toUpperCase()),
      ),
      body: RefreshIndicator(
        onRefresh: connection,
        child: FutureBuilder(
          future: queriedNews,
          builder: (context, snapshot) {
            if (widget.keyword.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'OOPS..Nothing Searched For.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.overline.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Search For Something.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.overline.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2),
                    ),
                  ),
                ],
              );
            } else {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data == [] || snapshot.data == null) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                      ),
                      Center(
                        child: Text(
                          'Network Error Occurred',
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          'Check Your Network Connection, and Try Again.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      OutlineButton(
                        onPressed: () {
                          reloadNews(lLanguage: language, sSortBy: sortBy);
                        },
                        child: Text('Refresh'),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                );
              } else if (!snapshot.data.isNotEmpty) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Search Not Found',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.overline.copyWith(
                                      color: Colors.grey,
                                      fontSize: 30,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'No News article containing "${widget.keyword}" was found in ${(Helpers().languages.firstWhere((element) => element['symbol'] == language))['language']}.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.overline.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Check Your Spelling, and Try Again.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.overline.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Consider Searching in Other Languages.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.overline.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              letterSpacing: 2),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                    ],
                  ),
                );
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
            }
          },
        ),
      ),
    );
  }
}
