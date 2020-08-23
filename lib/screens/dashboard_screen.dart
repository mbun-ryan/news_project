import 'package:flutter/material.dart';
import 'package:news_project/Widgets/article_card.dart';
import 'package:news_project/Widgets/article_of_the_day_card.dart';
import 'package:news_project/screens/all_articles_screen.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
        title: Text('Dashboard'),
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          // padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(right: 10),
                child: TextField(
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
              Container(
                // color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Articles'),
                    FlatButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllArticles(),
                              ),
                            ),
                        child: Text('All Articles'))
                  ],
                ),
              ),
              Container(
                height: 210,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ArticleCard();
                  },
                  itemCount: 5,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // color: Colors.grey,
                //   padding: EdgeInsets.only(top: 30, bottom: 5, left: 10),
                child: Text(MediaQuery.of(context).size.width > 600
                    ? 'Articles Of The Day'
                    : 'Article Of The Day'),
              ),
              MediaQuery.of(context).size.width > 600
                  ? Container(
                      height: 210,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ArticleOfTheDayCard();
                        },
                        itemCount: 2,
                      ),
                    )
                  : ArticleOfTheDayCard()
            ],
          ),
        ),
      ),
    );
  }
}
