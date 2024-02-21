import 'package:cmms/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyUserId = 'id';
  static const String _keyIdType = 'id_type';
  static const String _keyIdentification = 'identification';
  static const String _keyFirstName = 'firstName';
  static const String _keyLastName = 'lastName';
  static const String _keyEmail = 'email';
  static const String _keyRoleId = 'role_id';
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';
  static const String _keyToken = 'token';

  static Future<void> saveSession(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_keyUserId, user.id);
    prefs.setString(_keyIdType, user.id_type);
    prefs.setString(_keyIdentification, user.identification);
    prefs.setString(_keyFirstName, user.firstName);
    prefs.setString(_keyLastName, user.lastName);
    prefs.setString(_keyEmail, user.email);
    prefs.setInt(_keyRoleId, user.role_id);
    prefs.setString(_keyUsername, user.username);
    prefs.setString(_keyPassword, user.password);
  }

  static Future<bool> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      prefs.setString(_keyToken, token);
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(_keyToken);

    return token.toString();
  }

  static Future<Map<String, dynamic>?> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt(_keyUserId);
    String? id_type = prefs.getString(_keyIdType);
    String? identification = prefs.getString(_keyIdentification);
    String? firstName = prefs.getString(_keyFirstName);
    String? lastName = prefs.getString(_keyLastName);
    String? email = prefs.getString(_keyEmail);
    int? role = prefs.getInt(_keyRoleId);
    String? username = prefs.getString(_keyUsername);
    String? password = prefs.getString(_keyPassword);

    if (id != null && username != null && role != null) {
      return {
        'id': id,
        'id_type': id_type,
        'identification': identification,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'role': role,
        'username': username,
        'password': password,
      };
    } else {
      return null;
    }
  }

  static Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
