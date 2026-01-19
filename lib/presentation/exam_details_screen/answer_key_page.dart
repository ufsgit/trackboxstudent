import 'dart:io';

import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

class AnswerKeyPage extends StatefulWidget {
  final String answerKey;
  const AnswerKeyPage({super.key, required this.answerKey});

  @override
  State<AnswerKeyPage> createState() => _AnswerKeyPageState();
}

class _AnswerKeyPageState extends State<AnswerKeyPage> {
  late Future<String?> cachedPdfPath;
  @override
  void initState() {
    cachedPdfPath = cachePdf(widget.answerKey);
    super.initState();
  }

  Future<String?> cachePdf(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = Uri.parse(url).pathSegments.last; // Unique filename
    final filePath = '${directory.path}/$fileName';

    if (File(filePath).existsSync()) {
      return filePath; // PDF is cached
    }

    try {
      final response = await http.get(Uri.parse(url));
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath; // Return path of the cached PDF
    } catch (e) {
      print('Error caching PDF: $e');
      return null; // Return null if there was an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: cachedPdfPath,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: ColorResources.colorBlue500,
              ));
            } else if (snapshot.data == null) {
              return Center(child: Text('No answer key to show'));
            }
            return SfPdfViewer.file(
              File(snapshot.data!),
              canShowScrollHead: false,
              pageLayoutMode: PdfPageLayoutMode.single,
              enableDoubleTapZooming: true,
            );
          },
        ));
  }
}
