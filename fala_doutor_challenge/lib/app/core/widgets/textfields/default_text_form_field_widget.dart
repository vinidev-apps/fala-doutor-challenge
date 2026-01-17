import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormFieldWidget extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final bool? enabled;
  final TextStyle? labelTextStyle;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final int? hintTextMaxLines;
  final double? verticalPadding;
  final double? verticalContentPadding;
  final double? horizontalContentPadding;
  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final InputBorder? inputBorder;
  final Widget? suffix;
  final bool? filled;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final void Function(String?)? onSubmit;
  const DefaultTextFormFieldWidget({
    super.key,
    this.labelText,
    required this.hintText,
    this.enabled,
    this.labelTextStyle,
    this.textStyle,
    this.hintTextStyle,
    this.hintTextMaxLines,
    this.verticalPadding,
    this.verticalContentPadding,
    this.horizontalContentPadding,
    required this.textEditingController,
    this.textInputType,
    this.validator,
    this.inputBorder,
    this.suffix,
    this.filled,
    this.fillColor,
    this.inputFormatters,
    this.obscureText,
    this.onSubmit,
  });

  @override
  State<DefaultTextFormFieldWidget> createState() =>
      _DefaultTextFormFieldWidgetState();
}

class _DefaultTextFormFieldWidgetState
    extends State<DefaultTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.labelText != null,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                widget.labelText ?? "",
                style:
                    widget.labelTextStyle ??
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          TextFormField(
            enabled: widget.enabled ?? true,
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters ?? [],
            obscureText: widget.obscureText ?? false,
            cursorColor: Theme.of(context).colorScheme.primary,
            style:
                widget.textStyle ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.verticalContentPadding ?? 10,
                horizontal: widget.horizontalContentPadding ?? 20,
              ),
              filled: widget.filled ?? true,
              fillColor:
                  widget.fillColor ??
                  Theme.of(context).colorScheme.surfaceContainer,
              hintText: widget.hintText,
              hintStyle:
                  widget.hintTextStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              hintMaxLines: widget.hintTextMaxLines ?? 2,
              suffixIcon: widget.suffix,
              border:
                  widget.inputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
            ),
            onFieldSubmitted: widget.onSubmit,
            onSaved: widget.onSubmit,
          ),
        ],
      ),
    );
  }
}
