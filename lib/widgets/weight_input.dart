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
    ThemeData theme = Theme.of(context);
    ThemeData sliderTheme = ThemeData.from(
        colorScheme: theme.colorScheme,
        textTheme: theme.textTheme.apply(
          fontSizeFactor: 1.1,
          bodyColor: Color.fromRGBO(102, 102, 102, 1)
        ),
    );

    var labelStyle = TextStyle(
        fontFamily: 'Inter',
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(107, 107, 107, 1)
    );

    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.widget.label, style: labelStyle,),
            Theme(
              data: sliderTheme,
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget> [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                        child: new NumberPicker.integer(
                        initialValue: intValue,
                        minValue: 30,
                        maxValue: 120,
                        itemExtent: 30,
                        listViewWidth: 47,
                        step: 1,
                        highlightSelectedValue: true,
                        onChanged: (newValue) => setValue(newValue, false)
                    )),
                    Container(child: Text(',', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                    Container(child: new NumberPicker.integer(
                        initialValue: decimalValue,
                        minValue: 0,
                        maxValue: 95,
                        itemExtent: 30,
                        listViewWidth: 47,
                        zeroPad: true,
                        step: 5,
                        highlightSelectedValue: true,
                        onChanged: (newValue) => setValue(newValue, true)
                    )),
                    Text('Kg', style: TextStyle(color: Colors.black45),)
                ],
              )
            ),
          ],
        )
    );
  }
}