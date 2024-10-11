import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:working_time_manager/app/shared/components/custom_icon.dart';
import 'package:working_time_manager/core/app_responsivity.dart';
import 'package:working_time_manager/core/theme/fonts.dart';

class CustomTextField extends StatefulWidget {
  final bool? enableInteractiveSelection;
  final bool enableButtonCleanValue;
  final VoidCallback? onPressedSuffixIcon;
  final String? label;
  final TextStyle? labelTextStyle;
  final bool enabled;
  final bool isReadOnly;
  final AutovalidateMode? autovalidateMode;
  final String hintText;
  final bool isCurrency;
  final IconData? suffixicon;
  final Function(String)? onChanged;
  final bool enableSuggestions;
  final double? height;
  final TextEditingController? controller;
  final String? Function(String?)? validatorFunction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onFieldSubmitted;
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final bool autofocus;
  final Function()? onPressed;
  final bool isFilled;
  final bool isWhite;
  final void Function()? onEditingComplete;
  final bool handleDecimal;
  final TextCapitalization? textCapitalization;

  const CustomTextField({
    super.key,
    this.enabled = true,
    this.isReadOnly = false,
    this.autovalidateMode,
    this.enableInteractiveSelection,
    this.enableButtonCleanValue = false,
    this.onPressedSuffixIcon,
    this.label,
    this.labelTextStyle,
    required this.hintText,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.isCurrency = false,
    this.suffixicon,
    this.onChanged,
    this.enableSuggestions = true,
    this.height,
    this.controller,
    this.onTap,
    this.keyboardType,
    this.validatorFunction,
    this.inputFormatters,
    this.focusNode,
    this.onPressed,
    this.initialValue,
    this.isFilled = true,
    this.isWhite = false,
    this.onEditingComplete,
    this.handleDecimal = false,
    this.textCapitalization,
  });

  const CustomTextField.dateTimeField({
    super.key,
    this.onTap,
    this.isReadOnly = true,
    this.controller,
    this.autofocus = false,
    this.enableSuggestions = false,
    required this.hintText,
    this.enableInteractiveSelection = true,
    this.isCurrency = false,
    this.suffixicon,
    this.enabled = true,
    this.enableButtonCleanValue = false,
    this.autovalidateMode,
    this.isFilled = true,
    this.isWhite = false,
    this.handleDecimal = false,
    this.labelTextStyle,
    this.onEditingComplete,
    this.label,
    this.maxLines = 1,
    this.maxLength = 999,
    this.keyboardType = TextInputType.none,
    this.textCapitalization,
    this.validatorFunction,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialValue,
    this.onPressedSuffixIcon,
    this.focusNode,
    this.onPressed,
    this.onChanged,
    this.height,
  });

    const CustomTextField.currency({
    super.key,
    this.onTap,
    this.isReadOnly = false,
    this.controller,
    this.autofocus = false,
    this.enableSuggestions = false,
    required this.hintText,
    this.enableInteractiveSelection = true,
    this.isCurrency = true,
    this.suffixicon,
    this.enabled = true,
    this.enableButtonCleanValue = false,
    this.autovalidateMode,
    this.isFilled = true,
    this.isWhite = false,
    this.handleDecimal = false,
    this.labelTextStyle,
    this.onEditingComplete,
    this.label,
    this.maxLines = 1,
    this.maxLength = 999,
    this.keyboardType = TextInputType.number,
    this.textCapitalization,
    this.validatorFunction,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialValue,
    this.onPressedSuffixIcon,
    this.focusNode,
    this.onPressed,
    this.onChanged,
    this.height,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.label != null,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.label ?? '',
                  // style: widget.labelTextStyle ?? labelStyle,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        SizedBox(
          height: widget.height,
          child: TextFormField(
            readOnly: widget.isReadOnly,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            autovalidateMode: widget.autovalidateMode,
            onEditingComplete: widget.onEditingComplete,
            enabled: widget.enabled,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            enableSuggestions: widget.enableSuggestions,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            onTap: widget.onTap,
            onFieldSubmitted: widget.onFieldSubmitted,
            initialValue: widget.initialValue,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
            controller: widget.controller,
            validator: widget.validatorFunction,
            inputFormatters: widget.inputFormatters,
            style: textFieldStyle(context),
            decoration: InputDecoration(
              counterText: '',
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              errorMaxLines: 2,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary, width: 2.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              prefixIcon: widget.isCurrency
                  ? Padding(
                      padding: EdgeInsets.only(left: 10.s),
                      child: Text(
                        widget.isCurrency ? 'R\$' : '',
                        style: textFieldStyle(context),
                      )
                    )
                  : null,
              prefixIconConstraints: widget.isCurrency ? BoxConstraints.tight(Size(30.s2, 20.s2)) : BoxConstraints.tight(Size(60, 20.s)),
              suffixIcon: widget.enableButtonCleanValue
                    ? GestureDetector(
                        child: CustomIcon(
                          iconData: Icons.clear,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onTap: () {
                          widget.controller!.clear();
                        },
                      ) : GestureDetector(
                        onTap: widget.onPressedSuffixIcon,
                        child: CustomIcon(
                          iconData: widget.suffixicon,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    
              suffixIconConstraints: BoxConstraints.tight(const Size(60, 25)),
              filled: widget.isFilled,
              hintStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.9),
              ),
              hintText: widget.hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: Device.height < 600 ? 15 : 15.s),
            ),
          ),
        ),
      ],
    );
  }
}
