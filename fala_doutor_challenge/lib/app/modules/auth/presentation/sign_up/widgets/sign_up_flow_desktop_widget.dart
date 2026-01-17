import 'package:fala_doutor_challenge/app/core/widgets/buttons/gradient_text_button_widget.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/sign_up_step_view_model.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/widgets/sign_up_flow_input_widget.dart';
import 'package:flutter/material.dart';

class SignUpFlowDesktopWidget extends StatefulWidget {
  final GlobalKey formKey;

  final double progress;
  final int stepIndex;
  final SignUpStepViewModel signUpStepViewModel;
  final String? Function(String?, String)? validateInputField;
  final void Function() onNextStep;

  const SignUpFlowDesktopWidget({
    super.key,
    required this.formKey,
    required this.progress,
    required this.stepIndex,
    required this.signUpStepViewModel,
    this.validateInputField,
    required this.onNextStep,
  });

  @override
  State<SignUpFlowDesktopWidget> createState() =>
      _SignUpFlowDesktopWidgetState();
}

class _SignUpFlowDesktopWidgetState extends State<SignUpFlowDesktopWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: constraints.maxWidth * widget.progress,
                  height: 12,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.tertiary,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInCubic,
                switchOutCurve: Curves.easeOutCubic,
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 30,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        widget.signUpStepViewModel.stepDisplayImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Form(
                      key: widget.formKey,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 700,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Theme.of(context).colorScheme.secondary,
                                    Theme.of(context).colorScheme.tertiary,
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  widget.signUpStepViewModel.stepHeadlineText,
                                  style: Theme.of(context).textTheme.headlineLarge
                                      ?.copyWith(color: Colors.white),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              const SizedBox(height: 30),
                              SignUpFlowInputWidget(
                                stepIndex: widget.stepIndex,
                                inputTextController: widget
                                    .signUpStepViewModel
                                    .stepTextEditingControler,
                                inputDropdownValue:
                                    widget.signUpStepViewModel.stepDropdownValue,
                                validateInputField: widget.validateInputField,
                              ),
                              const SizedBox(height: 30),
                              GradientTextButtonWidget(
                                labelText: 'continuar',
                                labelTextStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                    ),
                                onTap: widget.onNextStep,
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
