import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_am/reusable_widgets/reusable_widget.dart';
import 'package:proyecto_am/screens/home_screen.dart';
import 'package:proyecto_am/screens/signup_screen.dart';
import 'package:proyecto_am/utils/color_utils.dart';
import 'package:location/location.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors:[
          hexStringToColor("32D9CB"), //
          hexStringToColor("A5E65A"),
          hexStringToColor("6A888C")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              logoWidget("assets/images/location.png"),
              SizedBox(
                height: 30,
              ),
              reusableTextField("Ingrese su correo", Icons.person_outline, false, _emailTextController),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Ingrese su contraseña", Icons.lock_outline, true, _passwordTextController),
              SizedBox(
                height: 20,
              ),
              signInSignUpButton(context, true, (){
                FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, 
                password: _passwordTextController.text).then((value){
                  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen())
                  ).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                });
                
              }),
              signUpOption(),
            ],
            ),
          ),
        ),
      ),
    );
  }
  Row signUpOption(){
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Aun no tienes una cuenta? ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: (){
            Navigator.push(context, 
            // ignore: prefer_const_constructors
            MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Crear cuenta",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}