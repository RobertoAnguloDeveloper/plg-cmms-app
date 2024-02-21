import 'package:flutter/material.dart';
import 'package:cmms/screens/LoginPage.dart';
import 'package:cmms/services/session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DrawerMenu extends StatefulWidget {
  final Function(int) onItemTapped;
  final BuildContext parentContext;

  DrawerMenu(
      {Key? key, required this.onItemTapped, required this.parentContext})
      : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String? _userName;
  String? _userEmail;
  bool isDarkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final userData = await SessionManager.getSession();
    if (userData != null) {
      setState(() {
        _userName = userData['firstName'] + ' ' + userData['lastName'];
        _userEmail = userData['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_userName ?? 'Nombre de usuario'),
              accountEmail: Text(_userEmail ?? 'correo@ejemplo.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Color(0xFF39AFC9),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF39AFC9),
              ),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 73, 70, 70)),
              ),
              leading: Icon(
                FontAwesomeIcons.solidUser,
                size: 24,
                color: Color(0xFF39AFC9),
              ),
              onTap: () {},
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Navigation',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 73, 70, 70)),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: Text(
                'New inspections',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 73, 70, 70)),
              ),
              leading: Icon(
                FontAwesomeIcons.fileCircleCheck,
                size: 24,
                color: Color(0xFF39AFC9),
              ),
              onTap: () {
                Navigator.pop(widget.parentContext);
              },
            ),
            ListTile(
              title: Text(
                'All inspections',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 73, 70, 70)),
              ),
              leading: Icon(
                FontAwesomeIcons.list,
                size: 24,
                color: Color(0xFF39AFC9),
              ),
              onTap: () {
                Navigator.pop(widget.parentContext);
              },
            ),
            SizedBox(height: 16),
            Divider(
              color: Colors.grey,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 73, 70, 70)),
              ),
              leading: Icon(
                Icons.logout,
                size: 24,
                color: Color(0xFF39AFC9),
              ),
              onTap: () {
                SessionManager.clearSession();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
