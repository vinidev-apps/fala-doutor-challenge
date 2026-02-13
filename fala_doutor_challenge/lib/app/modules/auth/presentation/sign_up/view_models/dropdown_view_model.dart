class DropdownValueModel {
  dynamic value;
  String label;

  DropdownValueModel({required this.value, required this.label});
}

List<DropdownValueModel> userTypeValues = [
  DropdownValueModel(value: 'patient', label: 'Criar conta como Paciente'),
  DropdownValueModel(value: 'doctor', label: 'Criar conta como Médico'),
];

List<DropdownValueModel> sexValues = [
  DropdownValueModel(
    value: 'male',
    label: 'Me identifico como do sexo masculino',
  ),
  DropdownValueModel(
    value: 'female',
    label: 'Me identifico como do sexo feminino',
  ),
];

List<DropdownValueModel> hasHealthPlanValues = [
  DropdownValueModel(value: true, label: 'Sim, possuo plano de saúde'),
  DropdownValueModel(value: false, label: 'Não possuo plano de saúde'),
];

List<DropdownValueModel> specialityValues = [
  DropdownValueModel(value: 'Cardiologia', label: 'Cardiologia'),
  DropdownValueModel(value: 'Dermatologia', label: 'Dermatologia'),
  DropdownValueModel(value: 'Ginecologia', label: 'Ginecologia'),
  DropdownValueModel(value: 'Ortopedia', label: 'Ortopedia'),
  DropdownValueModel(value: 'Pediatria', label: 'Pediatria'),
];

List<DropdownValueModel> webAppointmentsValues = [
  DropdownValueModel(value: true, label: 'Sim, atendo teleconsultas'),
  DropdownValueModel(value: false, label: 'Não atendo teleconsultas'),
];
