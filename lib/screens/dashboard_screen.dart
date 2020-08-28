import 'dart:math';

import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Models/helpers.dart';
import 'package:news_project/Widgets/article_card.dart';
import 'package:news_project/Widgets/article_of_the_day_card.dart';
import 'package:news_project/Widgets/search_for_articles.dart';
import 'package:news_project/screens/all_articles_screen.dart';

class Dashboard extends StatefulWidget {
  String country = 'us';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> connection() async {
    await ArticleModel(
      countryToQuery: widget.country,
    ).loadArticles();
    reloadNews(widget.country);
  }

  Future news;
  @override
  void initState() {
    super.initState();
    news = ArticleModel(
      countryToQuery: widget.country,
    ).loadArticles();
  }

  void reloadNews(String _) {
    widget.country = _;
    setState(() {
      news = ArticleModel(
        countryToQuery: widget.country,
      ).loadArticles();
    });
  }

  String country2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        actions: [
          MediaQuery.of(context).size.width > 600
              ? Container(
                  margin: EdgeInsets.all(10),
                  child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: QueryArticles(),
                        );
                      }),
                )
              : Container(),
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
              value: country2,
              hint: Text('Country'),
              onChanged: (value) {
                setState(() {
                  country2 = value;
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
        title: Text('Dashboard'),
      ),
      drawer: Drawer(),
      body: RefreshIndicator(
        onRefresh: connection,
        child: FutureBuilder(
          future: news,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error != null ||
                snapshot.data == [] ||
                snapshot.data == null) {
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
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  // padding: EdgeInsets.all(10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MediaQuery.of(context).size.width > 600
                          ? Container()
                          : GestureDetector(
                              onTap: () => showSearch(
                                  context: context, delegate: QueryArticles()),
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    icon: Icon(
                                      Icons.search,
                                      size: 35,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        // color: Colors.brown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MediaQuery.of(context).size.width > 600
                                ? Container(
                                    margin: EdgeInsets.all(0),
                                    color: Colors.white.withOpacity(1),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Articles',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.blue[800]),
                                    ),
                                  )
                                : Text(
                                    'Articles',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17),
                                  ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllArticles(
                                    country: widget.country,
                                  ),
                                ),
                              ),
                              child: MediaQuery.of(context).size.width > 600
                                  ? Card(
                                      margin: EdgeInsets.all(0),
                                      color: Colors.blueGrey.withOpacity(.3),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'All Articles',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.blue[800]),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'All Articles',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.blue[800]),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 220,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          //reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var currentArticle = snapshot.data[index];
                            return ArticleCard(
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
                          itemCount: 10,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MediaQuery.of(context).size.width > 600
                              ? Container(
                                  margin: EdgeInsets.only(top: 15, bottom: 5),
                                  color: Colors.white.withOpacity(1),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Articles Of The Day',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.blue[800]),
                                  ),
                                )
                              : Container(
                                  // color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      top: 15, bottom: 5, left: 0),
                                  child: Text(
                                    'Article Of The Day',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ),
                        ],
                      ),
                      Container(
                          height: 210,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var currentArticle = snapshot.data[index];
                              int rand = Random().nextInt(snapshot.data.length);
                              return ArticleOfTheDayCard(
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
                            itemCount: 1,
                          ))
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
