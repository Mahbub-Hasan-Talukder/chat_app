import 'package:chat_app/features/forgot_password/presentation/riverpod/forgot_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.emailFieldEnable,
    required this.ref,
    required this.emailCtr,
  });

  final bool emailFieldEnable;
  final WidgetRef ref;
  final TextEditingController emailCtr;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (emailFieldEnable)
          ? () {
              ref
                  .read(forgotPassControllerProvider.notifier)
                  .forgotPass(email: emailCtr.text);
            }
          : null,
      style: (emailFieldEnable)
          ? ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
              foregroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.surface,
              ),
            )
          : null,
      child: const Text('Submit'),
    );
  }
}
