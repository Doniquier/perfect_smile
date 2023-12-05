import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:smile/firebase_options.dart';
import 'package:smile/menu.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final logger = Logger();
  runApp(MyApp(logger: logger, navigatorKey: navigatorKey));
}

class MyApp extends StatelessWidget {
  final Logger logger;
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({required this.logger, required this.navigatorKey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Medicina',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 320.0,
                alignment: Alignment.center,
                child: const SizedBox(
                  height: 300.0,
                  width: 300.0,
                  child: CircleAvatar(
                    radius: 160.0,
                    backgroundColor: Colors.indigo,
                    backgroundImage: AssetImage('images/logosmile.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              _textFieldName(),
              const SizedBox(
                height: 20.0,
              ),
              _textFieldPassword(),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      User? user = userCredential.user;
                      if (user != null) {
                        logger.d('Inicio de sesión exitoso');

                        Navigator.of(navigatorKey.currentContext!).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Menu(),
                          ),
                        );
                      }
                    } catch (e) {
                      logger.e('Error de inicio de sesión: $e');
                    }
                  },
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return _TextFieldGeneral(
      labelText: 'correo',
      hintText: 'ejemplo@gmail.com',
      icon: Icons.person_outline,
      onChanged: (value) {
        if (value != null) {
          _emailController.text = value;
        }
      },
    );
  }

  Widget _textFieldPassword() {
    return _TextFieldGeneral(
      labelText: 'contraseña',
      hintText: '**********',
      icon: Icons.lock_outline_rounded,
      onChanged: (value) {
        if (value != null) {
          _passwordController.text = value;
        }
      },
      obscureText: true, 
    );
  }
}

class _TextFieldGeneral extends StatelessWidget {
  final String labelText;
  final String hintText;
  final void Function(String?) onChanged;
  final IconData icon;
  final bool obscureText; // Agrega esta línea

  const _TextFieldGeneral({
    required this.labelText,
    this.hintText = '',
    required this.onChanged,
    required this.icon,
    this.obscureText = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        obscureText: obscureText, 
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
