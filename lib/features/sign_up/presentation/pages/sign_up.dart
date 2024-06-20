import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/features/sign_up/presentation/widgets/custom_password_field.dart';
import 'package:chat_app/features/sign_up/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Create an account',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 15),
                      const Text('Connect with your friend today!'),
                    ],
                  ),
                ),
                const SizedBox(height: 90),
                CustomTextField(
                  image: Assets.images.user.provider(),
                  text: 'User name',
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  image: Assets.images.mail.provider(),
                  text: 'email',
                ),
                const SizedBox(height: 15),
                CustomPasswordField(
                  prefixIcon: Assets.images.padlock.provider(),
                  hintText: 'password',
                ),
                const SizedBox(height: 15),
                CustomPasswordField(
                  prefixIcon: Assets.images.padlock.provider(),
                  hintText: 'Confirm password',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
