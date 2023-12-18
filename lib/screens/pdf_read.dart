import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDF_Reader extends StatefulWidget {
  const PDF_Reader({super.key});
  static String id = 'welcome_screen';

  @override
  State<PDF_Reader> createState() => _PDF_ReaderState();
}

class _PDF_ReaderState extends State<PDF_Reader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfPdfViewer.network(
            "https://www.planetebook.com/free-ebooks/1984.pdf",
            scrollDirection: PdfScrollDirection.horizontal,
            pageLayoutMode: PdfPageLayoutMode.single,
          ),
        ),
      ),
    );
  }
}
