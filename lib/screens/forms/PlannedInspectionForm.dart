import 'package:cmms/models/Question.dart';
import 'package:flutter/material.dart';

class PlannedInspectionForm extends StatefulWidget {
  final List<Question> questions;

  const PlannedInspectionForm({required this.questions});

  @override
  _PlannedInspectionState createState() => _PlannedInspectionState();
}

class _PlannedInspectionState extends State<PlannedInspectionForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _answers = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (var i = 0; i < widget.questions.length; i++)
              TextFormField(
                decoration: InputDecoration(labelText: widget.questions[i].question),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill the input field';
                  }
                  return null;
                },
                onSaved: (value) {
                  _answers[widget.questions[i].question] = value!;
                },
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Aquí puedes enviar las respuestas del formulario
                  print(_answers);
                }
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
