import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static final _fullDate = DateFormat('dd/MM/yyyy');
  static final _shortDate = DateFormat('dd MMM', 'es_ES');
  static final _monthYear = DateFormat('MMMM yyyy', 'es_ES');
  static final _time = DateFormat('HH:mm');
  static final _dayMonth = DateFormat('dd/MM');

  /// Format as "07/09/2026"
  static String formatFull(DateTime date) => _fullDate.format(date);

  /// Format as "07 sep"
  static String formatShort(DateTime date) => _shortDate.format(date);

  /// Format as "Marzo 2024"
  static String formatMonthYear(DateTime date) {
    final formatted = _monthYear.format(date);
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  /// Format as "14:32"
  static String formatTime(DateTime date) => _time.format(date);

  /// Format as "07/09"
  static String formatDayMonth(DateTime date) => _dayMonth.format(date);

  /// Returns "Hoy", "Ayer", or formatted date
  static String formatRelativeDay(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateDay = DateTime(date.year, date.month, date.day);

    if (dateDay == today) return 'Hoy';
    if (dateDay == today.subtract(const Duration(days: 1))) return 'Ayer';
    return '${date.day} de ${_getMonthName(date.month)}';
  }

  static String _getMonthName(int month) {
    const months = [
      '', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return months[month];
  }
}
