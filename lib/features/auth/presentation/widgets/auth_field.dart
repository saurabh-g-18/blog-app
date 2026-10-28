import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscureText,
      obscuringCharacter: '*',
      enableSuggestions: !widget.isObscureText,
      autocorrect: !widget.isObscureText,
      keyboardType: widget.hintText.toLowerCase().contains('email')
          ? TextInputType.emailAddress
          : TextInputType.text,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Field cannot be empty';
        }

        if (widget.hintText.toLowerCase().contains('email') &&
            !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                .hasMatch(value.trim())) {
          return 'Enter a valid email address';
        }

        return null;
      },
    );
  }
}