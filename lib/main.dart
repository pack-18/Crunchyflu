import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

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
  late WebViewController _controller;
  final _scriptUrls = {
    // Map URL to corresponding script URL
    'www.example.com': 'https://npm.jsdelivr.com/samcrofficial/script1',
    'www.example.com/': 'https://npm.jsdelivr.com/samcrofficial/script1',
    'www.example.com/categories': 'https://npm.jsdelivr.com/samcrofficial/script1',
    'www.sos.example.com': 'https://www.npm.jsdelivr.com/samcrofficial/script2',
    'www.sos.example.com/log': 'https://www.npm.jsdelivr.com/samcrofficial/script2',
  };

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading indicator or progress bar (optional)
          },
          onPageStarted: (String url) {
            // Handle page start (optional)
          },
          onPageFinished: (String url) {
            // Handle page finish (optional)
          },
          onWebResourceError: (WebResourceError error) {
            // Handle errors (optional)
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Script Injection WebView'),
      ),
      body: WebViewWidget(_controller),
    );
  }
}

class WebViewWidget extends StatefulWidget {
  final WebViewController controller;

  const WebViewWidget(this.controller, {Key? key}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'www.example.com',  // Initial URL
      javascriptMode: JavaScriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        widget.controller = webViewController;
      },
      navigationDelegate: (NavigationRequest request) {
        final url = request.url;
        if (_scriptUrls.containsKey(url)) {
          // Inject script for the requested URL
          final scriptUrl = _scriptUrls[url]!;
          return _injectScript(scriptUrl);
        }
        return NavigationDecision.navigate;
      },
    );
  }

  NavigationDecision _injectScript(String scriptUrl) {
    final script = "<script src=\"" + scriptUrl + "\"></script>";
    widget.controller.evaluateJavascript(script);
    return NavigationDecision.navigate;
  }
}
