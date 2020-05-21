import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iwg/weight_calculator.dart';
import 'package:iwg/widgets/weight_input.dart';

import 'gain_meter.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _minWeight = 30.0;
  final double _maxWeight = 120.0;
  double _dryWeight, _currentWeight;

  WeightCalculator calculator;

  _MyHomePageState() : super() {
    this._dryWeight = _minWeight;
    this._currentWeight = _maxWeight/2;
    this.calculator = WeightCalculator();
  }

  void _setDryWeight(double valor) {
    setState(() {
      if(valor > _maxWeight) valor = _maxWeight;
      if(valor < _minWeight) valor = _minWeight;
      this._dryWeight = valor;
    });
  }

  void _setCurrWeight(double valor) {
    setState(() {
      if(valor > _maxWeight) valor = _maxWeight;
      if(valor < _minWeight) valor = _minWeight;
      this._currentWeight = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    var uf = calculator.getUF(this._dryWeight, this._currentWeight);
    var serum = calculator.getSerum();
    var resultadoUF = '${uf.toStringAsFixed(2)}L (${(uf-serum).toStringAsFixed(2)}L + ${serum.toStringAsFixed(1)}L)';

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title)
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  WeightInput(label: 'Peso Seco', min: this._minWeight, max: this._maxWeight, selectedWeight: _dryWeight, onChangeCallback: this._setDryWeight),
                  WeightInput(label: 'Peso Atual', min: this._minWeight, max: this._maxWeight, selectedWeight: _currentWeight, onChangeCallback: this._setCurrWeight),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(resultadoUF, style: TextStyle(
                      fontSize: 30
                  )),
                  GainMeter(current: calculator.getGainPercentage(_dryWeight, _currentWeight))
                ],
              ),
            ]
          )
        )
      )
    );
  }
}
