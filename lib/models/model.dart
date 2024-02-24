import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Technician {
  final int id;
  final String firstName;
  final String lastName;

  Technician(
      {required this.id, required this.firstName, required this.lastName});

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class Workshop {
  final int id;
  final String workshop;
  final DateTime? modifyDate;
  final DateTime registerDate;

  Workshop(
      {required this.id,
      required this.workshop,
      this.modifyDate,
      required this.registerDate});

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'],
      workshop: json['workshop'],
      modifyDate: json['modifyDate'] != null
          ? DateTime.parse(json['modifyDate'])
          : null,
      registerDate: DateTime.parse(json['registerDate']),
    );
  }
}

class Question {
  final int id;
  final String question;

  Question({required this.id, required this.question});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
    );
  }
}

class Answer {
  final int id;
  final String answer;

  Answer({required this.id, required this.answer});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      answer: json['answer'],
    );
  }
}

class Deviation {
  final int id;
  final String
      deviationText; // Asumiendo que tienes un campo de texto para la desviación
  String description;

  Deviation(
      {required this.id, required this.deviationText, this.description = ''});

  factory Deviation.fromJson(Map<String, dynamic> json) {
    return Deviation(
      id: json['id'],
      deviationText: json[
          'deviation'], // Asegúrate de que el nombre de la clave coincida con tu API
      description: json['description'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviation': deviationText,
      'description': description,
    };
  }
}

class Remedial {
  final int id;
  final String action;

  Remedial({
    required this.id,
    required this.action,
  });

  factory Remedial.fromJson(Map<String, dynamic> json) {
    return Remedial(
      id: json['id'],
      action: json['action'],
    );
  }
}

class NewInspectionFormData {
  String? selectedWorkshop;
  String? selectedTechnician;
  String? selectedAnswer;
  String? selectedDeviation;
  String? selectedQuestion;
  String? selectedRemedial;
  String deviationDescription = '';
  String remedialAction = '';

  TextEditingController remedialActionDescriptionController =
      TextEditingController();

  bool isChecked1 = false;
  bool isChecked2 = false;
  TextEditingController descriptionController = TextEditingController();

  List<Technician> technicians =
      []; // se extrae informacion de los datos de la clase Technician

  int? selectedTechnicianId;
  List<Workshop> workshops =
      []; // se extrae informacion de los datos de la clase Workshop

  int? selectedWorkshopId; // ID del taller seleccionado

  List<Question> questions = [];
  int? selectedQuestionId; // ID of the selected question

  List<Answer> answers = [];
  int? selectedAnswerId; // ID of the selected question

  List<Deviation> deviations = [];
  int? selectedDeviationId; // ID of the selected deviation

  List<Remedial> remedials = [];
  int? selectedRemedialId; // ID of the selected deviation
}
