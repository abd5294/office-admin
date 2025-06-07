import 'package:intl/intl.dart';

String formatCustomDate(DateTime date) {
  final day = date.day;
  final suffix = getDaySuffix(day);
  final month = DateFormat('MMMM').format(date);
  final year = date.year;
  return '$day$suffix $month $year';
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
