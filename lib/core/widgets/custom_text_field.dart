import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final TextEditingController controller;
  const CustomTextField({super.key, required this.image, required this.text, required this.controller,});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyLarge,
      controller: controller,
      decoration: InputDecoration(
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
