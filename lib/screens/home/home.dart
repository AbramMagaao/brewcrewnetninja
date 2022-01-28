import 'package:brew_crew/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/authservice.dart';

class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        actions: [
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
          ),
        ],
      ),
    );
  }
}
