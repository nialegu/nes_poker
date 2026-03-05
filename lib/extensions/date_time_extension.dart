extension DateTimeExtension on DateTime {
  // Formatted date
  String get formattedDate {
    String formattedValue(int value) {
      return value < 10 ? '0$value' : value.toString();
    }

    return '${formattedValue(day)}.${formattedValue(month)}.$year';
  }
}
