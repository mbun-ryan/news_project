import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Widgets/article_card.dart';
import 'package:news_project/Widgets/article_of_the_day_card.dart';
import 'package:news_project/Widgets/search_for_articles.dart';
import 'package:news_project/screens/all_articles_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future news;
  @override
  void initState() {
    super.initState();
    news = ArticleModel(country: 'us', keyword: 'Cameroon').loadRealArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
        title: Text('Dashboard'),
      ),
      drawer: Drawer(),
      body: FutureBuilder(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return RefreshIndicator(
              onRefresh: () {},
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  // padding: EdgeInsets.all(10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
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
                            Text(
                              'Articles',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            GestureDetector(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllArticles(),
                                      ),
                                    ),
                                child: Text(
                                  'All Articles',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.blue[800]),
                                )),
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
                            return ArticleCard(
                              urlToImage: snapshot.data[index].urlToImage,
                              title: snapshot.data[index].title,
                              description: snapshot.data[index].description,
                            );
                          },
                          itemCount: 5,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.grey,
                            padding:
                                EdgeInsets.only(top: 0, bottom: 5, left: 0),
                            child: Text(
                              MediaQuery.of(context).size.width > 600
                                  ? 'Articles Of The Day'
                                  : 'Article Of The Day',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
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
                                  return ArticleOfTheDayCard(
                                    title: snapshot.data[index].title,
                                    urlToImage: snapshot.data[index].urlToImage,
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
                                      return ArticleOfTheDayCard(
                                        title: snapshot.data[index].title,
                                        urlToImage:
                                            snapshot.data[index].urlToImage,
                                      );
                                    },
                                    itemCount: 3,
                                  ),
                                )
                              : ArticleOfTheDayCard(
                                  title: snapshot.data[6].title,
                                  urlToImage: snapshot.data[6].urlToImage,
                                )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
