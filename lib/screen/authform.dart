import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _email = "";
  var _password = "";
  var _username = "";

  bool _isLogin = true;

  startauthentication() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); //this is close the keyboard

    if (isValid) {
      _formKey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;

    try {
      if (_isLogin) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid = authResult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          "email": email,
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty|| !value.contains('@')){
                        return "please enter a valid email address";
                      }
                      return null;
                    },
                    onSaved: (value){
                      _email= value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey("email"),
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your Email",
                        labelStyle: GoogleFonts.roboto(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                    ),
                  ),
                  // if(!_isLogin)
                  SizedBox(
                    height: 20,
                  ),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty|| value.length<7){
                          return "please enter a valid password";
                        }
                        return null;
                      },
                      onSaved: (value){
                        _username= value!;
                      },
                      key: ValueKey("username"),
                      decoration: InputDecoration(
                        labelText: "User name",
                        hintText: "Enter your user name",
                        labelStyle: GoogleFonts.roboto(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
