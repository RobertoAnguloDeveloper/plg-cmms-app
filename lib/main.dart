import 'package:flutter/material.dart';
import 'package:cmms/screens/MyApp.dart';
import 'package:cmms/services/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sessionData = await SessionManager.getSession();

  print(sessionData);

  runApp(MyApp(sessionData: sessionData));
}

class PrecacheImageWidget extends StatelessWidget {
  final Map<String, dynamic>? sessionData;

  const PrecacheImageWidget({Key? key, this.sessionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/login_background.png"), context);

    return MyApp(sessionData: sessionData);
  }
}
