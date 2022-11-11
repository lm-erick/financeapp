import 'package:finances/pages/cadastro_agendamento.dart';
import 'package:finances/pages/dropdown_funcionarios.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaPage extends StatelessWidget {
  final TextEditingController _funcionario = TextEditingController();

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
          title: title(context),
        ),
        body: Container(
          child: SfCalendar(
            view: CalendarView.week,
            initialDisplayDate: DateTime.now(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CadastroAgendamento()),
            );
          },
          heroTag: null,
        ),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Agenda'),
          spaceBoxWidth(10),
          DropdownButtonFuncionarios(
            controller: _funcionario,
          ),
        ]);
  }

  SizedBox spaceBoxWidth(double value) {
    return SizedBox(width: value);
  }

  SizedBox spaceBoxHeigth(double value) {
    return SizedBox(height: value);
  }
}
