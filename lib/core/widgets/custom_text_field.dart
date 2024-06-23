import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final TextEditingController controller;
  final String? fieldError;

  const CustomTextField({
    super.key,
    required this.image,
    required this.text,
    required this.controller,
    this.fieldError,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyLarge,
      controller: controller,
      decoration: InputDecoration(
        errorText: (fieldError != null) ? fieldError : null,
        errorStyle: const TextStyle(
          color: Color(0XFFE31609),
        ),
        hintText: text,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image(
            image: image,
            height: 25,
            width: 25,
            opacity: const AlwaysStoppedAnimation<double>(0.5),
          ),
        ),
      ),
    );
  }
}
