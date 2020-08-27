import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebMode extends StatefulWidget {
  String url;
  ArticleWebMode({this.url});
  @override
  _ArticleWebModeState createState() => _ArticleWebModeState();
}

class _ArticleWebModeState extends State<ArticleWebMode> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            NavigationControls(_completer.future),
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
        return Row(
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
        );
      },
    );
  }
}
