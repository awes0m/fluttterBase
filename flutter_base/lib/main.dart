import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/authentication.dart';
import 'package:flutter_base/ui/home_screen.dart';

import 'ui/add_coin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp();
  } else {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          // connect for web to firebase
          options: const FirebaseOptions(
              apiKey: "AIzaSyD_JNvQkewUv__OFOdBQPKxo47Zq51fsy4",
              authDomain: "cryptofire-130d9.firebaseapp.com",
              projectId: "cryptofire-130d9",
              storageBucket: "cryptofire-130d9.appspot.com",
              messagingSenderId: "914042783929",
              appId: "1:914042783929:web:391e0a40f1b5cf3a16f368",
              measurementId: "G-40352NMTQ4"));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '<: FlutterBase',
      initialRoute: Authentication.routeName,
      routes: {
        Authentication.routeName: (context) => const Authentication(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddCoinScreen.routeName: (context) => const AddCoinScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
