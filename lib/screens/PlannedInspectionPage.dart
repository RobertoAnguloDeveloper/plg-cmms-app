import 'package:cmms/models/Question.dart';
import 'package:cmms/screens/forms/PlannedInspectionForm.dart';
import 'package:cmms/services/question_api_service.dart';
import 'package:flutter/material.dart';

class PlannedInspectionPage extends StatelessWidget {
  const PlannedInspectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    //List<Question> questions = QuestionApiServices().getAllQuestions();
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Planned Inspection Form',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.blue,
            centerTitle: true,
          ),
          body: Text('Planned Inspection Form',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )) //PlannedInspectionForm(questions: questions),
          ),
    );
  }
}
