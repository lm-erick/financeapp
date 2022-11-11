import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/pacotes_controller.dart';
import 'package:finances/pages/cadastro_pacotes_servico.dart';
import 'package:flutter/material.dart';

class PacotesPage extends StatelessWidget {
  PacotesController controller = PacotesController();

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
        title: Text('Pacotes de servicos'),
      ),
      body: SingleChildScrollView(
        child: listServicos(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroPacoteServicos('')),
          );
        },
        heroTag: null,
      ),
    ));
  }

  Widget listServicos(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getPacotes(context),
            spaceBoxHeigth(50),
          ]),
    );
  }

  Widget getPacotes(BuildContext correctContext) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.getAll(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Something went wrong');

        if (snapshot.connectionState == ConnectionState.waiting)
          return Text("Loading");

        return ListView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['validade'].toDate().toString()),
                trailing: options(correctContext, document.id));
          }).toList(),
        );
      },
    );
  }

  Column options(BuildContext context, String pacoteId) {
    return Column(
      children: [
        Wrap(
          children: <Widget>[
            IconButton(
                iconSize: 20.0,
                icon: Icon(Icons.mode_edit_rounded),
                tooltip: 'Editar',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadastroPacoteServicos(pacoteId)),
                  );
                }),
            IconButton(
                iconSize: 20.0,
                icon: Icon(Icons.restore_from_trash_rounded),
                tooltip: 'Editar',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirme"),
                        content: Text("Deseja realmente deletar?"),
                        actions: [
                          TextButton(
                              child: Text("Não"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          TextButton(
                              child: Text("Sim"),
                              onPressed: () {
                                controller.delete(pacoteId);
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    },
                  );
                })
          ],
        )
      ],
    );
  }

  SizedBox spaceBoxWidth(double value) {
    return SizedBox(width: value);
  }

  SizedBox spaceBoxHeigth(double value) {
    return SizedBox(height: value);
  }
}
