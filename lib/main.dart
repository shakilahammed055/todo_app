import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screen/authscreen.dart';
import 'package:todo_app/screen/homescreen.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To Do App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot){
        if(userSnapshot.hasData){
          return const HomeScreen();
        }else{
          return const AuthScreen();
        }
      },
      ),
    );
  }
}
