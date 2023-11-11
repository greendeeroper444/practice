import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice/components/my_button.dart';
import 'package:practice/components/my_textfield.dart';
import 'package:practice/components/square_tile.dart';

//https://www.youtube.com/watch?v=4fucdtPwTWI&t=40s&ab_channel=MitchKoko
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Signin user in method
  void signUserIn() async {
    //loading effect
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    );

    final emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (!emailPattern.hasMatch(emailController.text)) {
      Navigator.pop(context);
      print('Invalid email format');
    } else {
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          if (e.code == 'user-not-found') {
            // wrongEmailMessage();
            print('Email is Incorrect');
          } else if (e.code == 'wrong-password') {
            // wrongPasswordMessage();
            print('Password is Incorrect');
          }
        }
      }
    }

  //wrong email message popup
  // void wrongEmailMessage(){
  //   showDialog(
  //       context: context,
  //       builder: (context){
  //         return const AlertDialog(
  //           title: Text('Incorrect Email'),
  //       );
  //     },
  //   );
  // }

  // void wrongPasswordMessage(){
  //   showDialog(
  //     context: context,
  //     builder: (context){
  //       return const AlertDialog(
  //         title: Text('Incorrect Password'),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
            const SizedBox(height: 40),
            //logo
            const Icon(Icons.lock,
            size: 100),

            const SizedBox(height: 30),
            //welcome back, you've been missed
              const Text('Welcome back you\'ve been missed!',
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                fontSize: 16,
              ),
              ),

             const SizedBox(height: 30),
            //email textfield
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),

              const SizedBox(height: 10),
            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

              const SizedBox(height: 10),
            //forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot password?',
                  style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),

              const SizedBox(height: 25),
            //sign in button
            MyButton(
              onTap: signUserIn,
            ),

              const SizedBox(height: 40),
            //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                    ),

                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                       child: Text(
                           'Or continue with',
                         style: TextStyle(color: Colors.grey[700],
                       ),
                     ),
                     ),

                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //google button
             SquareTile(imagePath: 'lib/images/google.png'),

                SizedBox(width: 25),

              //apple button
                SquareTile(imagePath: 'lib/images/apple.png'),
            ],
            ),

              const SizedBox(height: 40),
            //google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?',
                  style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(width: 4),
                  const Text('Register now',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ],
              ),
            //not a member? register now
          ],),
        ),
      ),
    );
  }
}

//https://firebase.google.com/docs?hl=en&authuser=0&_gl=1*409wnd*_ga*MTMwNzgyNTU2Mi4xNjk4NTY2NTg5*_ga_CW55HF8NVT*MTY5ODU2NjU4OS4xLjEuMTY5ODU2NjYwMy40Ni4wLjA.
