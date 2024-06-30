import 'dart:io';
import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/features/my_drawer/presentation/riverpod/my_drawer_controller.dart';
import 'package:chat_app/features/my_drawer/presentation/riverpod/update_image_controller.dart';
import 'package:chat_app/features/my_drawer/presentation/riverpod/update_status_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  User? user;
  String? imageUrl;
  bool isActive = true;
  bool isProfileLoading = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? photoLink =
      'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg';

  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(myDrawerControllerProvider.notifier).myDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myDrawerControllerProvider);
    ref.listen(myDrawerControllerProvider, (_, next) {
      if (next.value?.$1 != null && next.value?.$2 == null) {
        setState(() {
          isProfileLoading = false;
          photoLink = (next.value?.$1?.userData.photoUrl)!;
          isActive = (next.value?.$1?.userData.isActive)!;
        });
      } else {
        print(next.value?.$2);
      }
    });

    ref.listen(updateImageControllerProvider, (_, next) {
      if (next.value?.$1 != null) {
        setState(() {
          photoLink = next.value?.$1!.userData.photoUrl;
        });
      } else {
        print(next.value?.$2);
      }
    });

    ref.listen(updateStatusControllerProvider, (_, next) {
      if (next.value?.$1 != null) {
        setState(() {
          isActive = (next.value?.$1!.userData.isActive)!;
        });
      } else {
        print(next.value?.$2);
      }
    });

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: (isProfileLoading)
                      ? const CircularProgressIndicator()
                      : CircleAvatar(
                          backgroundImage: NetworkImage(photoLink!),
                          radius: 20,
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
                      onPressed: () async {
                        onProfileTapped();
                      },
                      icon: const Icon(Icons.add_a_photo_outlined),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: (isActive)
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              '${auth.currentUser?.displayName}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '${auth.currentUser?.email}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: 'Active status ',
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
                    value: isActive,
                    onChanged: (isOn) {
                      setState(() {
                        isActive = isOn;
                      });
                      ref
                          .read(updateStatusControllerProvider.notifier)
                          .updateStatus(status: isActive);
                    },
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
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void onProfileTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      print('Image not selected');
      return null;
    }
    ref.read(updateImageControllerProvider.notifier).updateImage(
          image: image,
        );
  }
}
