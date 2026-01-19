import 'dart:io';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CertificateDownloadPage extends StatefulWidget {
  final String? name_;
  final String? course_;

  const CertificateDownloadPage(this.name_, this.course_, {Key? key})
      : super(key: key);

  @override
  _CertificateDownloadPageState createState() =>
      _CertificateDownloadPageState();
}

class _CertificateDownloadPageState extends State<CertificateDownloadPage> {
  late Future<Uint8List> pdfFuture;
  bool _isDownloading = false;
  String? _downloadedFilePath;

  @override
  void initState() {
    super.initState();
    pdfFuture = makePdf();
  }

  Future<void> _directDownload() async {
    try {
      setState(() {
        _isDownloading = true;
      });

      final pdfBytes = await pdfFuture;
      final directory = await getExternalStorageDirectory();
      final filename = '${widget.name_}_Certificate.pdf';
      final filePath = '${directory?.path}/$filename';
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      setState(() {
        _isDownloading = false;
        _downloadedFilePath = filePath;
      });

      // Show dialog to open certificate
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Download Complete'),
            content: Text('Certificate downloaded successfully!'),
            actions: <Widget>[
              TextButton(
                child: Text('Close',
                    style: TextStyle(
                      color: ColorResources.colorBlack,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Open',
                    style: TextStyle(
                      color: ColorResources.colorBlack,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                  _openDownloadedFile();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }

  void _openDownloadedFile() {
    if (_downloadedFilePath != null) {
      OpenFile.open(_downloadedFilePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Certificate',
          style: TextStyle(
            fontSize: 18.v,
            fontWeight: FontWeight.w700,
            color: Color(0xff283B52),
          ),
        ),
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: ColorResources.colorBlue100,
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.back,
                color: ColorResources.colorBlack.withOpacity(.8),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Uint8List>(
              future: pdfFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error loading PDF'));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No PDF data'));
                }
                return PdfPreview(
                  build: (format) => snapshot.data!,
                  scrollViewDecoration: BoxDecoration(color: Colors.white),
                  allowPrinting: false,
                  allowSharing: false,
                  useActions: false,
                  canChangePageFormat: false,
                  canDebug: false,
                  canChangeOrientation: false,
                  dynamicLayout: false,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Print button
                // IconButton(
                //     onPressed: () async {
                //       final pdfBytes = await pdfFuture;
                //       await Printing.layoutPdf(
                //         onLayout: (format) => pdfBytes,
                //       );
                //     },
                //     icon: Icon(Icons.print)),
                SizedBox(width: 20),
                // Direct Download button with progress indicator
                _isDownloading
                    ? CircularProgressIndicator()
                    : IconButton(
                        onPressed: _directDownload,
                        icon: Icon(
                          Icons.file_download_outlined,
                          size: 35,
                        )),
                SizedBox(width: 20),
                // Share button
                IconButton(
                    onPressed: () async {
                      final pdfBytes = await pdfFuture;
                      await Printing.sharePdf(
                        bytes: pdfBytes,
                        filename: '${widget.name_}_Certificate.pdf',
                      );
                    },
                    icon: Icon(
                      Icons.share,
                      size: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final ByteData bytes = await rootBundle
        .load('assets/images/Breffni Certificate Plane_page-0001.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final libreBaskerville = await PdfGoogleFonts.libreBaskervilleRegular();
    final libreBaskervilleItalic =
        await PdfGoogleFonts.libreBaskervilleItalic();
    final libreBaskervilleBold = await PdfGoogleFonts.libreBaskervilleBold();

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4.landscape,
          orientation: pw.PageOrientation.landscape,
          margin: pw.EdgeInsets.zero, // Remove margins
          theme: pw.ThemeData.withFont(
            base: libreBaskerville,
            italic: libreBaskervilleItalic,
            bold: libreBaskervilleBold,
          ),
        ),
        build: (context) {
          final pageWidth = PdfPageFormat.a4.landscape.width;
          final pageHeight = PdfPageFormat.a4.landscape.height;

          return pw.Stack(
            children: [
              // Background image
              pw.Positioned.fill(
                child: pw.Image(
                  pw.MemoryImage(byteList),
                  fit: pw.BoxFit.fill,
                ),
              ),
              // Name
              pw.Positioned(
                left: pageWidth * 0.57,
                top: pageHeight * 0.49,
                child: pw.Text(
                  widget.name_.toString(),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 30,
                    color: PdfColors.black,
                  ),
                ),
              ),
              // Course
              pw.Positioned(
                left: pageWidth * 0.710,
                top: pageHeight * 0.629,
                child: pw.Text(
                  widget.course_.toString() + " Course",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontStyle: pw.FontStyle.italic,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
