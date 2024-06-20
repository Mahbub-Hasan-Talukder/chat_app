import 'dart:ffi';

import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomPasswordField extends StatefulWidget {
  final ImageProvider prefixIcon;
  final String hintText;
  final bool? passwordTextFieldError;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  const CustomPasswordField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.passwordTextFieldError,
    this.onChanged,
    this.controller,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image(
            image: widget.prefixIcon,
            height: 25,
            width: 25,
            opacity: const AlwaysStoppedAnimation<double>(0.5),
          ),
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          icon: const Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}
