import 'package:fala_doutor_challenge/app/core/utils/formatters/crm_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/utils/formatters/date_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/utils/formatters/email_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/utils/formatters/name_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/utils/validators/form_validator.dart';
import 'package:fala_doutor_challenge/app/core/widgets/textfields/default_date_text_form_field_widget.dart';
import 'package:fala_doutor_challenge/app/core/widgets/textfields/default_text_form_field_widget.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/bloc/sign_up_states.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/dropdown_view_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/sign_up_step_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpFlowInputWidget extends StatefulWidget {
  final SignUpFlowState state;
  final int stepIndex;
  final SignUpStepViewModel stepViewModel;
  final TextEditingController? inputTextController;
  final DropdownValueModel? inputDropdownValue;

  const SignUpFlowInputWidget({
    super.key,
    required this.state,
    required this.stepIndex,
    required this.stepViewModel,
    this.inputTextController,
    this.inputDropdownValue,
  });

  @override
  State<SignUpFlowInputWidget> createState() => _SignUpFlowInputWidgetState();
}

class _SignUpFlowInputWidgetState extends State<SignUpFlowInputWidget> {
  @override
  Widget build(BuildContext context) {
    switch (widget.stepIndex) {
      // Step 1: User Type
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
      // Step 2: Nome
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
          validator: (value) => FormValidator.name(value),
        );
      // Step 3: Sexo
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
      // Step 4: Data de Nascimento
      case 3:
        return DefaultDateTextFormFieldWidget(
          textEditingController: widget.inputTextController!,
          textInputType: TextInputType.datetime,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          hintTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
          inputFormatters: [DateInputFormatter()],
          validator: (value) => FormValidator.birthDate(value),
        );
      // Step 5: E-mail
      case 4:
        return DefaultTextFormFieldWidget(
          verticalPadding: 0,
          verticalContentPadding: 20,
          hintText: "Meu email é...",
          textEditingController: widget.inputTextController!,
          textInputType: TextInputType.emailAddress,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          hintTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
          inputFormatters: [EmailInputFormatter()],
          validator: (value) => FormValidator.email(value),
        );
      // Step 6: Has Health Plan or CRM
      case 5:
        if (widget.state.user.type == "patient") {
          return DropdownButtonFormField<bool>(
            initialValue: widget.inputDropdownValue?.value,
            dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(30),
            style: Theme.of(context).textTheme.bodyLarge,
            padding: const EdgeInsets.symmetric(vertical: 10),
            items: [
              DropdownMenuItem(
                value: hasHealthPlanValues[0].value,
                child: Text(
                  hasHealthPlanValues[0].label,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              DropdownMenuItem(
                value: hasHealthPlanValues[1].value,
                child: Text(
                  hasHealthPlanValues[1].label,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
            onChanged: (bool? newValue) {
              widget.inputDropdownValue?.value = newValue!;
            },
            onSaved: (bool? newValue) {
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
        }
        return DefaultTextFormFieldWidget(
          verticalPadding: 0,
          verticalContentPadding: 20,
          hintText: "Meu CRM é...",
          textEditingController: widget.inputTextController!,
          textInputType: TextInputType.text,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          hintTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
          inputFormatters: [CrmInputFormatter()],
          validator: (value) => FormValidator.crm(value),
        );
      // Step 7: Patient health plan or
      case 6:
        if (widget.state.user.type == "patient") {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final healthPlan = widget.stepViewModel.healthPlansDoctor?[index];
              return FilterChip(
                label: Text(healthPlan?.displayName ?? ''),
                onSelected: (value) {},
              );
            },
            itemCount: widget.stepViewModel.healthPlansDoctor?.length ?? 0,
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final healthPlan = widget.stepViewModel.healthPlansDoctor?[index];
            return FilterChip(
              label: Text(healthPlan?.displayName ?? ''),
              onSelected: (value) {},
            );
          },
          itemCount: widget.stepViewModel.healthPlansDoctor?.length ?? 0,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
