import 'package:flutter/material.dart';
import 'package:news_project/Models/article_model.dart';
import 'package:news_project/Models/category_model.dart';
import 'package:news_project/Widgets/alternative_article_card.dart';
import 'package:news_project/Widgets/category_card.dart';
import 'package:news_project/screens/independent_articles_screen.dart';

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                //padding: EdgeInsets.symmetric(horizontal: 5),
                //color: Colors.grey.withOpacity(.6),
                height: 90,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: loadCategories().length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final CategoryModel currentCategory =
                        loadCategories()[index];
                    return CategoryCard(
                      categoryName: currentCategory.categoryName,
                      imageUrl: currentCategory.imageUrl,
                    );
                  },
                ),
              ),
              Container(
                height: 450,
                child: ListView.builder(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: loadDummyArticles().length,
                  itemBuilder: (context, index) {
                    // ArticleModel articleModel = ArticleModel();
                    final articles = loadDummyArticles();
                    return GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return IndependentArticle();
                      })),
                      child: AlternativeArticleCard(
                          bottomPadding: index ==
                                  loadDummyArticles().length -
                                      loadDummyArticles().length
                              ? 20
                              : 0,
                          source: articles[index].source,
                          title: articles[index].title,
                          datePublished: articles[index].datePublished,
                          description: articles[index].description,
                          url: articles[index].url,
                          urlToImage: articles[index].urlToImage,
                          content: articles[index].content),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
