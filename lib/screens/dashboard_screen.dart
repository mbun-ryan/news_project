import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Widgets/article_card.dart';
import 'package:news_project/Widgets/article_of_the_day_card.dart';
import 'package:news_project/Widgets/helpers.dart';
import 'package:news_project/Widgets/search_for_articles.dart';
import 'package:news_project/screens/all_articles_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> connection() async {
    await ArticleModel(
      countryToQuery: country,
    ).loadArticles();
    reloadNews(country);
  }

  int rand = 10;
  String country = 'us';
  Future news;
  @override
  void initState() {
    super.initState();
    news = ArticleModel(
      countryToQuery: country,
    ).loadArticles();
  }

  void reloadNews(String _) {
    country = _;
    setState(() {
      news = ArticleModel(
        countryToQuery: country,
      ).loadArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flag(
                                  'ad',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 95,
                                  child: Text(
                                    _country['name'],
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          value: _country['symbol'],
                        ))).toList(),
              )),
              Positioned(
                right: 40,
                child: MediaQuery.of(context).size.width > 600
                    ? IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: QueryArticles(),
                          );
                        })
                    : Container(),
              ),
            ],
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
                                  builder: (context) => AllArticles(),
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
                        height: 210,
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
                      MediaQuery.of(context).size.width > 600
                          ? Container(
                              height: 210,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var currentArticle =
                                      snapshot.data[index + 13];
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
                                itemCount: 2,
                              ),
                            )
                          : MediaQuery.of(context).size.width > 1100
                              ? Container(
                                  height: 210,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      var currentArticle = snapshot.data[index];
                                      return ArticleOfTheDayCard(
                                        author: currentArticle.author,
                                        source: currentArticle.source,
                                        content: currentArticle.content,
                                        title: currentArticle.title,
                                        datePublished:
                                            currentArticle.datePublished,
                                        description: currentArticle.description,
                                        url: currentArticle.url,
                                        urlToImage: currentArticle.urlToImage,
                                      );
                                    },
                                    itemCount: 3,
                                  ),
                                )
                              : ArticleOfTheDayCard(
                                  author: snapshot.data[rand].author,
                                  source: snapshot.data[rand].source,
                                  content: snapshot.data[rand].content,
                                  title: snapshot.data[rand].title,
                                  datePublished:
                                      snapshot.data[rand].datePublished,
                                  description: snapshot.data[rand].description,
                                  url: snapshot.data[rand].url,
                                  urlToImage: snapshot.data[rand].urlToImage,
                                )
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
