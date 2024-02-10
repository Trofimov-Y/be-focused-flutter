import 'package:intl/intl.dart';

final _time = DateFormat('HH:mm', 'en_US');
final _onlyMonth = DateFormat('MMMM', 'en_US');
final _onlyDay = DateFormat('E', 'en_US');
final _weekdayDate = DateFormat('EEEE, MMMM dd', 'en_US');

extension DateTimeExtension on DateTime {
  String get timeFormat => _time.format(this);

  String get onlyMonthFormat => _onlyMonth.format(this);

  String get onlyDayFormat => _onlyDay.format(this);

  String get weekdayDateFormat => _weekdayDate.format(this);
}
