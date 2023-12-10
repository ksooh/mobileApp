// LoginPage.dart

import 'package:flutter/material.dart';
import '../style.dart';
import 'RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   automaticallyImplyLeading: false, // Hide the back button
      //
      // ),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 100,),
              const Text(
                'MapEasy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Lotte",
                  fontSize: 55,
                  color: AppColor.blue1,
                ),
              ),
              SizedBox(height: 150,),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200], // Set the background color to gray
                  // labelText: 'Email',
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Set the border radius
                    borderSide: BorderSide.none, // Remove the border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.transparent), // Set the border color to transparent
                  ),
                  // You can add more styling options here
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200], // Set the background color to gray
                  // labelText: 'Password',
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  // suffixIcon: Icon(Icons.visibility, color: Colors.grey),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0), // Set the border radius
                    borderSide: BorderSide.none, // Remove the border
                  ),
                  // You can add more styling options here
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final currentUser =
                      await _authentication.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (currentUser.user != null) {
                        _formKey.currentState!.reset();
                        if (!mounted) return;
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.blue1, // Set the desired color here
                  ),
                  child: const Text('Enter')),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('If you did not register, '),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text('Register your email'),
                  ),
                ],
              )
            ],
          )),
    );
  }
}