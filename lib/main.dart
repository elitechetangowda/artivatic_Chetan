import 'package:artivatic_profiency_exercise/pages/exercise_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercise List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ExercisePage(),//navigate to Exercise page
    );
  }
}
