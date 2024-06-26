import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:chat_app/features/forgot_password/domain/entities/forgot_pass_entity.dart';
import 'package:chat_app/features/forgot_password/presentation/riverpod/forgot_pass_controller.dart';
import 'package:chat_app/features/forgot_password/presentation/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPwPage extends ConsumerStatefulWidget {
  const ForgotPwPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends ConsumerState<ForgotPwPage> {
  TextEditingController emailCtr = TextEditingController();
  bool emailFieldEnable = false;
  bool emailFieldError = false;

  @override
  void initState() {
    super.initState();
    emailCtr.addListener(() {
      setState(() {
        emailFieldEnable = emailCtr.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    emailCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPassControllerProvider);
    ref.listen(forgotPassControllerProvider, (_, next) {
      if (next.value?.$1 == null && next.value?.$2 == null) {
        const CircularProgressIndicator();
      } else if (next.value?.$1 != null && next.value?.$2 == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: Text('${next.value?.$1?.status}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push(MyRoutes.login);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
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
                        text: 'Forgot ',
                        style: Theme.of(context).textTheme.headlineLarge,
                        children: [
                          TextSpan(
                            text: 'Password!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Enter your email to get reset password link',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 150),
                    CustomTextField(
                      image: Assets.images.mail.provider(),
                      text: 'enter your email',
                      controller: emailCtr,
                    ),
                    const SizedBox(height: 15),
                    MyElevatedButton(
                      emailFieldEnable: emailFieldEnable,
                      ref: ref,
                      emailCtr: emailCtr,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
