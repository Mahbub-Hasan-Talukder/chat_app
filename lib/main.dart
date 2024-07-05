import 'package:chat_app/core/service/navigation/router_config/router_config.dart';
import 'package:chat_app/core/theme/theme.dart';
import 'package:chat_app/core/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  ThemeData? curTheme = ThemeClass.lightTheme;
  @override
  Widget build(BuildContext context) {
    ref.listen(themeProviderProvider, (_, next) {
      if (next.value != null) {
        setState(() {
          curTheme = next.value;
        });
      }
    });
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: curTheme,
      routerConfig: MyRouterConfig.router,
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
    
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Chat App',
//       theme: ThemeClass.theme,
//       routerConfig: MyRouterConfig.router,
//     );
//   }
// }
