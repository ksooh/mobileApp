// RegisterPage.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapapp/login/SuccessRegister.dart';
import 'package:mapapp/style.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: AppColor.blue1,
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      Colors.grey[200], // Set the background color to gray
                  // labelText: 'Email',
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Set the border radius
                    borderSide: BorderSide.none, // Remove the border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: Colors
                            .transparent), // Set the border color to transparent
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
                  fillColor:
                      Colors.grey[200], // Set the background color to gray
                  // labelText: 'Password',
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  // suffixIcon: Icon(Icons.visibility, color: Colors.grey),

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Set the border radius
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
                      final newUser =
                          await _authentication.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser.user != null) {
                        _formKey.currentState!.reset();
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SuccessRegisterPage()));
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
                  const Text('If you already registered, '),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'log in with your email',
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}






// // RegisterPage.dart
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mobileapp/login/SuccessRegister.dart';
//
// class RegisterPage extends StatelessWidget {
//   const RegisterPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register'),
//       ),
//       body: const RegisterForm(),
//     );
//   }
// }
//
// class RegisterForm extends StatefulWidget {
//   const RegisterForm({super.key});
//
//   @override
//   State<RegisterForm> createState() => _RegisterFormState();
// }
//
// class _RegisterFormState extends State<RegisterForm> {
//   final _authentication = FirebaseAuth.instance;
//   final _formKey = GlobalKey<FormState>();
//   String email = '';
//   String password = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 onChanged: (value) {
//                   email = value;
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 obscureText: true,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 onChanged: (value) {
//                   password = value;
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       final newUser =
//                           await _authentication.createUserWithEmailAndPassword(
//                               email: email, password: password);
//                       if (newUser.user != null) {
//                         _formKey.currentState!.reset();
//                         if (!mounted) return;
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     const SuccessRegisterPage()));
//                       }
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                   child: const Text('Enter')),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   const Text('If you already registered, '),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text('log in with your email'),
//                   ),
//                 ],
//               )
//             ],
//           )),
//     );
//   }
// }
