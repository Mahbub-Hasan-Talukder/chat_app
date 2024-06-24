import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isDarkMode = false;
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
              const SizedBox(height: 80),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Assets.images.profile.image(
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.shadow,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Assets.images.camera.image(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                '${auth.currentUser?.displayName}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                '${auth.currentUser?.email}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: 'Light mode ',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: true,
                      onChanged: (isOn) {},
                    ),
                  ),
                ],
              ),
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
                    context.go(MyRoutes.login);
                  } on FirebaseAuthException catch (e) {
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
                child: Text('Logout'),
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
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
