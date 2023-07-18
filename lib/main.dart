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
  const NextScreenGarcom({Key? key}) : super(key: key);

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return ComandaScreen(
                menuItems: [
                  MenuItem(name: 'Hamburguer', ingredients: ['Pão', 'Carne', 'Queijo', 'Alface', 'Tomate']),
                  MenuItem(name: 'Pizza', ingredients: ['Massa', 'Queijo', 'Molho de tomate', 'Pepperoni', 'Cebola']),
                  MenuItem(name: 'Salada', ingredients: ['Alface', 'Tomate', 'Cenoura', 'Beterraba', 'Molho de salada']),
                ],
                selectedItems: List<bool>.filled(3, false),
              );
            }),
          );
        },
        label: const Text('Fazer pedido'),
        icon: const Icon(Icons.list_alt),
        backgroundColor: Colors.indigo[500],
      ),
    );
  }
}

class ComandaScreen extends StatelessWidget {
    final List<MenuItem> menuItems;
  final List<bool> selectedItems;

  const ComandaScreen({
    Key? key,
    required this.menuItems,
    required this.selectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comanda'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selecione os itens desejados:'),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(menuItems[index].name),
                    value: selectedItems[index],
                    onChanged: (value) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Remover ingredientes'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Remover ingredientes de ${menuItems[index].name}:'),
                                  const SizedBox(height: 10),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: menuItems[index].ingredients.length,
                                    itemBuilder: (context, ingredientIndex) {
                                      return CheckboxListTile(
                                        title: Text(menuItems[index].ingredients[ingredientIndex]),
                                        value: false,
                                        onChanged: (value) {
                                          // Faça algo com a opção selecionada
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Enviar'),
                                onPressed: () {
                                  // Faça algo com as opções selecionadas
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  class MenuItem {
    final String name;
    final List<String> ingredients;

    MenuItem({required this.name, required this.ingredients});
  }


void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}




