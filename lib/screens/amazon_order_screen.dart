import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AmazonOrderScreen extends StatefulWidget {
  static const tag = '/amazon-order';
  const AmazonOrderScreen({Key? key}) : super(key: key);

  @override
  State<AmazonOrderScreen> createState() => _AmazonOrderScreenState();
}

class _AmazonOrderScreenState extends State<AmazonOrderScreen> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Amazon'),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
        ),
      ),
    );
  }
}
