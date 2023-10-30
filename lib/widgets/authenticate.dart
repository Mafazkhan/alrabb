import 'package:alrabb/screens/bottom_screen.dart';
import 'package:alrabb/screens/home_screen.dart';
import 'package:alrabb/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return BottomNavBar();
    } else {
      return const LoginScreen();
    }
  }
}
