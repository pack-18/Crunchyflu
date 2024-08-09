import 'package:flutter/material.dart';
import 'package:script_injection_webview/webview_helper.dart'; // Import the WebViewHelper

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Script Injection WebView',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Script Injection WebView'),
      ),
      body: WebViewHelper(), // Use the WebViewHelper widget
    );
  }
}
