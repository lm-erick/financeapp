import 'dart:io';
import 'package:finances/controller/utils_controller.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportController extends UtilsController {
  final pdf = pw.Document();

  Future<String> generatePdfReport() async {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
            child: pw.Column(children: [
          pw.Column(children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child:
                      pw.Text('Serviço', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Quantidade',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Preço Unitário',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child:
                      pw.Text('Desconto', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Valor Total',
                      style: pw.TextStyle(fontSize: 12.0)),
                )
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Corte Masculino',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('1 UND', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('15,00', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('10%', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('13,50', style: pw.TextStyle(fontSize: 12.0)),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Corte Feminino',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('1 UND', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('15,00', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('10%', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('13,50', style: pw.TextStyle(fontSize: 12.0)),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Corte Feminino',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('1 UND', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('15,00', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('10%', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('13,50', style: pw.TextStyle(fontSize: 12.0)),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Corte Feminino',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('1 UND', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('15,00', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('10%', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('13,50', style: pw.TextStyle(fontSize: 12.0)),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Corte Feminino',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('1 UND', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('15,00', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('10%', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('13,50', style: pw.TextStyle(fontSize: 12.0)),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Corte Feminino',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('1 UND', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('15,00', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('10%', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('13,50', style: pw.TextStyle(fontSize: 12.0)),
                ),
              ],
            )
          ]),
          pw.Container(
            width: 500,
            margin: pw.EdgeInsets.all(30.0),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text('Cliente: Erick Monteiro',
                    style: pw.TextStyle(fontSize: 12.0)),
              ),
              pw.Expanded(
                flex: 1,
                child: pw.Text('Valor Total: 81,00',
                    style: pw.TextStyle(fontSize: 12.0)),
              ),
            ],
          )
        ])),
      ),
    );

    return generatePdf('reports test.pdf');
  }

  Future<String> generatePaymentVoucher() async {
    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Column(children: [
          pw.Text('Barbearia do Zé', style: pw.TextStyle(fontSize: 18.0)),
          pw.Container(
            width: 500,
            margin: pw.EdgeInsets.all(30.0),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
          pw.Text(DateTime.now().toString(),
              style: pw.TextStyle(fontSize: 16.0)),
          pw.Container(
            width: 500,
            margin: pw.EdgeInsets.all(30.0),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
          pw.Text('Itens do pedido', style: pw.TextStyle(fontSize: 16.0)),
          pw.SizedBox(height: 10),
          pw.Column(children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child:
                      pw.Text('Serviço', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Quantidade',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Preço Unitário',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child:
                      pw.Text('Desconto', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Valor Total',
                      style: pw.TextStyle(fontSize: 12.0)),
                )
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Corte Masculino',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('1 UND', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('15,00', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('10%', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('13,50', style: pw.TextStyle(fontSize: 12.0)),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('Corte Feminino',
                      style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('1 UND', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('15,00', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('10%', style: pw.TextStyle(fontSize: 12.0)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text('13,50', style: pw.TextStyle(fontSize: 12.0)),
                ),
              ],
            )
          ]),
          pw.Container(
            width: 500,
            margin: pw.EdgeInsets.all(30.0),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text('Cliente: Erick Monteiro',
                    style: pw.TextStyle(fontSize: 12.0)),
              ),
              pw.Expanded(
                flex: 1,
                child: pw.Text('Valor Total: 27,00',
                    style: pw.TextStyle(fontSize: 12.0)),
              ),
            ],
          )
        ]),
      ),
    ));

    return generatePdf('cupom_teste.pdf');
  }

  Future<String> generatePdf(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();

    final path = directory.path;

    final file = File('$path/$fileName');

    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  SizedBox spaceBoxHeigth(double value) {
    return SizedBox(height: value);
  }
}
