import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task2/Screens/HomeScreeen.dart';
import 'package:task2/Screens/Login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskScreen()));
      print('User signed up successfully!');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Email is already in use. Please use a different email.'),
          ),
        );
      } else {
        print('Error signing up: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Password',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
              _isLoading
                  ? CircularProgressIndicator() // Show loader if signing up
                  : ElevatedButton(
                      onPressed: () {
                        _signUp(context);
                      },
                      child: Text('Sign Up'),
                    ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(width: 9),
                  TextButton(
                    child: Text("Log In"),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
