import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  CategoryCard({@required this.categoryName, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: 100,
        margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(.4), BlendMode.colorBurn)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    // color: Colors.indigoAccent.withOpacity(.5),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        categoryName,
                        style: TextStyle(
                            color: Colors.white,
//                            fontSize: constraints.maxHeight / 4.5,
                            fontFamily: 'OpenSans',
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ],
          ),
        ),
      );
    });
  }
}
