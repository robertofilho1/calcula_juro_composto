import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController CapitalController = TextEditingController();
  TextEditingController TaxController = TextEditingController();
  TextEditingController TimeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _InfoText = "Informe dados validos para calculo!";

  void _resetfield() {
    CapitalController.text = "";
    TaxController.text = "";
    TimeController.text = "";

    setState(() {
      _InfoText = "Informe dados validos para calculo!";
    });
  }

  void _calculate() {
    setState(() {
      double capital = double.parse(CapitalController.text);
      double time = double.parse(TimeController.text);
      double tax = double.parse(TaxController.text) / 100;
      double variation = 1 + tax;
      double future_value = capital * (pow(variation, time));
      print(future_value);

      _InfoText= "O valor financiado total é ${future_value.toStringAsFixed(2)}";

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Simulador Financiamento"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetfield,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.monetization_on,
                    size: 120.0,
                    color: Colors.black54,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Capital em Reais",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    controller: CapitalController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira o Capital!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Prazo Financiamento",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    controller: TimeController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira o tempo do financiamento!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Taxa de Juros",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    controller: TaxController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira a taxa de Juros";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Simular!",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    _InfoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ],
              ),
            )));
  }
}
