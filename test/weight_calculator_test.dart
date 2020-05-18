// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:iwg/weight_calculator.dart';

void main() {
  testWidgets('Test calculator', (WidgetTester tester) async {
    var calculator = WeightCalculator(usedSerum: 0.6, idealGainPercentage: 4);

    expect(calculator.getUF(42.5, 43.5), 1.6, reason: 'UF from 42.5 to 43.5 should be 1.6');
    expect(calculator.getUF(43.5, 43.5), 0.6, reason: 'UF from dryWeight equals currentWeight should be usedSerum');
    expect(calculator.getUF(44.5, 43.5), 0.6, reason: 'UF from dryWeight greater than currentWeight should be usedSerum');

    expect(calculator.getGainPercentage(42.5, 43.5).toStringAsFixed(2), '2.35', reason: 'Gain percentage should be rounded properly');
    expect(calculator.getGainPercentage(0, 45).toStringAsFixed(2), '0.00', reason: 'Gain percentage should avoid division by 0');
    expect(calculator.getGainPercentage(42.5, 42).toStringAsFixed(2), '-1.18', reason: 'Gain percentage should allow negative results');

    expect(calculator.getGainPerDay(3, 42.5, 43.8).toStringAsFixed(2), '0.43', reason: 'getGainPerDay should be 0.43');
    expect(calculator.getGainPerDay(1, 42.5, 43.8).toStringAsFixed(2), '1.30', reason: 'getGainPerDay should be 1.30');
    expect(calculator.getGainPerDay(2, 42.5, 43.8).toStringAsFixed(2), '0.65', reason: 'getGainPerDay should be 0.65');
    expect(calculator.getGainPerDay(0, 42.5, 43.8).toStringAsFixed(2), '1.30', reason: 'getGainPerDay should avoid division by 0');

    expect(calculator.getRecommendedGainPerDayInLiters(2, 42.5).toStringAsFixed(2), '0.85', reason: 'getRecommendedGainPerDayInLiters should be 0.85');
    expect(calculator.getRecommendedGainPerDayInLiters(3, 42.5).toStringAsFixed(2), '0.57', reason: 'getRecommendedGainPerDayInLiters should be 0.57');
    expect(calculator.getRecommendedGainPerDayInLiters(0, 42.5).toStringAsFixed(2), '1.70', reason: 'getRecommendedGainPerDayInLiters should avoid division by 0');
  });
}
