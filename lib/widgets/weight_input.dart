import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeightInput extends StatefulWidget {
  final String label;
  final double min;
  final double max;
  final ValueChanged<double> onChangeCallback;
  final double selectedWeight;

  WeightInput({Key key, this.label, this.selectedWeight, this.min, this.max, @required this.onChangeCallback}) : super(key: key);

  @override
  WeightInputState createState() => WeightInputState();
}

class WeightInputState extends State<WeightInput> {
  var inputLabelStyle = TextStyle(fontSize: 23, color: Colors.black87);

  void _setWeight(String valor) {
      double val = double.tryParse(valor);
      if (val == null) val = widget.selectedWeight;
      this.widget.onChangeCallback(val);
  }

  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController(text: widget.selectedWeight.toStringAsFixed(2));

    return Container(
        child: Column(
          children: <Widget>[
            Text(this.widget.label, style: inputLabelStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget> [
                FlatButton(child: Icon(Icons.remove, color: Colors.red,), onPressed: () => {this._setWeight((this.widget.selectedWeight - 0.1).toStringAsFixed(2))},),
                Container(
                    width: 60,
                    child:
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: null,
                      style: TextStyle(fontSize: 20),
                      controller: inputController,
                      onChanged: (text) => this._setWeight(text),
                      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                  )
                ),
                FlatButton(child: Icon(Icons.add, color: Colors.red,), onPressed: () => {this._setWeight((this.widget.selectedWeight + 0.1).toStringAsFixed(2))},),
              ],
            ),
            Slider(
              value: this.widget.selectedWeight,
              min: this.widget.min,
              max: this.widget.max,
              divisions: ((this.widget.max - this.widget.min) * 2).toInt(),
              onChanged: this.widget.onChangeCallback,
            ),
          ],
        )
    );
  }
}