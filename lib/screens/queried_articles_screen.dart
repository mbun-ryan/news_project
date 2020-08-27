import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';
import 'package:news_project/Widgets/helpers.dart';

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
    ).loadQueriedArticles();
    setState(() {
      reloadNews(language);
    });
  }

  String language = 'en';
  void reloadNews(String _) {
    language = _;
    setState(() {
      queriedNews = ArticleModel(
        keywordToQuery: widget.keyword,
        language: language,
      ).loadQueriedArticles();
    });
  }

  Future queriedNews;
  @override
  void initState() {
    super.initState();
    queriedNews = ArticleModel(
      keywordToQuery: widget.keyword,
      language: language,
    ).loadQueriedArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            iconSize: 40,
            icon: Icon(Icons.language),
            iconEnabledColor: Colors.white,
            onChanged: (value) {
              reloadNews(value);
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
          )),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
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
              } else if (snapshot.data != [] &&
                  snapshot.data != null &&
                  snapshot.data.isNotEmpty) {
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
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Seems Like There\'s A problem.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.overline.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'The Keyword You Searched For Was Not Found.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.overline.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Check Your Spelling, Network Connection, and Try Again.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.overline.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.isNotEmpty && snapshot.data != null) {
                } else {}
              } else {}
            }
          },
        ),
      ),
    );
  }
}
