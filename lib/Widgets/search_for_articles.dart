import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/screens/independent_articles_screen.dart';

import 'alternative_article_card.dart';

class QueryArticles extends SearchDelegate<ArticleModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return IndependentArticle();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final articles = query.isEmpty
        ? loadDummyArticles()
        : loadDummyArticles()
            .where((article) =>
                article.title
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                article.description
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                article.content
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                article.datePublished
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                article.source
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
    return articles.isEmpty
        ? Container(
            child: Center(
              child: Text(
                'OOps...No Results Found',
                style: Theme.of(context).textTheme.overline.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => showResults(context),
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final ArticleModel currentArticle = articles[index];
                return AlternativeArticleCard(
                    bottomPadding: 2,
                    source: currentArticle.source,
                    title: currentArticle.title,
                    datePublished: currentArticle.datePublished,
                    description: currentArticle.description,
                    url: currentArticle.url,
                    urlToImage: currentArticle.urlToImage,
                    content: currentArticle.content);
              },
            ),
          );
  }
}
