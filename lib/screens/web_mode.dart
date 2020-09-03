import 'dart:async';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ArticleWebMode extends StatefulWidget {
  String url;
  ArticleWebMode({this.url});
  @override
  _ArticleWebModeState createState() => _ArticleWebModeState();
}

class _ArticleWebModeState extends State<ArticleWebMode> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  void perform(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleWebMode(
                    url: widget.url,
                  )));
    } else {
      Share.text('News Article', widget.url, 'text/plain');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Stack(
              children: [
                Positioned(
                  left: 60,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      icon: Icon(Icons.more_vert),
                      iconEnabledColor: Colors.white,
                      // value: 'Open In Web mode',
                      items: [
                        DropdownMenuItem(
                          child: Container(
                              margin: EdgeInsets.all(0),
                              height: 50,
                              width: 90,
                              child: Center(
                                  child: Text(
                                'Share',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w300),
                              ))),
                          value: 1,
                        ),
                      ],
                      onChanged: (value) => perform(value, context),
                    ),
                  ),
                ),
                NavigationControls(_completer.future),
              ],
            ),
          ],
          title: Text('Web Mode'),
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: ((
            WebViewController webViewController,
          ) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController completer = snapshot.data;
        return Container(
          margin: EdgeInsets.only(right: 33),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        if (await completer.canGoBack()) {
                          completer.goBack();
                        } else {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('No backward history')),
                          );
                          return;
                        }
                      },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: !webViewReady
                    ? null
                    : () async {
                        if (await completer.canGoForward()) {
                          completer.goForward();
                        } else {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(content: Text('No forward history')),
                          );
                          return;
                        }
                      },
              ),
              IconButton(
                icon: Icon(Icons.replay),
                onPressed: !webViewReady
                    ? null
                    : () {
                        completer.reload();
                      },
              ),
            ],
          ),
        );
      },
    );
  }
}
