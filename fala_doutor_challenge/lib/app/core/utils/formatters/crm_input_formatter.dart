import 'package:flutter/services.dart';

class CrmInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (text.isEmpty) return newValue;

    // Remove tudo que não for letra ou número
    text = text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      final char = text[i];

      // Primeira parte: apenas números (até 6)
      if (buffer.length < 6 && RegExp(r'\d').hasMatch(char)) {
        buffer.write(char);
      }
      // Adiciona a barra automaticamente após os números
      else if (buffer.length >= 4 &&
          buffer.length <= 6 &&
          buffer.toString().contains('/') == false) {
        buffer.write('/');
        if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
          buffer.write(char.toUpperCase());
        }
      }
      // UF: apenas letras (2 caracteres)
      else if (buffer.toString().contains('/') &&
          buffer.length < 9 &&
          RegExp(r'[a-zA-Z]').hasMatch(char)) {
        buffer.write(char.toUpperCase());
      }
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
