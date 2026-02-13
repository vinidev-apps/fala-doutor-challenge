class Utils {
  static DateTime? parseBrazilianDate(String value) {
    try {
      final parts = value.split('/');

      if (parts.length != 3) return null;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final date = DateTime(year, month, day);

      // Garante que a data existe de verdade (ex: 31/02 não passa)
      if (date.day != day || date.month != month || date.year != year) {
        return null;
      }

      return date;
    } catch (_) {
      return null;
    }
  }
}
