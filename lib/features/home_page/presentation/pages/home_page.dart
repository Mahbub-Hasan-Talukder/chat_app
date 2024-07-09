import 'package:chat_app/features/home_page/presentation/widgets/connected_user_list.dart';
import 'package:chat_app/features/home_page/presentation/widgets/searchDelegate.dart';
import 'package:chat_app/features/my_drawer/presentation/pages/my_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isDarkMode = false;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.surface,
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(
                text: 'Baarta',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              showSearch(context: context, delegate: UserSearchDelegate());
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ConnectedUserList(),
        ),
      ),
    );
  }
}
