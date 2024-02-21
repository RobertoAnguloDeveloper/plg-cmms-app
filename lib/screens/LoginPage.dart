import 'package:cmms/screens/PlannedInspectionPage.dart';
import 'package:flutter/material.dart';
import 'package:cmms/services/session_manager.dart';
import 'package:cmms/services/user_api_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _obscurePassword = true;
  String? _usernameError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9F0F6),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/login_background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xFF295075),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: FormBuilderTextField(
                      name: 'username',
                      controller: _usernameController,
                      focusNode: _usernameFocus,
                      decoration: InputDecoration(
                        labelText: "Username",
                        errorText: _usernameError,
                        labelStyle:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xAAE0E0E0),
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _usernameError = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: FormBuilderTextField(
                      name: 'password',
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      decoration: InputDecoration(
                        labelText: "Password",
                        errorText: _passwordError,
                        labelStyle:
                            TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xAAE0E0E0),
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: _obscurePassword,
                      onChanged: (value) {
                        setState(() {
                          _passwordError = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _usernameError =
                                _validateUsername(_usernameController.text);
                            _passwordError =
                                _validatePassword(_passwordController.text);
                          });

                          if (_usernameError == null &&
                              _passwordError == null) {
                            final userApiService = UserApiServices();

                            final enteredUsername = _usernameController.text;
                            final enteredPassword = _passwordController.text;

                            final Map<String, dynamic> userCredentials = {
                              'username': enteredUsername,
                              'password': enteredPassword,
                            };

                            final response =
                                await userApiService.login(userCredentials);

                            if (response != null && response['status'] == 200) {
                              final token = response['token'];
                              SessionManager.setToken(token);
                              showToast(context, 'Login successful');
                              String? tokenString =
                                  await SessionManager.getToken();
                              print(tokenString);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlannedInspectionPage()),
                              );
                            } else {
                              showToast(context, 'Login failed');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, backgroundColor: const Color(0xFF295075), shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.login, size: 24.0, color: Colors.white),
                            SizedBox(width: 8.0),
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
}

void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1), // Duración del Toast
    ),
  );
}
