import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/services/authservice.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);
  late final Function toggleView;
  SignIn({ required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 1,
        title: const Text('Sign in to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person),
              label: const Text('Register'),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20.0,),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ), //Email
              const SizedBox(height: 20.0,),
              TextFormField(
                obscureText: true,
                validator: (val) => val!.length <6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ), //Email
              const SizedBox(height: 20.0,),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Could not Sign In with those credentials';
                        });
                      }
                    }
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white,),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                  ),
              ),
              const SizedBox(height: 12,),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14,),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
