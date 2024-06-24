import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPwPage extends ConsumerStatefulWidget {
  const ForgotPwPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends ConsumerState<ForgotPwPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
