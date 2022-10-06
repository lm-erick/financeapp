import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: title(context)),
        body: Container(
          child: SfCalendar(
            view: CalendarView.week,
            initialDisplayDate: DateTime.now(),
          ),
        ),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 20.0,
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            tooltip: 'Convênios',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          spaceBoxWidth(10),
          Text('Agenda')
        ]);
  }

  SizedBox spaceBoxWidth(double value) {
    return SizedBox(width: value);
  }

  SizedBox spaceBoxHeigth(double value) {
    return SizedBox(height: value);
  }
}
