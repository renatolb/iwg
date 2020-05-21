class WeightCalculator {
  final usedSerum, idealGainPercentage;

  WeightCalculator({this.usedSerum = 0.6, this.idealGainPercentage = 4});

  double getExcess(dryWeight, currentWeight) {
    return currentWeight - dryWeight;
  }

  double getSerum() {
    return this.usedSerum;
  }

  double getUF(dryWeight, currentWeight) {
    var excess = this.getExcess(dryWeight, currentWeight);
    if (excess <= 0) return this.usedSerum;
    return excess + this.usedSerum;
  }

  double getGainPercentage(dryWeight, currentWeight) {
    if(dryWeight == 0) return 0.0;

    var excess = this.getExcess(dryWeight, currentWeight);
    return excess * 100 / dryWeight;
  }

  double getGainPerDay(daysSpan, dryWeight, currentWeight) {
    var excess = this.getExcess(dryWeight, currentWeight);
    if (daysSpan == 0) return excess;
    return excess / daysSpan;
  }

  double getRecommendedGainPerDayInLiters(daysSpan, dryWeight) {
    var totalGain = dryWeight * this.idealGainPercentage / 100;
    if (daysSpan == 0) return totalGain;
    return totalGain / daysSpan;
  }

}