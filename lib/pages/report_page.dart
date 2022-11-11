import 'package:finances/controller/report_controller.dart';
import 'package:finances/pages/cadastro_convenio.dart';
import 'package:finances/pages/dropdown_type_report.dart';
import 'package:finances/pages/input_date.dart';
import 'package:finances/pages/pdf_screen.dart';
import 'package:flutter/material.dart';

class ReportePage extends StatelessWidget {
  TextEditingController _typeReport = TextEditingController();

  ReportController controller = ReportController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Relatórios'),
      ),
      body: bodyReport(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          controller.generatePdfReport().then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PDFScreen(path: value)),
            );
          });
        },
        heroTag: null,
      ),
    ));
  }

  Widget bodyReport() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceBoxHeigth(10),
          Text('Tipo de relatório'),
          DropdownButtonTypeReport(controller: _typeReport),
          Text('Data De'),
          //InputDate(),
          Text('Data Ate')
          //InputDate(),
        ],
      )
    ]);
  }

  SizedBox spaceBoxWidth(double value) {
    return SizedBox(width: value);
  }

  SizedBox spaceBoxHeigth(double value) {
    return SizedBox(height: value);
  }
}
