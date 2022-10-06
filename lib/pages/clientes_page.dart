import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/controller/cliente_controller.dart';
import 'package:finances/pages/cadastro_cliente.dart';
import 'package:flutter/material.dart';

class ClientesPage extends StatelessWidget {
  ClienteController controller = ClienteController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: title(context),
      ),
      body: SingleChildScrollView(
        child: listClients(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroClientePage('')),
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
          Text('Cadastro de clientes')
        ]);
  }

  Widget listClients(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getClients(context),
            spaceBoxHeigth(50),
          ]),
    );
  }

  Widget getClients(BuildContext correctContext) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.getAllClients(),
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
                subtitle: Text(data['document']),
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

  Column options(BuildContext context, String clientId) {
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
                        builder: (context) => CadastroClientePage(clientId)),
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
                                ClienteController().deleteClient(clientId);
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
