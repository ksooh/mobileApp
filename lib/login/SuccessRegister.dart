import 'package:flutter/material.dart';

import '../style.dart';

class SuccessRegisterPage extends StatelessWidget {
  const SuccessRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucess Register'),
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.blue1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have successfully registered',style: TextStyle(
              fontSize: 20,
            ),),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              Navigator.popUntil(context,(route)=>route.isFirst);
            },
                style: ElevatedButton.styleFrom(
                  primary: AppColor.blue1, // Set your desired color here
                ),
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
