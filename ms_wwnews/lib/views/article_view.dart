import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../navigation_controls.dart';
import '../menu.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;

  ArticleView({required this.blogUrl, super.key});
  

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  //Adding page load events
  @override
  var loadingPercentage = 0;
  late WebViewController controlla;

  @override
  void initState() {
    super.initState();
    controlla = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          },
        );
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        Uri.parse(widget.blogUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("MS ", style: TextStyle(color: Colors.black)),
            Text("WWNews", style: TextStyle(color: Colors.blue))
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save, color: Colors.black38)),
          ),   //This opacity is to center the title since there's back button
          
        ],
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.grey[100],
      ),

      body: WebViewWidget(
        controller: controlla,
      ),
    );
  }
}
