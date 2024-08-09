import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHelper extends StatefulWidget {
  @override
  _WebViewHelperState createState() => _WebViewHelperState();
}

class _WebViewHelperState extends State<WebViewHelper> {
  late WebViewController _controller;
  final _scriptUrls = {
    'www.crunchyroll.com': 'https://npm.jsdelivr.com/samcrofficial/script1',
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
    return WebView(
      initialUrl: 'www.crunchyroll.com',  // Initial URL
      javascriptMode: JavaScriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
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
    _controller.evaluateJavascript(script);
    return NavigationDecision.navigate;
  }
}
