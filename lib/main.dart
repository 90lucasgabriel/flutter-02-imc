import 'package:flutter/material.dart';

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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _result = "Informe seus dados";

  void _handleResetFields() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _result = "Informe seus dados";
    });
  }

  void _calculateImc() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double response = weight / (height * height);

    setState(() {
      _result = _checkResultImc(response);
    });
  }

  String _checkResultImc(double imc) {
    String parsedImc = imc.toStringAsPrecision(3);

    if (imc < 18.6) {
      return "Abaixo do peso ($parsedImc)";
    }
    if (imc >= 18.6 && imc < 24.9) {
      return "Peso ideal ($parsedImc)";
    }
    if (imc >= 24.9 && imc < 29.9) {
      return "Levemente acima do peso ($parsedImc)";
    }
    if (imc >= 29.9 && imc < 34.9) {
      return "Obseidade Grau I ($parsedImc)";
    }
    if (imc >= 34.9 && imc < 39.9) {
      return "Obseidade Grau II ($parsedImc)";
    }

    return "Obseidade Grau III ($parsedImc)";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _handleResetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.person_outline,
              size: 120,
              color: Colors.green,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.green),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),
              controller: weightController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.green),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),
              controller: heightController,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: _calculateImc,
                  child: Text(
                    "Calcular",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    //     EdgeInsets.all(15.0)),
                  ),
                ),
              ),
            ),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
