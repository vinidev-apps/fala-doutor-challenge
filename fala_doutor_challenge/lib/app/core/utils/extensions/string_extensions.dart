extension FirstNameExtension on String {
  String get firstName {
    if (trim().isEmpty) return '';
    return trim().split(RegExp(r'\s+')).first;
  }
}
