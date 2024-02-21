import 'package:flutter/material.dart';
import 'package:cmms/models/User.dart';
import 'package:cmms/screens/LoginPage.dart';

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? sessionData;

  
  const MyApp({super.key, this.sessionData});

  @override
  Widget build(BuildContext context) {
    if (sessionData != null) {
      User user = User.fromJson2(sessionData);
      print("from MyApp");
      print(user.runtimeType);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
