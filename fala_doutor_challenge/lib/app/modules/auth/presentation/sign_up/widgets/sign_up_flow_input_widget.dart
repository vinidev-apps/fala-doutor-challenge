import 'package:fala_doutor_challenge/app/core/utils/formatters/date_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/utils/formatters/name_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/widgets/textfields/default_text_form_field_widget.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/user_type_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpFlowInputWidget extends StatefulWidget {
  final int stepIndex;
  final TextEditingController? inputTextController;
  final String? Function(String?, String)? validateInputField;
  final DropdownValueModel? inputDropdownValue;

  const SignUpFlowInputWidget({
    super.key,
    required this.stepIndex,
    this.inputTextController,
    this.validateInputField,
    this.inputDropdownValue,
  });

  @override
  State<SignUpFlowInputWidget> createState() => _SignUpFlowInputWidgetState();
}

class _SignUpFlowInputWidgetState extends State<SignUpFlowInputWidget> {
  @override
  Widget build(BuildContext context) {
    switch (widget.stepIndex) {
      case 0:
        return DropdownButtonFormField<String>(
          initialValue: widget.inputDropdownValue?.value,
          dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(30),
          style: Theme.of(context).textTheme.bodyLarge,
          padding: const EdgeInsets.symmetric(vertical: 10),
          items: [
            DropdownMenuItem(
              value: userTypeValues[0].value,
              child: Text(
                userTypeValues[0].label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            DropdownMenuItem(
              value: userTypeValues[1].value,
              child: Text(
                userTypeValues[1].label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
          onChanged: (String? newValue) {
            widget.inputDropdownValue?.value = newValue!;
          },
          onSaved: (String? newValue) {
            widget.inputDropdownValue?.value = newValue!;
          },
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.surfaceContainer,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: FaIcon(
                FontAwesomeIcons.chevronDown,
                color: Theme.of(context).colorScheme.onSurface,
                size: 15,
              ),
            ),
          ),
          hint: Text(
            widget.inputDropdownValue?.label ?? 'Selecione uma opção',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        );
      case 1:
        return DefaultTextFormFieldWidget(
          verticalPadding: 0,
          verticalContentPadding: 20,
          hintText: "Meu nome completo é...",
          textEditingController: widget.inputTextController!,
          textInputType: TextInputType.name,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          hintTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
          inputFormatters: [NameInputFormatter()],
          validator: (value) => widget.validateInputField!(value, 'name'),
        );
      case 2:
        return DropdownButtonFormField<String>(
          initialValue: widget.inputDropdownValue?.value,
          dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(30),
          style: Theme.of(context).textTheme.bodyLarge,
          padding: const EdgeInsets.symmetric(vertical: 10),
          items: [
            DropdownMenuItem(
              value: sexValues[0].value,
              child: Text(
                sexValues[0].label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            DropdownMenuItem(
              value: sexValues[1].value,
              child: Text(
                sexValues[1].label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
          onChanged: (String? newValue) {
            widget.inputDropdownValue?.value = newValue!;
          },
          onSaved: (String? newValue) {
            widget.inputDropdownValue?.value = newValue!;
          },
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.surfaceContainer,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: FaIcon(
                FontAwesomeIcons.chevronDown,
                color: Theme.of(context).colorScheme.onSurface,
                size: 15,
              ),
            ),
          ),
          hint: Text(
            widget.inputDropdownValue?.label ?? 'Selecione uma opção',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        );
      case 3:
        return DefaultTextFormFieldWidget(
          verticalPadding: 0,
          verticalContentPadding: 20,
          hintText: '00/00/0000',
          textEditingController: widget.inputTextController!,
          textInputType: TextInputType.datetime,
          suffix: FaIcon(
            FontAwesomeIcons.calendar,
            color: Theme.of(context).colorScheme.onSurface,
            size: 15,
          ),
          inputFormatters: [DateInputFormatter()],
          validator: (value) => widget.validateInputField!(value, 'datePicker'),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
