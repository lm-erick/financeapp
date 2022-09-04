import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Finances'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _login,
                decoration: InputDecoration(labelText: 'Login'),
              ),
              TextField(
                controller: _password,
                decoration: InputDecoration(labelText: 'Senha'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {},
                child: Text('Entrar'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {},
                child: Text('Cadastrar-se'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
