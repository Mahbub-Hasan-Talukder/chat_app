import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  final ImageProvider image;
  final String text;
  const CustomTextField({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyLarge,
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
    ;
  }
}
