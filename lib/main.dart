import 'package:flutter/material.dart';
import 'dart:async';   
import 'package:webview_flutter/webview_flutter.dart';
import 'src/navigation_controls.dart';
import 'package:dio/dio.dart';
import 'src/web_view_stack.dart';  // Add this import

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  final controller = Completer<WebViewController>();
  var lista = [];
  final dio = Dio();

  getApi() async{
    try{
      var retRes = await dio.get('');
      return retRes;
    }catch(e){
      print(e);
    }
  }

  alteraLista(){
    setState(() {
      lista = getApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barato Bebê'),
                actions: [
          NavigationControls(controller: controller),
        ],
      ),
      body: WebViewStack(controller: controller),   // Replace the WebView widget with WebViewStack
    );
  }
}