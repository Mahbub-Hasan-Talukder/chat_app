import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/core/utils/user_data.dart';
import 'package:chat_app/features/landing_page/presentation/widgets/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserSearchDelegate extends SearchDelegate<MyUser> {
  // @override
  // // TODO: implement searchFieldStyle
  // TextStyle? get searchFieldStyle => TextStyle(color: Theme.of(context).colorScheme.secondary);

  @override
  Widget? buildFlexibleSpace(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.shadow,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  // @override
  // PreferredSizeWidget? buildBottom(BuildContext context) {
  //   return PreferredSize(
  //     preferredSize: Size.fromHeight(400),
  //     child: Container(),
  //   );
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Enter a name to search'));
    }
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return StreamBuilder<List<UserData>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query.toUpperCase())
          .where('name', isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => UserData.fromFirestore(doc))
              .toList()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final user = snapshot.data![index];
            return ListTile(
              onTap: () {
                context.push(MyRoutes.chatPage, extra: {
                  'receiverUid': user.uid,
                  'receiverName': user.name,
                  'receiverIsActive': user.isActive,
                  'receiverPhotoUrl': user.photoUrl,
                });
              },
              title: Text(user.name!),
              subtitle: Text(user.email!),
            );
          },
        );
      },
    );
  }
}
