extension NumberExtension on int {
  String toPercentCount() {
    if (this >= 1000000000) {
      return toString().replaceRange(1, null, 'MR');
    } else if (this >= 100000000) {
      return toString().replaceRange(3, null, 'MN');
    } else if (this >= 10000000) {
      return toString().replaceRange(
          2, null, toString()[2] == "0" ? "MN" : ',${toString()[2]}MN');
    } else if (this >= 10000000) {
      return toString().replaceRange(
          2, null, toString()[1] == "0" ? "MN" : ',${toString()[1]}MN');
    } else if (this >= 1000000) {
      return toString().replaceRange(
          1, null, toString()[1] == "0" ? "MN" : ',${toString()[1]}MN');
    } else if (this >= 100000) {
      return toString().replaceRange(
          3, null, toString()[4] == "0" ? "B" : ',${toString()[4]}B');
    } else if (this >= 10000) {
      return toString().replaceRange(
          2, null, toString()[2] == "0" ? "B" : ',${toString()[2]}B');
    }
    return toString();
  }
}
