import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(
                text: 'Barta',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surface,
                  ),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    print('pressed');
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error!'),
                          content: Text(e.toString()),
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
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Column(
            children: [
              Center(
                child: Text('Home'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
