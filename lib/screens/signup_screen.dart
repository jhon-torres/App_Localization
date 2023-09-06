import 'package:flutter/material.dart';
import 'package:proyecto_am/reusable_widgets/reusable_widget.dart';
import 'package:proyecto_am/services/firebase_service.dart';
import 'package:proyecto_am/utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  String? passwordErrorText;

  bool isPasswordValid() {
    if (_passwordTextController.text.length < 6) {
      setState(() {
        passwordErrorText = 'La contraseña debe tener al menos 6 caracteres';
      });
      return false;
    } else {
      setState(() {
        passwordErrorText = null;
      });
      return true;
    }
  }

  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    if (arguments != null && arguments['uid'] != null) {
      // Cargar los datos si estás en modo edición
      _userNameTextController.text = arguments['name'];
      _emailTextController.text = arguments['email'];
      _passwordTextController.text = ''; // No es recomendable cargar la contraseña en el formulario
    }
    super.didChangeDependencies();
  }

  Future<void> AddNamePage(Map? arguments) async {
    if (arguments != null && arguments['uid'] != null) {
      // Actualizar en Firestore
      await updateUser(arguments['uid'], _userNameTextController.text,
          _emailTextController.text);
    } else {
      // Registrar un nuevo usuario en Firebase Authentication y guardar en Firestore
      await registerUser(_emailTextController.text, _passwordTextController.text,
          _userNameTextController.text);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sing Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
          hexStringToColor("32D9CB"), //
          hexStringToColor("A5E65A"),
          hexStringToColor("6A888C")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,MediaQuery.of(context).size.height * 0.2, 20, 0
            ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Ingrese el nombre de usuario", Icons.person_outline, false, 
              _userNameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Ingrese su correo electrónico", Icons.mail_outlined, false, 
              _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Ingrese una Contraseña", Icons.lock_outline, true, 
              _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              signInSignUpButton(context, false, () async {
                if (isPasswordValid()) {
                  // Verificar antes de guardar/actualizar
                  final arguments =
                      ModalRoute.of(context)!.settings.arguments as Map?;
                  await AddNamePage(arguments);
                }              
              })
              

            ],
          ),),
        ),
      ),
    );
  }
}