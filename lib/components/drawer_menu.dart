import 'package:cmms/models/model.dart';
import 'package:flutter/material.dart';
import 'package:cmms/screens/LoginPage.dart';
import 'package:cmms/services/session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cmms/screens/HomePage.dart';
import 'package:cmms/screens/PlannedInspectionPage.dart';
import '../controller/controller.dart';

class DrawerMenu extends StatefulWidget {
  final Function(int) onItemTapped;
  final BuildContext parentContext;

  DrawerMenu(
      {Key? key, required this.onItemTapped, required this.parentContext})
      : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();


}

  NewInspectionFormData formData = NewInspectionFormData();
  NewInspectionFormController formController = NewInspectionFormController(data: formData);


class _DrawerMenuState extends State<DrawerMenu> {
  String? _userName;
  String? _userEmail;
  bool isDarkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    //  _loadUserData();
  }

/*
  void _loadUserData() async {
    final userData = await SessionManager.getSession();
    if (userData != null) {
      setState(() {
        _userName = userData['firstName'] + ' ' + userData['lastName'];
        _userEmail = userData['email'];
      });
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_userName ?? 'Username'),
              accountEmail: Text(_userEmail ?? 'email@gmail.com'),
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
                'Home',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 73, 70, 70)),
              ),
              leading: Icon(
                FontAwesomeIcons.home,
                size: 24,
                color: Color(0xFF39AFC9),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlannedInspectionPage(
              controller: formController,
              data: formData,
            ),
          ),
        );
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
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

