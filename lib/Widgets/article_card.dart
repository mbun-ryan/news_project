import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_project/screens/independent_articles_screen.dart';

class ArticleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IndependentArticle(),
        ),
      ),
      child: Card(
        elevation: 2.5,
        // margin: EdgeInsets.only(left: 2, right: 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * .3
                : MediaQuery.of(context).size.width * .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        //alignment: Alignment.topCenter,
                        image: AssetImage('assets/images/songoku.jpg'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  // flex: 1,
                  // height: (200 * .3).toDouble(), width: double.infinity,
                  child: Container(
                    color: Colors.grey,
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A Stereotype About Cameroon for the YYAS 2020 application.',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'An outline of facts why Cameroon has long been considered as \"Africa-In-Miniature\"',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
