import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArticleOfTheDayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .6,
        child: ArticleOfTheDay());
  }
}

class ArticleOfTheDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //  alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 20, right: 20, top: 5),
          height: 100,
          color: Colors.grey.withOpacity(.5),
        ),
        Container(
          //  alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 15, right: 15, top: 12),
          height: 100,
          color: Colors.grey.withOpacity(.8),
        ),
        Card(
          elevation: 3,
          margin: EdgeInsets.only(top: 20, bottom: 0, left: 10, right: 10),
          child: Container(
            height: 200,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/ryantechlogo.png',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            // width: 400,
                            child: Text(
                              'After pitched battle, Hong Kong police move on university campus, begin mass arrests - The Washington post',
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.all(5),
                          width: 150,
                          alignment: Alignment.centerRight,
                          //width: 200,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(CupertinoIcons.heart_solid),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.bookmark),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.forward),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    //height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
