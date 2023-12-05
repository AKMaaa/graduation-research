import 'package:flutter/material.dart';
// import 'package:flutter_application/src/parts/ui-parts.dart';
import 'package:flutter_application/src/login.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'AI literacy app',
        debugShowCheckedModeBanner: false,
        home: LoginPage());
  }
}

