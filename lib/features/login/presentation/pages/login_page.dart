import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/core/validator/email_validator.dart';
import 'package:chat_app/core/validator/password_validation.dart';
import 'package:chat_app/core/widgets/custom_password_field.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:chat_app/features/login/presentation/riverpod/login_controller.dart';
import 'package:chat_app/features/login/presentation/widgets/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();
  String? emailFieldError, passFieldError;
  bool enableCheckbox = false;

  ({bool isEmailEnable, bool isPassEnable}) buttonNotifier = (
    isEmailEnable: false,
    isPassEnable: false,
  );

  @override
  void initState() {
    super.initState();
    emailCtr.addListener(() {
      _enableButtonState();
    });
    passCtr.addListener(() {
      _enableButtonState();
    });
  }

  void _enableButtonState() {
    setState(() {
      buttonNotifier = (
        isEmailEnable: emailCtr.text.isNotEmpty,
        isPassEnable: passCtr.text.isNotEmpty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    ref.listen(loginControllerProvider, (_, next) {
      if (next.value?.$1 == null && next.value?.$2 == null) {
        const CircularProgressIndicator();
      } else if (next.value?.$1 != null && next.value?.$2 == null) {
        context.push(MyRoutes.landingPage);
      } else if (next.value?.$1 == null && next.value?.$2 != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error!'),
              content: Text('${next.value?.$2}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Hi, Welcome to ',
                          style: Theme.of(context).textTheme.headlineLarge,
                          children: [
                            TextSpan(
                              text: 'Barta!',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Enter your credential to login',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                CustomTextField(
                  image: Assets.images.mail.provider(),
                  text: 'Enter your email',
                  controller: emailCtr,
                  fieldError: emailFieldError,
                ),
                const SizedBox(height: 15),
                CustomPassField(
                  prefixIcon: Assets.images.padlock.provider(),
                  hintText: 'Enter your password',
                  controller: passCtr,
                  fieldError: passFieldError,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: Checkbox(
                        value: enableCheckbox,
                        onChanged: (newValue) {
                          setState(() {
                            enableCheckbox = newValue!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        fillColor: (enableCheckbox)
                            ? WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.primary,
                              )
                            : WidgetStatePropertyAll(
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.5),
                              ),
                        side: (enableCheckbox)
                            ? BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                width: 2,
                              )
                            : BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          enableCheckbox = !enableCheckbox;
                        });
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: 'Remember me',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 45),
                ElevatedButton(
                  style: (buttonNotifier.isEmailEnable &
                          buttonNotifier.isPassEnable)
                      ? ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.surface,
                          ),
                        )
                      : null,
                  onPressed: (buttonNotifier.isEmailEnable &
                          buttonNotifier.isPassEnable)
                      ? () {
                          final emailValidator = EmailValidation();
                          final passValidator = PasswordValidation();
                          bool isEmailValid =
                              emailValidator.validateEmail(emailCtr.text);
                          bool isPassValid =
                              passValidator.validatePassword(passCtr.text);

                          setState(() {
                            emailFieldError =
                                (isEmailValid) ? null : 'Invalid email';
                            passFieldError = (isPassValid)
                                ? null
                                : 'Password length must be greater than 5';
                          });

                          if (isEmailValid && isPassValid) {
                            ref.read(loginControllerProvider.notifier).login(
                                  UserData(
                                    email: emailCtr.text,
                                    pass: passCtr.text,
                                  ),
                                );
                          }
                        }
                      : null,
                  child: (state.isLoading)
                      ? CircularProgressIndicator(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                        )
                      : const Text('Login'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go(MyRoutes.signUp);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: 'Sign up',
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
                      onTap: () {
                        context.push(MyRoutes.forgotPassword);
                      },
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
                const SizedBox(height: 180),
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
                ElevatedButton(
                  style: const ButtonStyle(
                    elevation: WidgetStatePropertyAll(0),
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
