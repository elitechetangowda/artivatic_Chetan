import 'package:flutter/material.dart';


class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Exercise List')),
      body: _buildListExercise(),
    );
  }

  Widget _buildListExercise() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      
    );
  }

 
}