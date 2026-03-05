import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    title: 'Chat app',
    debugShowCheckedModeBanner: false,
    home: LoginTestscreen(),
  ));
}
