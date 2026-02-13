import 'package:fala_doutor_challenge/app/core/utils/formatters/date_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/utils/validators/form_validator.dart';
import 'package:fala_doutor_challenge/app/core/widgets/textfields/default_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DefaultDateTextFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? labelText;
  final String? hintText;
  final bool? enabled;
  final TextStyle? labelTextStyle;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final int? hintTextMaxLines;
  final double? verticalPadding;
  final double? verticalContentPadding;
  final double? horizontalContentPadding;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final bool? filled;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSubmit;

  const DefaultDateTextFormFieldWidget({
    super.key,
    required this.textEditingController,
    this.labelText,
    this.hintText,
    this.enabled,
    this.labelTextStyle,
    this.textStyle,
    this.hintTextStyle,
    this.hintTextMaxLines,
    this.verticalPadding,
    this.verticalContentPadding,
    this.horizontalContentPadding,
    this.textInputType,
    this.validator,
    this.filled,
    this.fillColor,
    this.inputFormatters,
    this.onSubmit,
  });

  Future<void> _openDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: Localizations.localeOf(context),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 01, 01),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Theme.of(context).colorScheme.surface,
              headerBackgroundColor: Theme.of(context).colorScheme.primary,
              headerForegroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      textEditingController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextFormFieldWidget(
      labelText: labelText,
      enabled: enabled,
      verticalPadding: verticalPadding,
      verticalContentPadding: verticalContentPadding ?? 18,
      horizontalContentPadding: horizontalContentPadding ?? 20,
      hintText: hintText ?? 'Formato: dd/mm/aaaa',
      hintTextMaxLines: hintTextMaxLines,
      textEditingController: textEditingController,
      textInputType: textInputType ?? TextInputType.datetime,
      textStyle: textStyle ?? Theme.of(context).textTheme.bodyLarge,
      hintTextStyle:
          hintTextStyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
      inputFormatters: inputFormatters ?? [DateInputFormatter()],
      validator: validator ?? (value) => FormValidator.birthDate(value),
      filled: filled,
      fillColor: fillColor,
      onSubmit: onSubmit,
      suffix: InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () => _openDatePicker(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.solidCalendarDays,
              size: 20,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
