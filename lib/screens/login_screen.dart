// ignore_for_file: prefer_const_constructors

import 'package:assignment3/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment3/utils/auth.dart';
import 'package:assignment3/screens/main_screen.dart';

class LoginPage extends StatefulWidget {
  final Key? key;

  LoginPage({this.key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<UserCredential?> userCredential = ValueNotifier(null);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: userCredential,
          builder: (context, value, child) {
            if (userCredential.value == null) {
              // Show login form
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Updated color
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email), // Added prefix icon
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock), // Added prefix icon
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Sign-in using Google"),
                  SizedBox(height: 10),
                  ElevatedButton( // Styled Google sign-in button
                    onPressed: () async {
                      try {
                        UserCredential? credential = await signInWithGoogle();
                        if (credential != null) {
                          userCredential.value = credential;
                          await saveLoginStatus(true);
                          print(FirebaseAuth.instance.currentUser?.displayName);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => mainScreen()),
                          );
                        }
                      } catch (e) {
                        // Handle sign-in error
                        print('Sign-in error: $e');
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/google_logo.png',
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              // Show user details and logout button
              return GoogleSignInScreen(userCredential: userCredential);
            }
          },
        ),
      ),
    );
  }
}

class GoogleSignInScreen extends StatelessWidget {
  final ValueNotifier<UserCredential?> userCredential;

  const GoogleSignInScreen({Key? key, required this.userCredential})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = userCredential.value?.user;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar( // Display user profile picture in a circle avatar
            backgroundImage: NetworkImage(user?.photoURL.toString() ?? ''),
            radius: 50,
          ),
          const SizedBox(height: 20),
          Text(
            user?.displayName.toString() ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            user?.email.toString() ?? '',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              bool result = await signOutFromGoogle();
              if (result) userCredential.value = null;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Logout button color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
