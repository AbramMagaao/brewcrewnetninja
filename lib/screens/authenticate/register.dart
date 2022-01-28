import 'package:flutter/material.dart';
import 'package:brew_crew/services/authservice.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);
  late final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 1,
        title: const Text('Sign up to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(Icons.person),
            label: const Text('Sign In'),
            style: TextButton.styleFrom(
              primary: Colors.brown[800],
            ),
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
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              const SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length <6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              const SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'please supply a valid email';
                        loading = false;
                      });
                    }
                  }
                },
                child: const Text(
                  'Register',
                  style: const TextStyle(color: Colors.white,),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown[800],
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
