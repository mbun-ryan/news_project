import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IndependentArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(1),
              child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * .38
                        : MediaQuery.of(context).size.height * .5,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.blueGrey),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: AssetImage('assets/images/songoku.jpg'
                              ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 5),
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              elevation: 100,
                              margin: EdgeInsets.all(0),
                              color: Colors.white70,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Author - Mbun Ryan',
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline
                                        .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.grey[900])),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, bottom: 1, left: 3, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            'Source - ',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Mbun Ryan\'s Blog',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                          )
                        ],
                      ),
                      subtitle: Text('Published: 2 Days Ago'),
                      // color: Colors.grey.withOpacity(.03),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      'A Stereotype About Cameroon for the YYAS 2020 application.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Center(
                      child: Divider(
                        height: 0,
                        thickness: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text(
                      'An outline of facts why Cameroon has long been considered as \n\"Africa-In-Miniature\"',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text(
                      'Cameroon has diverse cultural, religious, and political traditions as well as ethnic variety. English and French are her official languages, a heritage of her colonial past as both a colony of the United Kingdom and France from 1916 to 1960. This means two of the most popular languages in the world are used in Cameroon. The above factors and many more, together with her location usually described as “The Armpit of Africa”, sparked a popular stereotype mainly by tourist literature, her being considered “Africa in miniature”. Asserting that she offers all the diversity of Africa, in climate, culture, and geography, within its borders. Some might question this, but based on my experiences and research, I think it might be safe to agree so. Well, let us find out.\n\nIn the context of language, not only do her inhabitants speak both English and French, regarded as some of the most popular languages in the world but more intriguing that she is equally home to 230 languages, including Afro-Asiatic, Nilo-Saharan, Niger-Congo, Fulfulde(Adamawa-Ubangui and Benue-Congo) languages.\n\nSounds kind of African right? Also, in terms of religion and culture, she has an extremely heterogeneous population, consisting of approximately 200 ethnic groups and a variety of religious beliefs. Its population divided into Christian, Muslim and “traditional” religions. Christian missions contributed informally to colonialism. I think this too can be seen in parts of Africa.\n\nEqually, in terms of Agriculture, it is undoubtedly an extremely important sector of Cameroonian and African economy and boosting countries’ GDP in the past years. It will be our driving engine out of poverty. As if it were not enough, you have the unique opportunity to visit the whole of Africa just by planning a trip to Cameroon. With over millions of tourists in the past years, she has become a destination of choice within CEMAC. She has great cultural, ethnic and geographic diversity.\nAnd as I have experienced, beautiful tropical, palm-fringed beaches, high mountains and volcanoes, game parks, Sahel landscape and deserts, big lakes and impenetrable tropical forests full of wild animals like chimpanzee, gorilla, elephant, and buffalo amongst many others, which can be found in parts of Africa.\n\nEnough with the positive side. Despite everything, one cannot neglect social ills inclusive of, tribalism, public protests, drug addiction, poverty and corruption, sexual abuse, unemployment even female genital mutilation which at some point, have or are still taking place in Cameroon and parts of Africa.\n\nTo wrap up, a stereotype, according to Oxford Learner’s Dictionary, is a fixed idea or image that many people have of a particular type of person or thing, but which is often false in reality. They might limit our knowledge about something, and we can’t just accept them without proper learning and researching. Thus, I believe the above words speak for themselves, and indeed Cameroon can be considered “Africa in miniature”, a pocket-sized version of the continent. Literally.',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.grey,
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 10),
                    child: OutlineButton(
                        onPressed: () {}, child: Text('Open In Web Mode')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
