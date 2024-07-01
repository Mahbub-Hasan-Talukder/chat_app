import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/features/chat_page/presentation/pages/chat_page.dart';
import 'package:chat_app/features/landing_page/presentation/pages/landing_page.dart';
import 'package:chat_app/features/login/presentation/pages/login_page.dart';
import 'package:chat_app/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouterConfig {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: MyRoutes.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: MyRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: MyRoutes.landingPage,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: MyRoutes.chatPage,
        builder: (context, state) {
          final Map<String, dynamic> extras =
              state.extra as Map<String, dynamic>;
          return ChatPage(
            uid: extras['uid'],
            name: extras['name'],
            isActive: extras['isActive'],
            photoUrl: extras['photoUrl'],
          );
        },
      ),
    ],
  );
}
