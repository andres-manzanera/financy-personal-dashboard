import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _euroFormat = NumberFormat.currency(
    locale: 'es_ES',
    symbol: '€',
    decimalDigits: 2,
  );

  static final _euroFormatNoDecimals = NumberFormat.currency(
    locale: 'es_ES',
    symbol: '€',
    decimalDigits: 0,
  );

  /// Format as "1.023,00 €"
  static String format(double amount) {
    return _euroFormat.format(amount);
  }

  /// Format as "1.023 €"
  static String formatNoDecimals(double amount) {
    return _euroFormatNoDecimals.format(amount);
  }

  /// Format with sign: "+1.023,00 €" or "-1.023,00 €"
  static String formatWithSign(double amount) {
    final prefix = amount >= 0 ? '+' : '';
    return '$prefix${_euroFormat.format(amount)}';
  }

  /// Format compact: "1,4K €"
  static String formatCompact(double amount) {
    if (amount.abs() >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K €';
    }
    return format(amount);
  }
}
