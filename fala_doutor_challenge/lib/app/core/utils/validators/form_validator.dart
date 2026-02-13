class FormValidator {
  FormValidator._();

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 3) {
      return 'O nome deve ter ao menos 3 caracteres.';
    }

    if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value)) {
      return 'O nome deve conter apenas letras e espaços.';
    }

    if (!value.trim().contains(' ')) {
      return 'O nome não pode ser uma única palavra.';
    }

    return null;
  }

  static String? birthDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      return 'Data inválida. Use dd/mm/aaaa.';
    }

    final parts = value.split('/');
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return 'Data inválida.';
    }

    final date = DateTime.tryParse(
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}',
    );

    if (date == null ||
        date.day != day ||
        date.month != month ||
        date.year != year) {
      return 'Data inválida.';
    }

    if (date.isAfter(DateTime.now())) {
      return 'A data não pode ser no futuro.';
    }

    if (year < 1900) {
      return 'A data não pode ser anterior a 1900.';
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'E-mail inválido';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 8) {
      return 'A senha deve ter ao menos 8 caracteres.';
    }

    return null;
  }

  static String? crm(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    final crm = value.trim().toUpperCase();

    // Formato básico: 4 a 6 números + /UF
    final regex = RegExp(r'^\d{4,6}\/[A-Z]{2}$');

    if (!regex.hasMatch(crm)) {
      return 'CRM inválido. Use o formato 123456/UF';
    }

    final uf = crm.split('/').last;

    const ufsValidas = [
      'AC',
      'AL',
      'AP',
      'AM',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MT',
      'MS',
      'MG',
      'PA',
      'PB',
      'PR',
      'PE',
      'PI',
      'RJ',
      'RN',
      'RS',
      'RO',
      'RR',
      'SC',
      'SP',
      'SE',
      'TO',
    ];

    if (!ufsValidas.contains(uf)) {
      return 'UF inválida no CRM';
    }

    return null;
  }
}
