import 'package:chat_app/core/service/navigation/routes/routes.dart';
import 'package:chat_app/features/forgot_password/presentation/pages/forgot_pw_page.dart';
import 'package:chat_app/features/login/presentation/pages/login_page.dart';
import 'package:chat_app/features/sign_up/presentation/pages/sign_up_page.dart';
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
        path: MyRoutes.forgotPassword,
        builder: (context, state) => const ForgotPwPage(),
      ),
    ],
  );
}
