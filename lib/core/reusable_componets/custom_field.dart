import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  CustomField({super.key,
    required this.keyboard,
    required this.hint,
    this.prefix,
    required this.controller,
    this.isObscure = false,
    this.onChanged,
    required this.validator, this.maxLine = 1});

  final String hint;
  void Function(String)?onChanged;
  String? prefix;
  final TextEditingController controller;
  final TextInputType keyboard;
  final bool isObscure;
  String? Function(String?) validator;
  int? maxLine;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool passwordToggle = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:(value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }

      } ,
      maxLines:widget.maxLine,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (value) => widget.validator(value),
      obscureText: passwordToggle ? widget.isObscure : false,
      obscuringCharacter: "*",
      keyboardType: widget.keyboard,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.isObscure
            ? IconButton(
          onPressed: () {
            passwordToggle = !passwordToggle;
            setState(() {

            });
          },
          color: Theme
              .of(context)
              .colorScheme
              .onSecondaryContainer,
          icon: Icon(
            passwordToggle ? Icons.visibility_off_rounded : Icons
                .visibility_rounded,
            size: 24,
          ),
        )
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSecondaryContainer)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSecondaryContainer)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSecondaryContainer)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSecondaryContainer)),
        hintText: widget.hint,
        prefixIconConstraints: BoxConstraints(maxHeight: 24, maxWidth: 64),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: widget.prefix != null ? SvgPicture.asset(
            widget.prefix!,
            colorFilter: ColorFilter.mode(
                Theme
                    .of(context)
                    .colorScheme
                    .onSecondaryContainer,
                BlendMode.srcIn),
          ) : null,
        ),
      ),
    );
  }


}
