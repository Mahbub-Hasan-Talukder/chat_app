import 'dart:io';

import 'package:chat_app/core/gen/assets.gen.dart';
import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/core/utils/utils.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:chat_app/features/landing_page/presentation/widgets/list_tile.dart';
import 'package:chat_app/features/landing_page/presentation/widgets/my_drawer.dart';
import 'package:chat_app/features/landing_page/presentation/widgets/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = true;
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: UserSearchDelegate());
            },
          ),
        ],
      ),
      drawer: MyDrawer(isActive: isActive, auth: auth),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(),
        ),
      ),
    );
  }
}

class UserSearchDelegate extends SearchDelegate<MyUser> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Enter a name to search'));
    }
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return StreamBuilder<List<MyUser>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => MyUser.fromFirestore(doc))
              .toList()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No users found'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            MyUser user = snapshot.data![index];
            return ListTile(
              onTap: () {
                // -->
              },
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          },
        );
      },
    );
  }
}
