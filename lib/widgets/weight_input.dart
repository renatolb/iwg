import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class WeightInput extends StatefulWidget {
  final String label;
  final double min;
  final double max;
  final double selectedWeight;
  final ValueChanged<double> onChangeCallback;

  WeightInput({Key key, this.label, this.selectedWeight, this.min, this.max, @required this.onChangeCallback}) : super(key: key);

  @override
  WeightInputState createState() => WeightInputState();
}

class WeightInputState extends State<WeightInput> {
  var inputLabelStyle = TextStyle(fontSize: 23, color: Colors.black87);
  int intValue;
  int decimalValue;

  @override
  void initState() {
    intValue = this.widget.selectedWeight.toInt();
    decimalValue = ((this.widget.selectedWeight - intValue)*10).toInt();
    super.initState();
  }

  void setValue(int val, bool decimal) {
    if (decimal) this.decimalValue = val;
    else this.intValue = val;
    emitInput("$intValue.$decimalValue");
  }

  void emitInput(String valor) {
      double val = double.tryParse(valor);
      if (val != null) {
        this.widget.onChangeCallback(val);
      }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.widget.label, style: inputLabelStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget> [
                Container(child: new NumberPicker.integer(
                    initialValue: intValue,
                    minValue: 30,
                    maxValue: 120,
                    itemExtent: 30,
                    step: 1,
                    highlightSelectedValue: true,
                    onChanged: (newValue) => setValue(newValue, false)
                )),
                Container(child: Text(',')),
                Container(child: new NumberPicker.integer(
                    initialValue: decimalValue,
                    minValue: 0,
                    maxValue: 95,
                    itemExtent: 30,
                    zeroPad: true,
                    step: 5,
                    highlightSelectedValue: true,
                    onChanged: (newValue) => setValue(newValue, true)
                )),
                Text('Kg', style: TextStyle(color: Colors.black45),)
              ],
            ),
          ],
        )
    );
  }
}