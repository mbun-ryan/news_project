class ArticleModel {
  String author;
  String title;
  String datePublished;
  String description;
  String url;
  String urlToImage;
  String content;
  final String apiKey = 'd31c365c442a42359a38431e467dfb48';
  List<Map<String, dynamic>> response = [
    {
      'status': 'ok',
      'totalResults': 38,
      'articles': {
        {
          'source': {
            'id': 'the-washington-post',
            'name': 'The Washington Post'
          },
          'author': 'Casey Quackenbush',
          'title':
              'After pitched battle, Hong Kong police move on university campus, begin mass arrests - The Washington post',
          'description':
              'As both sides escalated their weaponry, police warned they could use live rounds',
          'url': '',
          'urlToImage': '',
          'publishedAt': '',
          'content': '',
        },
        {
          'source': {
            'id': 'the-washington-post',
            'name': 'The Washington Post'
          },
          'author': 'Casey Quackenbush',
          'title':
              'After pitched battle, Hong Kong police move on university campus, begin mass arrests - The Washington post',
          'description':
              'As both sides escalated their weaponry, police warned they could use live rounds',
          'url': '',
          'urlToImage': '',
          'publishedAt': '',
          'content': '',
        }
      },
    }
  ];
}
