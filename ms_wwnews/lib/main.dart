import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ms_wwnews/views/home.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate, String host, int port) => true;
  }
}


void main() {
  HttpOverrides.global = new PostHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(primary: Colors.white),
      ),
      home: Home(),
    );
  }
}
