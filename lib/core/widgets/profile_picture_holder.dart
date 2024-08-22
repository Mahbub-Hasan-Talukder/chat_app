import 'package:flutter/material.dart';

class ProfilePictureHolder extends StatelessWidget {
  const ProfilePictureHolder({
    super.key,
    required this.userData,
    required this.rad,
  });

  final Map<String, dynamic> userData;
  final double rad;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: rad,
          width: rad,
          padding: EdgeInsets.all(rad * .04),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userData['photoUrl'],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 2,
          child: Container(
            height: rad * .2,
            width: rad * .2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: (userData['isActive'])
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
