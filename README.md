# News++


## Overview
A News Aggregator Mobile App Built With Flutter, as a Solo Project For The Chingu Explorer Cohort which took place on August 2020

The app pulls data from [News API](https://newsapi.org/) to receive latest news articles and show them to users.

## Features

- On launch, the **Dashboard** opens, where users can scroll through 15 articles while viewing for each article, an **image**, **title** and **description**, with one article highlighted as the **article of the day**.
- Tapping on the search bar opens the search screen where users can query for articles with keywords, sort them by **language**, **relevancy**, or **popularity**.
- Tapping on the **country** dropdown allows users to select a given country from where they want news from. Articles from a country comes in the country's language by default. The default country on launch is the *USA*.
- Tapping on **All Articles** will jump to the all *articles screen* where users will get articles from their selected country.
- All **article cards** can be *long-pressed*. Long-pressing an article either prompts to open the article in **Web Mode**(article's website) or **share the article** or shows a preview of the **article's details** depending on where you are and what you tap.
- In the **drawer** view,

  - Tapping on **All Articles** will jump to the all *articles screen*.
  - Users can tap on **Translate To English** to translate all news articles in other languages to *English*, except in the "search" mode (where the language can be sorted)

- In the **All Articles** screen, all articles from the selected country is shown. Articles are further grouped into categories like **Technology** and **Health**.

## Running The App

- **Clone** the repository into your computer.
- Launch it in your flutter IDE of choice and run **$ flutter pub get** (**get dependencies**) to install all the external dependencies required to run the app.
- Run '**main.dart**' on an **emulator** or a **physical device**.
  - **Enjoy**

## Dependencies

- External Dependencies Include:
  - [dart-lang/http](https://github.com/dart-lang/http)
  - [Baseflow/flutter_cached_network_image](https://github.com/Baseflow/flutter_cached_network_image)
  - [dart-lang/intl](https://github.com/dart-lang/intl)
  - [flutter/plugins/packages/webview_flutter](https://github.com/flutter/plugins/tree/master/packages/webview_flutter)
  - [LunaGao/flag_flutter](https://github.com/LunaGao/flag_flutter)
  - [gabrielpacheco23/google-translator](https://github.com/gabrielpacheco23/google-translator)
  - [esysberlin/esys-flutter-share](https://github.com/esysberlin/esys-flutter-share)

