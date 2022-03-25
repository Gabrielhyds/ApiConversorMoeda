import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Uso da API retorna valor do bitcoin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _preco = "0";
  String _preco2 = "0";
  _buscaPreco() async {
    String urlAPI = "https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL,BTC-BRL";
    http.Response response;
    response = await http.get(urlAPI);
    Map<String, dynamic> retorno = json.decode(response.body);
    print(retorno);
    print(retorno["USDBRL"]["high"].toString());
    setState(() {
      _preco = retorno["USDBRL"]["high"].toString();
    });
  }

  _buscaPreco2() async {
    String urlAPI = "https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL,BTC-BRL";
    http.Response response;
    response = await http.get(urlAPI);
    Map<String, dynamic> retorno = json.decode(response.body);
    print(retorno);
    print(retorno["EURBRL"]["high"].toString());
    setState(() {
      _preco = retorno["EURBRL"]["high"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.monetization_on_sharp, size: 100.0, color: Colors.greenAccent),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "R\$ " + _preco,
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
              RaisedButton(
                  color: Colors.greenAccent,
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Text("Dolar (\$)",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                  onPressed: _buscaPreco),
              RaisedButton(
                  color: Colors.greenAccent,
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Text("Euro (€)",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                  onPressed: _buscaPreco2)
            ]),
          ],
        ),
      ),
    ));
  }
}
