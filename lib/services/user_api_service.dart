import 'package:cmms/models/User.dart';
import 'package:cmms/services/session_manager.dart';
import 'dart:convert' as convert;
import 'Http.dart';

class UserApiServices {
  final Http http = Http();

  Future<Map<String, dynamic>> login(dynamic data) async {
  final response = await http.login('/api/user/login', data);
  final responseData = convert.json.decode(response.body);
  
  // Agregar el estado de la respuesta al JSON
  responseData['status'] = response.statusCode;

  return responseData;
}

  Future<User> getUser(String username) async {
    String? token = await SessionManager.getToken();
    final response = await http.get('/api/user/$username', token);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = convert.jsonDecode(response.body);
      return User.fromJson(jsonResponse as Map<String, dynamic>?);
    } else {
      throw Exception('Failed to load users');
    }
  }

/*
  Future<List<User>> getAllUsers() async {
    final response = await http.get('/api/user/all');
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> saveUser(User user) async {
    final response = await http.post('/api/user/save', user.toJson());
    if (response.statusCode != 201) {
      throw Exception('Failed to save user');
    }
  }

  Future<void> updateUser(int userId, User updatedUser) async {
    final response =
        await http.put('/api/user/update', updatedUser.toJson());
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int userId) async {
    final response = await http.delete('/api/user/$userId');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
  */
}
