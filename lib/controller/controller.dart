import 'package:flutter/material.dart';
import 'package:cmms/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cmms/services/session_manager.dart';

class NewInspectionFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NewInspectionFormData data;

  NewInspectionFormController({required this.data});

  Future<String> _getToken() async {
    return await SessionManager.getToken() ?? ''; // Obtiene el token actual
  }

  void onWorkshopChanged(String? newValue) {
    data.selectedWorkshop = newValue;
  }

  void onAnswerChanged(String? newValue) {
    data.selectedAnswer = newValue;
  }

  void onDeviationChanged(String? newValue) {
    data.selectedDeviation = newValue;
  }

  void onRemedialChanged(String? newValue) {
    data.selectedRemedial = newValue;
  }

  Future<void> fetchWorkshops() async {
    String authToken = await _getToken(); // Obtiene el token actualizado

    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/workshop/all'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> workshopsJson = json.decode(response.body);
      data.workshops =
          workshopsJson.map((json) => Workshop.fromJson(json)).toList();
    } else {
      // Manejo de errores workshop
    }
  }

  Future<void> fetchTechnicians() async {
    String authToken = await _getToken(); // Obtiene el token actualizado

    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/user/technicians'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> techniciansJson = json.decode(response.body);
      data.technicians =
          techniciansJson.map((json) => Technician.fromJson(json)).toList();
    } else {
      // Manejo de errores en technician
    }
  }

  Future<void> fetchQuestions() async {
    String authToken = await _getToken(); // Obtiene el token actualizado

    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/question/all'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> questionsJson = json.decode(response.body);
      data.questions =
          questionsJson.map((json) => Question.fromJson(json)).toList();
    } else {
      // Manejo de errores en questions
    }
  }

  Future<void> fetchAnswers() async {
    String authToken = await _getToken(); // Obtiene el token actualizado

    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/answer/all'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> answersJson = json.decode(response.body);
      data.answers = answersJson.map((json) => Answer.fromJson(json)).toList();
    } else {
      // Manejo de errores en answers
    }
  }

  Future<void> fetchDeviations() async {
    String authToken = await _getToken(); // Obtiene el token actualizado

    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/deviation/all'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> deviationsJson = json.decode(response.body);
      data.deviations =
          deviationsJson.map((json) => Deviation.fromJson(json)).toList();
    } else {
      // Manejo de errores en deviations
    }
  }

  Future<void> fetchRemedialActions() async {
    try {
      String authToken = await _getToken();

      final response = await http.get(
        Uri.parse('http://3.129.92.139:8080/api/remedialaction/all'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> remedialJson = json.decode(response.body);
        data.remedials =
            remedialJson.map((json) => Remedial.fromJson(json)).toList();
      } else {
        // Handle HTTP errors
        print('Failed to load remedial actions: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any other type of error (network error, parsing error, etc.)
      print('Error fetching remedial actions: $e');
    }
  }

  // para enviar deviation description
  /*Future<void> submitDeviation() async {
    String authToken = await _getToken();
    var deviationPostBody = jsonEncode({
      "deviation": data.selectedDeviation,
      "description": data.descriptionController.text,
    });

    var deviationResponse = await http.post(
      Uri.parse('http://3.129.92.139:8080/api/deviation/save'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: deviationPostBody,
    );

    if (deviationResponse.statusCode == 200) {
      print("Deviation sent successfully: ${deviationResponse.body}");
    } else {
      print("Error sending deviation description: ${deviationResponse.statusCode}");
    }
  }  */

Future<void> submitDeviation() async {
  if (data.selectedDeviationId != null) {
    // Encuentra la desviación seleccionada basada en el ID.
    Deviation selectedDeviation = data.deviations.firstWhere(
      (deviation) => deviation.id == data.selectedDeviationId,
      orElse: () => Deviation(id: 0, deviationText: '', description: ''),
    );

    String authToken = await _getToken();
    var deviationPostBody = jsonEncode({
      "deviation": selectedDeviation.deviationText, // Asegúrate de que envías el texto de la desviación.
      "description": data.descriptionController.text,
    });

    var deviationResponse = await http.post(
      Uri.parse('http://3.129.92.139:8080/api/deviation/save'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: deviationPostBody,
    );

    if (deviationResponse.statusCode == 200) {
      print("Deviation sent successfully: ${deviationResponse.body}");
    } else {
      print("Error sending deviation description: ${deviationResponse.statusCode}");
    }
  } else {
    print("No deviation selected.");
  }
}



Future<void> submitRemedialAction() async {
  if (data.selectedRemedialId != null) {
    // Encuentra la acción de remediación seleccionada basada en el ID.
    Remedial selectedRemedial = data.remedials.firstWhere(
      (remedial) => remedial.id == data.selectedRemedialId,
      orElse: () => Remedial(id: 0, action: ''),
    );

    String authToken = await _getToken();
    var remedialActionPostBody = jsonEncode({
      "action": selectedRemedial.action, // Asegúrate de que envías el texto de la acción.
      "description": data.remedialActionDescriptionController.text,
    });

    var remedialActionResponse = await http.post(
      Uri.parse('http://3.129.92.139:8080/api/remedialaction/save'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: remedialActionPostBody,
    );

    if (remedialActionResponse.statusCode == 200) {
      print("Remedial action sent successfully: ${remedialActionResponse.body}");
    } else {
      print("Error sending remedial action: ${remedialActionResponse.statusCode}");
    }
  } else {
    print("No remedial action selected.");
  }
}



//codigo con el submit funcional enviando  description
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {

      // se omite el metodo que esta al enviar submit form para encontrar la estructura correcta 
     await submitDeviation(); 
     await submitRemedialAction();
      var postBody = jsonEncode({
        "questionId": data.selectedQuestionId ?? 0,
        "workshopId": data.selectedWorkshopId ?? 0,
        "answerId": data.selectedAnswerId ?? 0,
        "remedialId": data.selectedRemedialId ?? 0,
        "deviationId": data.selectedDeviationId ?? 0,
        "userId": data.selectedTechnicianId ?? 0,
        "description": data.deviationDescription,
      });

      String authToken = await _getToken(); // Obtiene el token actualizado

      final response = await http.post(
        Uri.parse('http://3.129.92.139:8080/api/check/save'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: postBody,
      );

      if (response.statusCode == 200) {
        print("Envío exitoso: ${response.body}");
      } else {
        print("Fallo en el envío: ${response.statusCode} - ${response.body}");
      }
    }
  }

  // Asegúrate de que el modelo NewInspectionFormData tenga un campo para la descripción de la desviación
// y que esté vinculado a un TextEditingController en tu formulario.

/*
Future<void> submitForm() async {
  if (formKey.currentState!.validate()) {
    String authToken = await _getToken();

    // Construye el cuerpo de la solicitud para la desviación
    var deviationPostBody = jsonEncode({
      "deviation": data.selectedDeviation,
      "description": data.descriptionController.text,
    });

    // Realiza la petición POST para la desviación
    var deviationResponse = await http.post(
      Uri.parse('http://3.129.92.139:8080/api/deviation/save'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: deviationPostBody,
    );

    if (deviationResponse.statusCode == 200) {
      var deviationData = jsonDecode(deviationResponse.body);
      int deviationId = deviationData['id'];

      // Construye el cuerpo de la solicitud para el chequeo
      var checkPostBody = jsonEncode({
        "questionId": data.selectedQuestionId ?? 0,
        "workshopId": data.selectedWorkshopId ?? 0,
        "answerId": data.selectedAnswerId ?? 0,
        "remedialId": data.selectedRemedialId ?? 0,
        "deviationId": deviationId,
        "userId": data.selectedTechnicianId ?? 0,
      });

      // Realiza la petición POST para el chequeo
      var checkResponse = await http.post(
        Uri.parse('http://3.129.92.139:8080/api/check/save'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: checkPostBody,
      );

      if (checkResponse.statusCode == 200) {
        print("Chequeo enviado exitosamente: ${checkResponse.body}");
      } else {
        print("Error al enviar el chequeo: ${checkResponse.statusCode}");
      }
    } else {
      print("Error al enviar la desviación: ${deviationResponse.statusCode}");
    }
  }
}

*/

/*
Future<void> submitForm() async {
  if (formKey.currentState!.validate()) {
    // Recupera el token de autenticación
    String authToken = await _getToken();

    // Construye el cuerpo de la solicitud para la desviación
    var deviationPostBody = jsonEncode({
      "deviation": data.selectedDeviation,
      "description": data.descriptionController.text,
    });

    // Realiza la petición POST para la desviación
    var deviationResponse = await http.post(
      Uri.parse('http://3.129.92.139:8080/api/deviation/save'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: deviationPostBody,
    );

    if (deviationResponse.statusCode == 200) {
      // Opcionalmente, procesa la respuesta para obtener el ID de la desviación creada
      var deviationData = jsonDecode(deviationResponse.body);
      int deviationId = deviationData['id'];

      // Construye el cuerpo de la solicitud para el chequeo
      var checkPostBody = jsonEncode({
        "questionId": data.selectedQuestionId ?? 0,
        "workshopId": data.selectedWorkshopId ?? 0,
        "answerId": data.selectedAnswerId ?? 0,
        "remedialId": data.selectedRemedialId ?? 0,
        "deviationId": deviationId,
        "userId": data.selectedTechnicianId ?? 0,
        // Aquí puedes agregar cualquier otro dato necesario para el chequeo
      });

      // Realiza la petición POST para el chequeo
      var checkResponse = await http.post(
        Uri.parse('http://3.129.92.139:8080/api/check/save'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: checkPostBody,
      );

      if (checkResponse.statusCode == 200) {
        // El chequeo fue exitoso
        print("Chequeo enviado exitosamente: ${checkResponse.body}");
      } else {
        // Manejo de error para la petición del chequeo
        print("Error al enviar el chequeo: ${checkResponse.statusCode}");
      }
    } else {
      // Manejo de error para la petición de desviación
      print("Error al enviar la desviación: ${deviationResponse.statusCode}");
    }
  }
}

*/
  // ... Aquí puedes agregar cualquier otro método necesario para tu clase ...
}
