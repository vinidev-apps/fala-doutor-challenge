import 'package:fala_doutor_challenge/app/core/utils/formatters/date_input_formatter.dart';
import 'package:fala_doutor_challenge/app/core/widgets/buttons/gradient_text_button_widget.dart';
import 'package:fala_doutor_challenge/app/core/widgets/textfields/default_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DefaultDateFilterDialogWidget extends StatefulWidget {
  final String title;
  final GlobalKey filterFormKey;
  final TextEditingController initialDateFilterControler;
  final TextEditingController finalDateFilterControler;
  final String? Function(String) validateDateFields;
  final void Function() filter;
  const DefaultDateFilterDialogWidget({
    super.key,
    required this.title,
    required this.filterFormKey,
    required this.initialDateFilterControler,
    required this.finalDateFilterControler,
    required this.validateDateFields,
    required this.filter,
  });

  @override
  State<DefaultDateFilterDialogWidget> createState() =>
      _DefaultDateFilterDialogWidgetState();
}

class _DefaultDateFilterDialogWidgetState
    extends State<DefaultDateFilterDialogWidget> {
  bool isFirstValidationText = false;
  bool isLastValidationText = false;
  @override
  Widget build(BuildContext context) {
    final Locale locale = Localizations.localeOf(context);

    String getDateFormat() {
      if (locale.languageCode == 'en') {
        return "MM/dd/yyyy";
      } else {
        return "dd/MM/yyyy";
      }
    }

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.headlineMedium),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: FaIcon(
              FontAwesomeIcons.xmark,
              color: Theme.of(context).colorScheme.onBackground,
              size: 35,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: widget.filterFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: DefaultTextFormFieldWidget(
                        labelText: 'Data inicial',
                        hintText: 'Insira as datas iniciais...',
                        textEditingController:
                            widget.initialDateFilterControler,
                        textInputType: TextInputType.datetime,
                        inputBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        validator: (value) {
                          setState(() {
                            isFirstValidationText =
                                widget.validateDateFields(value!) is String;
                          });
                          return widget.validateDateFields(value!);
                        },
                        inputFormatters: [DateInputFormatter()],
                        fillColor: Theme.of(context).colorScheme.surfaceTint,
                      ),
                    ),
                    InkWell(
                      overlayColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary.withOpacity(0),
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          locale: Localizations.localeOf(context),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2025, 06, 01),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.primary,
                                colorScheme: Theme.of(context).colorScheme
                                    .copyWith(
                                      primary:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.tertiary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      onSurfaceVariant: Theme.of(
                                        context,
                                      ).colorScheme.onBackground,
                                      surface: Theme.of(
                                        context,
                                      ).colorScheme.inverseSurface,
                                    ),
                                textTheme: Theme.of(context).textTheme.copyWith(
                                  labelLarge: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.tertiary,
                                      ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          widget.initialDateFilterControler.text = DateFormat(
                            getDateFormat(),
                          ).format(picked);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.only(
                              top: 13.3,
                              bottom: 13.3,
                              right: 5,
                            ),
                            width: 50,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.calendar,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isFirstValidationText,
                            child: const SizedBox(height: 23),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: DefaultTextFormFieldWidget(
                        labelText: 'Data final',
                        hintText: 'Insira a data final...',
                        textEditingController: widget.finalDateFilterControler,
                        textInputType: TextInputType.datetime,
                        inputBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        validator: (value) {
                          setState(() {
                            isLastValidationText =
                                widget.validateDateFields(value!) is String;
                          });
                          return widget.validateDateFields(value!);
                        },
                        inputFormatters: [DateInputFormatter()],
                        fillColor: Theme.of(context).colorScheme.surfaceTint,
                      ),
                    ),
                    InkWell(
                      overlayColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary.withOpacity(0),
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2025, 06, 01),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.primary,
                                colorScheme: Theme.of(context).colorScheme
                                    .copyWith(
                                      primary:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.tertiary
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      onSurfaceVariant: Theme.of(
                                        context,
                                      ).colorScheme.onBackground,
                                      surface: Theme.of(
                                        context,
                                      ).colorScheme.inverseSurface,
                                    ),
                                textTheme: Theme.of(context).textTheme.copyWith(
                                  labelLarge: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.tertiary,
                                      ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          widget.finalDateFilterControler.text = DateFormat(
                            getDateFormat(),
                          ).format(picked);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.only(
                              top: 13.3,
                              bottom: 13.3,
                              right: 5,
                            ),
                            width: 50,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.calendar,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isLastValidationText,
                            child: const SizedBox(height: 23),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GradientTextButtonWidget(
                onTap: widget.filter,
                labelText: 'Filtrar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
