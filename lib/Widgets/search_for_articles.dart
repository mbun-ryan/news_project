import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/screens/queried_articles_screen.dart';

class QueryArticles extends SearchDelegate<ArticleModel> {
  List<String> searchedArticles = [
    'COVID-19',
    'Cameroon',
    'Bitcoin',
    'Huawei',
    'HP',
    'SAMSUNG',
    'Apple',
    '5G',
    'Donald Trump'
  ];
  void addQ(String Q) {
    if (Q.isNotEmpty && Q != ' ' && !searchedArticles.contains(Q)) {
      searchedArticles.insert(0, Q);
    }
  }

  void showRes(BuildContext ctx, String que) {
    query = que;
    showResults(ctx);
    addQ(que);
  }

  void addAndNavigate(BuildContext ctx, String currentSuggest) {
    addQ(currentSuggest);
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => QueriedScreen(keyword: currentSuggest),
      ),
    );
  }

  void removeSearchedArticle(String index) {
    searchedArticles.removeWhere((element) => element == index);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.search), onPressed: () => showRes(context, query)),
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
    addQ(query);
    return QueriedScreen(keyword: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? searchedArticles
        : searchedArticles
            .where((article) =>
                article.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return suggestions.isEmpty
        ? Container(
            child: Center(
              child: Text(
                'Search',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.overline.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          )
        : ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final currentSuggestion = suggestions[index];
              return ListTile(
                onTap: () => showRes(context, currentSuggestion),
                leading: IconButton(
                    icon: Icon(Icons.youtube_searched_for),
                    onPressed: () =>
                        addAndNavigate(context, currentSuggestion)),
                title: Text(currentSuggestion),
                trailing: IconButton(
                    icon: Icon(Icons.subdirectory_arrow_left),
                    onPressed: () {
                      query = currentSuggestion;
                    }),
              );
            },
          );
  }
}
