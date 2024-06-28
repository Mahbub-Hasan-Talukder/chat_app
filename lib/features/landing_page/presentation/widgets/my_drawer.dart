import 'dart:io';
import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class MyDrawer extends StatefulWidget {
  bool isActive;
  FirebaseAuth auth;
  MyDrawer({
    super.key,
    required this.isActive,
    required this.auth,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User? user;
  String? imageUrl;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? photoLink =
      'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg';

  @override
  void initState() {
    super.initState();
    user = widget.auth.currentUser;
    print('in init: ${auth.currentUser?.photoURL}');
    photoLink = (auth.currentUser?.photoURL == null)
        ? Assets.images.emptyPerson.path
        : auth.currentUser?.photoURL;
  }

  @override
  Widget build(BuildContext context) {
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
                  child: CircleAvatar(
                    backgroundImage: (photoLink == null)
                        ? Assets.images.emptyPerson.provider()
                        : NetworkImage(photoLink!),
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
                        final imageUrl = await onProfileTapped();
                        if (imageUrl != null) {
                          setState(() {
                            photoLink = imageUrl;
                          });
                        } else {
                          print("image didn't load");
                        }
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
                      color: (widget.isActive)
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              '${widget.auth.currentUser?.displayName}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '${widget.auth.currentUser?.email}',
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
                    value: widget.isActive,
                    onChanged: (isOn) {
                      setState(() {
                        widget.isActive = isOn;
                      });
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
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> onProfileTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      print('Image not selected');
      return null;
    }

    try {
      String uniqFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child((user?.uid)!);
      Reference referenceImageToUpload =
          referenceDirImages.child('images/$uniqFileName');
      final uploadTask = await referenceImageToUpload.putFile(File(image.path));
      final imageLink = await uploadTask.ref.getDownloadURL();
      user?.updatePhotoURL(imageLink);
      user?.reload;
      user = auth.currentUser;
      print(user?.photoURL);
      return imageLink;
    } on FirebaseException catch (e) {
      debugPrint('here ' + e.toString());
    }
  }
}
