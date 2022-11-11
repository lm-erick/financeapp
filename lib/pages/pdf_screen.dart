import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatefulWidget {
  final String path;

  const PDFScreen({Key? key, required this.path}) : super(key: key);

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Relatório"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
          ],
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
          ),
        ],
      ),
    );
  }
}
