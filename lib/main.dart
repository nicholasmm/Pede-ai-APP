import 'package:flutter/material.dart';

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
          builder: (context) => const NextScreenGarcom(),
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

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the cozinheiro screen!'),
      ),
    );
  }
}

class NextScreenGarcom extends StatelessWidget {
  const NextScreenGarcom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garçom screen'),
      ),
      body: const Center(
        child: Text('Welcome to garçom screen!'),
      ),
            floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Script para janela popup
            showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Comanda'),
                content: const SizedBox(
                  width: 500, // Defina a largura desejada
                  height: 100, // Defina a altura desejada
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Digite aqui a comanda do cliente:',
                      //ontentPadding: EdgeInsets.symmetric(vertical: 30), Aumentar altura da textbox
                    ),
                  textInputAction: TextInputAction.newline, // Permitir nova linha ao pressionar "ENTER"
                  keyboardType: TextInputType.multiline, // Permitir múltiplas linhas
                  maxLines: null,
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Enviar'),
                    onPressed: () {
                      // Aqui você pode implementar a lógica para enviar a comanda
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        label: const Text('Fazer pedido'),
        icon: const Icon(Icons.list_alt),
        backgroundColor: Colors.indigo[500],
      ),
    );
  }
}
void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}




