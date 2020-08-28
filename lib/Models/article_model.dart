import 'dart:convert';

import 'package:http/http.dart' as http;

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
  });

  final String apiKey = 'd31c365c442a42359a38431e467dfb48';
  List<ArticleModel> realArticles = [];
  Future<List<ArticleModel>> loadArticles() async {
    String url =
        //'https://newsapi.org/v2/everything?q=$keywordToQuery&apiKey=$apiKey';
        'https://newsapi.org/v2/top-headlines?country=$countryToQuery&pageSize=100&apiKey=$apiKey';
    // 'https://newsapi.org/v2/top-headlines?sources=$sourceToQuery&apiKey=$apiKey';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
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
    } else if (jsonData['status'] == 'error') {
      print(jsonData);
      print(
          'Booooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
    }
    return realArticles;
  }

  Future<List<ArticleModel>> loadCategoryArticles() async {
    String _url =
        //'https://newsapi.org/v2/everything?q=$keywordToQuery&apiKey=$apiKey';
        //    'https://newsapi.org/v2/top-headlines?country=$countryToQuery&apiKey=$apiKey';
        // 'https://newsapi.org/v2/top-headlines?sources=$sourceToQuery&apiKey=$apiKey';
        'https://newsapi.org/v2/top-headlines?country=$countryToQuery&pageSize=100&category=$category&apiKey=$apiKey';
    var response = await http.get(_url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
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
    return realArticles;
  }

  Future<List<ArticleModel>> loadQueriedArticles() async {
    String _url =
        'https://newsapi.org/v2/everything?q=$keywordToQuery&pageSize=100&sortBy=$sortBy&language=$language&apiKey=$apiKey';
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

List<ArticleModel> loadDummyArticles() {
  List<ArticleModel> dummyArticles = [
    ArticleModel(
      source: 'The Washington Post',
      author: 'Mbonyo Man',
      title:
          'After pitched battle, Hong Kong police move on university campus, begin mass arrests - The Washington post',
      datePublished: "2020-08-25T05:30:00Z",
      description:
          'As both sides escalated their weaponry, police warned they could use live rounds',
      url: '',
      urlToImage: 'assets/images/songoku.jpg',
      content: '',
    ),
    ArticleModel(
      source: 'The Mbun Post',
      author: 'Mbun Ryan',
      title: 'A Stereotype About Cameroon for the YYAS 2020 application.',
      datePublished: "2020-08-25T05:30:00Z",
      description:
          'An outline of facts why Cameroon has long been considered as \"Africa-In-Miniature\"',
      url: '',
      urlToImage: 'assets/images/songoku3.jpg',
      content:
          'Cameroon has diverse cultural, religious, and political traditions as well as ethnic variety. English and French are her official languages, a heritage of her colonial past as both a colony of the United Kingdom and France from 1916 to 1960. This means two of the most popular languages in the world are used in Cameroon. The above factors and many more, together with her location usually described as “The Armpit of Africa”, sparked a popular stereotype mainly by tourist literature, her being considered “Africa in miniature”. Asserting that she offers all the diversity of Africa, in climate, culture, and geography, within its borders. Some might question this, but based on my experiences and research, I think it might be safe to agree so. Well, let us find out.\n\nIn the context of language, not only do her inhabitants speak both English and French, regarded as some of the most popular languages in the world but more intriguing that she is equally home to 230 languages, including Afro-Asiatic, Nilo-Saharan, Niger-Congo, Fulfulde(Adamawa-Ubangui and Benue-Congo) languages.\n\nSounds kind of African right? Also, in terms of religion and culture, she has an extremely heterogeneous population, consisting of approximately 200 ethnic groups and a variety of religious beliefs. Its population divided into Christian, Muslim and “traditional” religions. Christian missions contributed informally to colonialism. I think this too can be seen in parts of Africa.\n\nEqually, in terms of Agriculture, it is undoubtedly an extremely important sector of Cameroonian and African economy and boosting countries’ GDP in the past years. It will be our driving engine out of poverty. As if it were not enough, you have the unique opportunity to visit the whole of Africa just by planning a trip to Cameroon. With over millions of tourists in the past years, she has become a destination of choice within CEMAC. She has great cultural, ethnic and geographic diversity.\nAnd as I have experienced, beautiful tropical, palm-fringed beaches, high mountains and volcanoes, game parks, Sahel landscape and deserts, big lakes and impenetrable tropical forests full of wild animals like chimpanzee, gorilla, elephant, and buffalo amongst many others, which can be found in parts of Africa.\n\nEnough with the positive side. Despite everything, one cannot neglect social ills inclusive of, tribalism, public protests, drug addiction, poverty and corruption, sexual abuse, unemployment even female genital mutilation which at some point, have or are still taking place in Cameroon and parts of Africa.\n\nTo wrap up, a stereotype, according to Oxford Learner’s Dictionary, is a fixed idea or image that many people have of a particular type of person or thing, but which is often false in reality. They might limit our knowledge about something, and we can’t just accept them without proper learning and researching. Thus, I believe the above words speak for themselves, and indeed Cameroon can be considered “Africa in miniature”, a pocket-sized version of the continent. Literally.',
    ),
    ArticleModel(
      source: 'The Mbun Post',
      author: 'Mbun Ingrid',
      title:
          'Kendu, out of his foolishness manages to swallow 5 bowls of pap in one morning. Let\'s see what happens next',
      datePublished: "2020-08-25T05:30:00Z",
      description:
          'As Kendu and Bryce foolishly compete to find who has the largest Stomarch, Ryan sits back and watche in awe. Kendu won the challenge by swallowing 5 bowls of pap, while Bryce could only handle 3',
      url: '',
      urlToImage: 'assets/images/glasscloth.png',
      content: '',
    ),
    ArticleModel(
      source: 'The Mbun Post',
      author: 'Oga Bryce',
      title:
          'Kendu, out of his foolishness manages to swallow 5 bowls of pap in one morning. Let\'s see what happens next',
      datePublished: "2020-08-25T05:30:00Z",
      description:
          'As Kendu and Bryce foolishly compete to find who has the largest Stomarch, Ryan sits back and watche in awe. Kendu won the challenge by swallowing 5 bowls of pap, while Bryce could only handle 3',
      url: '',
      urlToImage: 'assets/images/glasscloth.png',
      content: '',
    ),
    ArticleModel(
      source: 'The Mbun Post',
      author: 'Mbun Ingrid',
      title:
          'Kendu, out of his foolishness manages to swallow 5 bowls of pap in one morning. Let\'s see what happens next',
      datePublished: "2020-08-25T05:30:00Z",
      description:
          'As Kendu and Bryce foolishly compete to find who has the largest Stomarch, Ryan sits back and watche in awe. Kendu won the challenge by swallowing 5 bowls of pap, while Bryce could only handle 3',
      url: '',
      urlToImage: 'assets/images/glasscloth.png',
      content: '',
    ),
    ArticleModel(
      source: 'The Mbun Post',
      author: 'Oga Bryce',
      title:
          'Kendu, out of his foolishness manages to swallow 5 bowls of pap in one morning. Let\'s see what happens next',
      datePublished: "2020-08-25T05:30:00Z",
      description:
          'As Kendu and Bryce foolishly compete to find who has the largest Stomarch, Ryan sits back and watche in awe. Kendu won the challenge by swallowing 5 bowls of pap, while Bryce could only handle 3',
      url: '',
      urlToImage: 'assets/images/ryan1.jpg',
      content: '',
    ),
  ];
  return dummyArticles.reversed.toList();
}
