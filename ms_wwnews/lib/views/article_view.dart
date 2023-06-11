import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../navigation_controls.dart';
import '../menu.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;

  ArticleView({required this.blogUrl,super.key});
  WebViewController controlla = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(blogUrl));

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  //Adding page load events
  @override
  var loadingPercentage = 0;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
         title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("MS ", style: TextStyle(color: Colors.black)),
            Text("WWNews", style: TextStyle(color: Colors.blue))
          ],
        ),
        actions: [
          
          NavigationControls(controller: widget.controlla),
          Menu(controller: widget.controlla),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),

      body: WebViewWidget(
        controller: widget.controlla,
      ),
        
      
    );
  }
}
