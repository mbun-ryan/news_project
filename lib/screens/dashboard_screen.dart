import 'dart:ui';

import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Models/helpers.dart';
import 'package:news_project/Models/size_config.dart';
import 'package:news_project/Widgets/article_card.dart';
import 'package:news_project/Widgets/article_of_the_day_card.dart';
import 'package:news_project/Widgets/search_for_articles.dart';
import 'package:news_project/screens/all_articles_screen.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  String country = 'us';
  bool lockLanguageToEnglish = false;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> connection() async {
    await Future.delayed(Duration(seconds: 2));
    reloadNews(
      widget.country,
    );
  }

  Future news;
  @override
  void initState() {
    super.initState();
    widget.lockLanguageToEnglish = false;
    news = ArticleModel(
            countryToQuery: widget.country,
            lockLanguageToEnglish: widget.lockLanguageToEnglish)
        .loadArticles();
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

  bool isTranslatedEnglish = false;
  void toggleEnglishTranslation() {
    isTranslatedEnglish = !isTranslatedEnglish;
    if (widget.lockLanguageToEnglish == null) {
      widget.lockLanguageToEnglish = true;
    } else if (widget.lockLanguageToEnglish) {
      widget.lockLanguageToEnglish = false;
    } else {
      widget.lockLanguageToEnglish = true;
    }
    reloadNews(widget.country);
    Navigator.of(context).pop();
  }

  String country2;
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
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
          Container(
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(1),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 20, right: 20, bottom: 10),
                        child: Text(
                          'Get The Latest News From Top Trust Worthy News Sources.',
                          // ignore: deprecated_member_use
                          style: Theme.of(context).textTheme.title.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'OpenSans',
                              color: Colors.white60),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          'This app is still in "BETA", so expect some minor issues.',
                          textAlign: TextAlign.center,
                          // ignore: deprecated_member_use
                          style: Theme.of(context).textTheme.title.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  color: Theme.of(context).primaryColor,
                )),
            ListTile(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllArticles(
                          lockLanguageToEnglish: widget.lockLanguageToEnglish,
                          country: widget.country,
                        ),
                      ),
                    ),
                leading: Icon(Icons.call_to_action),
                trailing: Icon(Icons.arrow_upward),
                title: Text(
                  'All Articles',
                  style:
                      // ignore: deprecated_member_use
                      Theme.of(context).textTheme.title.copyWith(fontSize: 17),
                )),
            Divider(
              thickness: .5,
              color: Colors.blueGrey,
            ),
            ListTile(
              leading: Icon(Icons.language),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  '(Beta)\nTranslate news articles in other languages to English, except in "search" mode.',
                  style: Theme.of(context)
                      .textTheme
                      // ignore: deprecated_member_use
                      .subhead
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ),
              trailing: IconButton(
                padding: EdgeInsets.only(left: 40),
                icon: Icon(isTranslatedEnglish
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                onPressed: () => toggleEnglishTranslation(),
              ),
              title: Text(
                'Translate To English',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 17,
                    ),
              ),
            ),
          ],
        ),
      ),
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
                      )
              ],
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
            return RefreshIndicator(
              onRefresh: connection,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    children: [
                      MediaQuery.of(context).size.width > 600
                          ? Container()
                          : GestureDetector(
                              onTap: () => showSearch(
                                  context: context, delegate: QueryArticles()),
                              child: Container(
                                height: ScreenSizeConfig.safeBlockVertical * 10,
                                // padding: EdgeInsets.only(right: 10, top: 20),
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
                                    color: Colors.white.withOpacity(.3),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Articles',
                                      style: Theme.of(context)
                                          .textTheme
                                          // ignore: deprecated_member_use
                                          .headline
                                          .copyWith(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'OpenSans',

                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(1),
                                          ),
                                    ),
                                  )
                                : Text(
                                    'Articles',
                                    style: Theme.of(context)
                                        .textTheme
                                        // ignore: deprecated_member_use
                                        .headline
                                        .copyWith(
                                          fontFamily: 'OpenSans',
                                          fontSize: 17,
                                        ),
                                  ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllArticles(
                                    country: widget.country,
                                    lockLanguageToEnglish:
                                        widget.lockLanguageToEnglish,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              // ignore: deprecated_member_use
                                              .title
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19,
                                                  fontFamily: 'OpenSans',
                                                  color: Colors.blue[900]),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'All Articles',
                                      style: Theme.of(context)
                                          .textTheme
                                          // ignore: deprecated_member_use
                                          .title
                                          .copyWith(
                                              fontSize: 19,
                                              color: Colors.blue[900]),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: ScreenSizeConfig.safeBlockVertical * 38,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
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
                          itemCount: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MediaQuery.of(context).size.width > 600
                              ? Container(
                                  margin: EdgeInsets.only(top: 15, bottom: 5),
                                  color: Colors.white.withOpacity(.3),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Article Of The Day',
                                    style: Theme.of(context)
                                        .textTheme
                                        // ignore: deprecated_member_use
                                        .headline
                                        .copyWith(
                                          fontSize: 17,
                                          fontFamily: 'OpenSans',
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(1),
                                        ),
                                  ),
                                )
                              : Container(
                                  // color: Colors.grey,
                                  padding: EdgeInsets.only(
                                      top: 15, bottom: 5, left: 0),
                                  child: Text(
                                    'Article Of The Day',
                                    style: Theme.of(context)
                                        .textTheme
                                        // ignore: deprecated_member_use
                                        .headline
                                        .copyWith(
                                          fontSize: 17,
                                          fontFamily: 'OpenSans',
                                        ),
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: ScreenSizeConfig.safeBlockVertical * 40,
                        width: ScreenSizeConfig.screenWidth,
                        child: ArticleOfTheDayCard(
                          author: snapshot.data[5].author,
                          source: snapshot.data[5].source,
                          content: snapshot.data[5].content,
                          title: snapshot.data[5].title,
                          datePublished: snapshot.data[5].datePublished,
                          description: snapshot.data[5].description,
                          url: snapshot.data[5].url,
                          urlToImage: snapshot.data[5].urlToImage,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
