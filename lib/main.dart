import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/screens/Login_testscreen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: 'Chat app',
    debugShowCheckedModeBanner: false,
    home: FirebaseAuth.instance.currentUser == null
        ? const LoginTestscreen()
        : const ChatScreen(),
  ));
}
