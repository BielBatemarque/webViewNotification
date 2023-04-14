// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: 'https://gabrielbatemarque.vercel.app',
          userAgent: 'random',
          gestureNavigationEnabled: true,
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
          },
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
            });
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains('whatsapp://')) {
              launch(request.url); //This is where Whatsapp launches
              return NavigationDecision.prevent;
            }
            if (request.url.contains('mailto:')) {
              launch(request.url);
              return NavigationDecision.prevent;
            }
            if (request.url.contains('tel:')) {
              launch(request.url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
            minHeight: 20,
            color: Colors.yellow,
          ),
      ],
    );
  }
}
