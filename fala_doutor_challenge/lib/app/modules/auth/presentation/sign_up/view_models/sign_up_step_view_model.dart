import 'package:fala_doutor_challenge/app/modules/auth/domain/entities/health_plan_entity.dart';
import 'package:fala_doutor_challenge/app/modules/auth/presentation/sign_up/view_models/dropdown_view_model.dart';
import 'package:flutter/material.dart';

class SignUpStepViewModel {
  final String stepDisplayImage;
  final String stepHeadlineText;
  final TextEditingController? stepTextEditingControler;
  final DropdownValueModel? stepDropdownValue;
  final List<DropdownValueModel>? stepDropdownItems;
  final List<HealthPlanEntity>? healthPlansDoctor;
  final List<String>? availableCitiesDoctor;

  SignUpStepViewModel({
    required this.stepDisplayImage,
    required this.stepHeadlineText,
    this.stepTextEditingControler,
    this.stepDropdownValue,
    this.stepDropdownItems,
    this.healthPlansDoctor,
    this.availableCitiesDoctor,
  });
}
