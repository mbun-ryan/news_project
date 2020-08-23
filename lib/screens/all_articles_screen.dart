import 'package:flutter/material.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';

class AllArticles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('All Articles'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return index == 9
              ? AlternativeArticleCard(
                  bottomPadding: 20,
                )
              : AlternativeArticleCard(
                  bottomPadding: 0,
                );
        },
      ),
    );
  }
}
