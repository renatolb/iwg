import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GainMeter extends StatefulWidget {
  final double min, max, limit, current;

  GainMeter({Key key, this.min = 0, this.max = 10, this.limit = 5, this.current = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GainMeterState();
}

class GainMeterState extends State<GainMeter> {
  scaleBetween(unscaledNum, minAllowed, maxAllowed, min, max) => (maxAllowed - minAllowed) * (unscaledNum - min) / (max - min) + minAllowed;

  @override
  Widget build(BuildContext context) {
    double currentPos = this.widget.current <= 0 ? 0 : this.widget.current >= this.widget.max ? this.widget.max : this.widget.current;
    return
      new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            toScale(n) => scaleBetween(n, -15, constraints.maxWidth-35, this.widget.min, this.widget.max);
            toStopScale(n) => scaleBetween(n, 0, 1, this.widget.min, this.widget.max);

            var limitMarkerPosition = toScale(this.widget.limit);
            var limitStop = toStopScale(this.widget.limit);
            var greenStop = limitStop / 1.6;
            var yellowStop = limitStop / 1.1;
            var redStop = limitStop;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [Container(
                      height: 10,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              stops: [greenStop, yellowStop, redStop],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.green, Colors.yellow, Colors.red]
                          )
                      ),
                    ), Positioned(
                        left: limitMarkerPosition,
                        top: 2,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.arrow_drop_up, color: Colors.red,),
                            Text(this.widget.limit.toInt().toString() + '%')
                          ],
                        ),
                      ),
                      Positioned(
                        left: toScale(currentPos),
                        top: 2,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.arrow_drop_up, color: Colors.black,),
                            Text(currentPos.toStringAsFixed(1) + '%')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
      );
  }
}