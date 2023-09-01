import 'package:flutter/material.dart';
import 'tela_garçom.dart';
import 'tela_cozinha.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController pinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = ''; 

  // Simulated PIN and password for demonstration purposes
  final String correctPinCozinha = '1234';
  final String correctPasswordCozinha = 'password';
  final String correctPasswordgarcom = 'passwordgarcom';
  final String correctPingarcom =  '123';



  void _login() {
    String enteredPin = pinController.text;
    String enteredPassword = passwordController.text;

    if (enteredPin == correctPinCozinha && enteredPassword == correctPasswordCozinha) {
      // Login successful, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NextScreen(),
        ),
      );
    } else if (enteredPin == correctPingarcom && enteredPassword == correctPasswordgarcom){
         Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NextScreenGarcom(pedidos: [],),
        ),
      );
    } else {
      //Página de erro
      setState(() {
        errorMessage = 'Incorrect PIN or password';
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Padding(
        //padding:  EdgeInsets.all(20.0),
        padding: const EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'PIN',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 10.0),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}




