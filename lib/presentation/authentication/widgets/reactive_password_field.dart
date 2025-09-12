import "package:flutter/material.dart";
import "package:reactive_forms/reactive_forms.dart";

class ReactivePasswordField extends StatefulWidget {
  const ReactivePasswordField({
    super.key,
    required this.formControlName,
    this.labelText,
    this.validationMessages,
    this.cursorColor,
  });

  final String formControlName;
  final String? labelText;
  final Map<String, String Function(Object)>? validationMessages;
  final Color? cursorColor;

  @override
  State<ReactivePasswordField> createState() => _ReactivePasswordFieldState();
}

class _ReactivePasswordFieldState extends State<ReactivePasswordField> {
  bool _obscureText = true;

  void _toggleObscure() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: widget.formControlName,
      obscureText: _obscureText,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorColor,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: _toggleObscure,
        ),
      ),
      validationMessages: widget.validationMessages,
    );
  }
}
