import 'package:flutter/material.dart';
import 'package:practical_1/UI/ProfileView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade600),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            color: Colors.blueGrey,
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Your Profile'),
            backgroundColor: Colors.blueGrey,
          ),
          body: const SafeArea(
          child: ProfileViewStatefulWidget(),
          )
        )
    );
  }
}

