import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/widgets/custom_password_field.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();
  TextEditingController confirmPassCtr = TextEditingController();

  ({
    bool isNameEnable,
    bool isEmailEnable,
    bool isPassEnable,
    bool isConfirmPass,
  }) buttonNotifier = (
    isNameEnable: false,
    isEmailEnable: false,
    isPassEnable: false,
    isConfirmPass: false,
  );

  @override
  void initState() {
    super.initState();
    nameCtr.addListener(() {
      _enableButtonState();
    });
    emailCtr.addListener(() {
      _enableButtonState();
    });
    passCtr.addListener(() {
      _enableButtonState();
    });
    confirmPassCtr.addListener(() {
      _enableButtonState();
    });
  }

  void _enableButtonState() {
    setState(() {
      buttonNotifier = (
        isNameEnable: nameCtr.text.isNotEmpty,
        isEmailEnable: emailCtr.text.isNotEmpty,
        isPassEnable: passCtr.text.isNotEmpty,
        isConfirmPass: confirmPassCtr.text.isNotEmpty,
      );
    });
    print(buttonNotifier);
  }

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
                  controller: nameCtr,
                  image: Assets.images.user.provider(),
                  text: 'User name',
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: emailCtr,
                  image: Assets.images.mail.provider(),
                  text: 'email',
                ),
                const SizedBox(height: 15),
                CustomPassField(
                  controller: passCtr,
                  prefixIcon: Assets.images.padlock.provider(),
                  hintText: 'password',
                ),
                const SizedBox(height: 15),
                CustomPassField(
                  controller: confirmPassCtr,
                  prefixIcon: Assets.images.padlock.provider(),
                  hintText: 'Confirm password',
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: (buttonNotifier.isNameEnable &
                          buttonNotifier.isEmailEnable &
                          buttonNotifier.isPassEnable &
                          buttonNotifier.isConfirmPass)
                      ? ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.surface,
                          ),
                        )
                      : null,
                  onPressed: () {},
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: RichText(
                        text: TextSpan(
                            text: 'Forgot ',
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: 'password',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 1,
                      width: 135,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(color: Color(0xFF797C7B)),
                    ),
                    Container(
                      height: 1,
                      width: 135,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextButton(
                  style: const ButtonStyle(
                    side: WidgetStatePropertyAll<BorderSide>(
                      BorderSide(color: Colors.orange, width: 2),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.googleLogo.image(
                        height: 25,
                        width: 25,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Sign in with google',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
