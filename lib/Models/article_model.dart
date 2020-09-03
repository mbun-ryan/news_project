import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

class ArticleModel {
  String source;
  String author;
  String title;
  String datePublished;
  String description;
  String url;
  String urlToImage;
  String content;
  String countryToQuery;
  String keywordToQuery;
  String sourceToQuery;
  String category;
  String language;
  String sortBy;
  bool lockLanguageToEnglish;
  ArticleModel({
    this.author,
    this.title,
    this.datePublished,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
    this.source,
    this.countryToQuery,
    this.keywordToQuery,
    this.sourceToQuery,
    this.category,
    this.language,
    this.sortBy,
    this.lockLanguageToEnglish,
  });

  final _translator = GoogleTranslator();
  String translate(String text) {
    String _temp;
    _translator.translate(text, to: 'en').then((value) => _temp = value.text);
    return _temp;
  }

  final String apiKey = 'd31c365c442a42359a38431e467dfb48';
  List<ArticleModel> realArticles = [];
  Future<List<ArticleModel>> loadArticles() async {
    String url =
        //'https://newsapi.org/v2/everything?q=$keywordToQuery&apiKey=$apiKey';
        'https://newsapi.org/v2/top-headlines?country=$countryToQuery&pageSize=20&apiKey=$apiKey';
    // 'https://newsapi.org/v2/top-headlines?sources=$sourceToQuery&apiKey=$apiKey';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      if (lockLanguageToEnglish) {
        for (var article in jsonData['articles']) {
          String tTitle;
          try {
            final _tTitle = await _translator.translate(
                article['title'] != null && article['title'] != ''
                    ? article['title']
                    : 'Title Unavailable',
                to: 'en');
            print(_tTitle);
            tTitle = _tTitle.text.toString();
          } catch (_) {
            tTitle = 'Could Not Translate :' + article['title'];
          }

          String tDescription;
          try {
            final _tDescription = await _translator.translate(
                article['description'] != null && article['description'] != ''
                    ? article['description']
                    : 'Description Unavailable',
                to: 'en');
            print(_tDescription);
            tDescription = _tDescription.text.toString();
          } catch (_) {
            tDescription = 'Could Not Translate : ' + article['description'];
          }
          String tContent;
          try {
            final _tContent = await _translator.translate(
                article['content'] != null && article['content'] != ''
                    ? article['content']
                    : 'Content Unavailable',
                to: 'en');
            print(_tContent);
            tContent = _tContent.text.toString();
          } catch (_) {
            tContent = 'Could Not Translate :' + article['content'];
          }

          ArticleModel newArticle = ArticleModel(
            author: article['author'] != null && article['author'] != ''
                ? article['author']
                : 'Unavailable',
            source: article['source']['name'],
            title: tTitle,
            description: tDescription,
            url: article['url'] != null ? article['url'] : 'www.google.com',
            urlToImage: article['urlToImage'] != null
                ? article['urlToImage']
                : 'https://images.unsplash.com/photo-1572949645841-094f3a9c4c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
            datePublished: article['publishedAt'] != null
                ? article['publishedAt']
                : 'Date Unavailable',
            content: tContent,
          );
          realArticles.add(newArticle);
        }
      } else {
        for (var article in jsonData['articles']) {
          ArticleModel newArticle = ArticleModel(
            author: article['author'] != null && article['author'] != ''
                ? article['author']
                : 'Unavailable',
            source: article['source']['name'],
            title: article['title'] != null
                ? article['title']
                : 'Title Unavailable.',
            description:
                article['description'] != null && article['description'] != ''
                    ? article['description']
                    : 'Sorry, No Description Available.',
            url: article['url'] != null ? article['url'] : 'www.google.com',
            urlToImage: article['urlToImage'] != null
                ? article['urlToImage']
                : 'https://images.unsplash.com/photo-1572949645841-094f3a9c4c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
            datePublished: article['publishedAt'] != null
                ? article['publishedAt']
                : 'Date Unavailable',
            content: article['content'] != null
                ? article['content']
                : 'Content Unavailable',
          );
          realArticles.add(newArticle);
        }
      }
    }
    return realArticles;
  }

  Future<List<ArticleModel>> loadCategoryArticles() async {
    String _url =
        //'https://newsapi.org/v2/everything?q=$keywordToQuery&apiKey=$apiKey';
        //    'https://newsapi.org/v2/top-headlines?country=$countryToQuery&apiKey=$apiKey';
        // 'https://newsapi.org/v2/top-headlines?sources=$sourceToQuery&apiKey=$apiKey';
        'https://newsapi.org/v2/top-headlines?country=$countryToQuery&pageSize=30&category=$category&apiKey=$apiKey';
    var response = await http.get(_url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      if (lockLanguageToEnglish) {
        for (var article in jsonData['articles']) {
          String tTitle;
          try {
            final _tTitle = await _translator.translate(
                article['title'] != null && article['title'] != ''
                    ? article['title']
                    : 'Title Unavailable',
                to: 'en');
            print(_tTitle);
            tTitle = _tTitle.text.toString();
          } catch (_) {
            tTitle = 'Could Not Translate ' + article['title'];
          }

          String tDescription;
          try {
            final _tDescription = await _translator.translate(
                article['description'] != null && article['description'] != ''
                    ? article['description']
                    : 'Description Unavailable',
                to: 'en');
            print(_tDescription);
            tDescription = _tDescription.text.toString();
          } catch (_) {
            tDescription = 'Could Not Translate ' + article['description'];
          }
          String tContent;
          try {
            final _tContent = await _translator.translate(
                article['content'] != null && article['content'] != ''
                    ? article['content']
                    : 'Content Unavailable',
                to: 'en');
            print(_tContent);
            tContent = _tContent.text.toString();
          } catch (_) {
            tContent = 'Could Not Translate ' + article['content'];
          }

          ArticleModel newArticle = ArticleModel(
            author: article['author'] != null && article['author'] != ''
                ? article['author']
                : 'Unavailable',
            source: article['source']['name'],
            title: tTitle,
            description: tDescription,
            url: article['url'] != null ? article['url'] : 'www.google.com',
            urlToImage: article['urlToImage'] != null
                ? article['urlToImage']
                : 'https://images.unsplash.com/photo-1572949645841-094f3a9c4c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
            datePublished: article['publishedAt'] != null
                ? article['publishedAt']
                : 'Date Unavailable',
            content: tContent,
          );
          realArticles.add(newArticle);
        }
      } else {
        for (var article in jsonData['articles']) {
          ArticleModel newArticle = ArticleModel(
            author: article['author'] != null && article['author'] != ''
                ? article['author']
                : 'Unavailable',
            source: article['source']['name'],
            title: article['title'] != null
                ? article['title']
                : 'Title Unavailable.',
            description:
                article['description'] != null && article['description'] != ''
                    ? article['description']
                    : 'Sorry, No Description Available.',
            url: article['url'] != null ? article['url'] : 'www.google.com',
            urlToImage: article['urlToImage'] != null
                ? article['urlToImage']
                : 'https://images.unsplash.com/photo-1572949645841-094f3a9c4c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
            datePublished: article['publishedAt'] != null
                ? article['publishedAt']
                : 'Date Unavailable',
            content: article['content'] != null
                ? article['content']
                : 'Content Unavailable',
          );
          realArticles.add(newArticle);
        }
      }
    }
    return realArticles;
  }

  Future<List<ArticleModel>> loadQueriedArticles() async {
    String _url =
        'https://newsapi.org/v2/everything?q=$keywordToQuery&pageSize=90&sortBy=$sortBy&language=$language&apiKey=$apiKey';
    //    'https://newsapi.org/v2/top-headlines?country=$countryToQuery&apiKey=$apiKey';
    // 'https://newsapi.org/v2/top-headlines?sources=$sourceToQuery&apiKey=$apiKey';
    // 'https://newsapi.org/v2/top-headlines?country=$countryToQuery&category=$category&apiKey=$apiKey';
    var response = await http.get(_url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      print(jsonData);
      for (var article in jsonData['articles']) {
        ArticleModel newArticle = ArticleModel(
          author: article['author'] != null && article['author'] != ''
              ? article['author']
              : 'Unavailable',
          source: article['source']['name'],
          title: article['title'] != null
              ? article['title']
              : 'Title Unavailable.',
          description:
              article['description'] != null && article['description'] != ''
                  ? article['description']
                  : 'Sorry, Description Unavailable.',
          url: article['url'] != null ? article['url'] : 'www.google.com',
          urlToImage: article['urlToImage'] != null
              ? article['urlToImage']
              : 'https://images.unsplash.com/photo-1572949645841-094f3a9c4c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
          datePublished: article['publishedAt'] != null
              ? article['publishedAt']
              : 'Date Unavailable',
          content: article['content'] != null
              ? article['content']
              : 'Content Unavailable',
        );
        realArticles.add(newArticle);
      }
    }
    return realArticles;
  }
}
