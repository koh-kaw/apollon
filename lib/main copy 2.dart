import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterZero'),
        ),
        body: MyCustomApp(),
      ),
    );
  }
}

class MyCustomApp extends StatefulWidget {
  const MyCustomApp({Key? key}) : super(key: key);

  @override
  State<MyCustomApp> createState() => _MyCustomAppState();
}

class _MyCustomAppState extends State<MyCustomApp> {
  String? email;
  String? password;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: _emailController,
            onChanged: (email) {
              this.email = email;
            },
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            onChanged: (password) {
              this.password = password;
            },
            obscureText: true,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          ElevatedButton(
            child: Text('Sign Up'),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );

                const snackBar = SnackBar(
                  content: Text('Success!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
    );
  }
}
