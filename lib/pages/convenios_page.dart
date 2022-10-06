import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/convenio_controller.dart';
import 'package:finances/pages/cadastro_convenio.dart';
import 'package:flutter/material.dart';

class ConveniosPage extends StatelessWidget {
  ConvenioController controller = ConvenioController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: title(context),
      ),
      body: SingleChildScrollView(
        child: listConvenios(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroConvenioPage('')),
          );
        },
        heroTag: null,
      ),
    ));
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
          Text('Cadastro de convênios')
        ]);
  }

  Widget listConvenios(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getConvenios(context),
            spaceBoxHeigth(50),
          ]),
    );
  }

  Widget getConvenios(BuildContext correctContext) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.getAllConvenio(),
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
                subtitle: Text(data['cnpj']),
                trailing: options(correctContext, document.id));
          }).toList(),
        );
      },
    );
  }

  SizedBox spaceBoxWidth(double value) {
    return SizedBox(width: value);
  }

  SizedBox spaceBoxHeigth(double value) {
    return SizedBox(height: value);
  }

  Column options(BuildContext context, String convenioId) {
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
                        builder: (context) => CadastroConvenioPage(convenioId)),
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
                                controller.deleteConvenio(convenioId);
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
}
