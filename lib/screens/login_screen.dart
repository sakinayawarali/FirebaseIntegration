// ignore_for_file: library_private_types_in_public_api, use_super_parameters, prefer_const_constructors, use_build_context_synchronously
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
                      color: Color.fromRGBO(251, 124, 101, 50),
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
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Sign-in using Google"),
                  SizedBox(height: 10),
                  TextButton(
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
                    child: Container(
                      child: Image.asset(
                        'assets/google_logo.png',
                        width: 50,
                        height: 50,
                      ),
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
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.5, color: Colors.black54),
            ),
            child: Image.network(user?.photoURL.toString() ?? ''),
          ),
          const SizedBox(height: 20),
          Text(user?.displayName.toString() ?? ''),
          const SizedBox(height: 20),
          Text(user?.email.toString() ?? ''),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              bool result = await signOutFromGoogle();
              if (result) userCredential.value = null;
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}