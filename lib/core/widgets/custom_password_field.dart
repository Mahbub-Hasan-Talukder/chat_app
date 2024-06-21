import 'package:flutter/material.dart';

class CustomPassField extends StatefulWidget {
  final ImageProvider prefixIcon;
  final String hintText;
  final bool? passTextFieldError;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  const CustomPassField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.passTextFieldError,
    this.onChanged,
    required this.controller,
  });

  @override
  State<CustomPassField> createState() => _CustomPassFieldState();
}

class _CustomPassFieldState extends State<CustomPassField> {
  bool isVisibilityOn = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !isVisibilityOn,
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
          padding: const EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              isVisibilityOn = !isVisibilityOn;
            });
          },
          icon: Icon(
            (isVisibilityOn)
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
      ),
    );
  }
}
