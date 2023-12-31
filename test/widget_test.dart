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

class DetalhesPedido extends StatelessWidget {
  final Pedido pedido;

  const DetalhesPedido({Key? key, required this.pedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Itens do Pedido:'),
          for (var item in pedido.itens)
            Text('${item.name} (${item.quantity})'),
          SizedBox(height: 16),
          Text('Observações:'),
          Text(pedido.observacoes),
        ],
      ),
    );
  }
}



class Pedido {
  List<MenuItem> itens;
  String observacoes;

  Pedido({
    required this.itens,
    required this.observacoes,
  });
} // classe que vai armazenar as informações dos pedidos para serem enviados depois para a tela inicial.


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
  final List<Pedido> pedidos;

  const NextScreenGarcom({Key? key, required this.pedidos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garçom screen'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Welcome to garçom screen!'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Pedido ${index + 1}'),
                  subtitle: Text('Itens: ${pedidos[index].itens.length}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DetalhesPedido(pedido: pedidos[index]);
                      }),
                    );
                  },
                );
              },
            ),
          ),
        ],
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
                selectedItems: List<bool>.filled(3, true),
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

class ComandaScreen extends StatefulWidget {
  final List<MenuItem> menuItems;

  const ComandaScreen({Key? key, required this.menuItems, required List<bool> selectedItems}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ComandaScreenState createState() => _ComandaScreenState();
}

class _ComandaScreenState extends State<ComandaScreen> {
  late List<bool> selectedItems;
  List<MenuItem> selectedMenuItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems = List<bool>.filled(widget.menuItems.length, false);
  }

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
                itemCount: widget.menuItems.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(widget.menuItems[index].name),
                    value: selectedItems[index],
                    onChanged: (value) {
                      setState(() {
                        selectedItems[index] = value ?? false;
                        if (value == true) {
                          selectedMenuItems.add(widget.menuItems[index]);
                        } else {
                          selectedMenuItems.remove(widget.menuItems[index]);
                        }
                        widget.menuItems[index].quantity = selectedItems[index] ? 1 : 0;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20), // Espaço entre a lista e o botão
              Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
      
                      return FinalizarPedido(selectedItems: selectedMenuItems, pedidos: [],);
                    }),
                  );
                },
                
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder( // bordas arredondadas
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                
                child: const Row( // Usar um Row para combinar ícone e texto horizontalmente
                  mainAxisSize: MainAxisSize.min, // Definir o tamanho do Row conforme necessário
                  children: [
                    Icon(Icons.check), // Ícone
                    SizedBox(width: 8), // Espaço entre o ícone e o texto
                    Text('Concluir Pedido'), // Texto
                  ],
                )
              ),
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
    int quantity;

    MenuItem({required this.name, required this.ingredients, this.quantity = 1});
  }


// ignore: camel_case_types
class FinalizarPedido extends StatefulWidget {
  final List<MenuItem> selectedItems;
  final List<Pedido> pedidos;
  const FinalizarPedido({super.key, required this.selectedItems, required this.pedidos});

  @override
  _FinalizarPedidoState createState() => _FinalizarPedidoState();
}

class _FinalizarPedidoState extends State<FinalizarPedido> {
  final TextEditingController observationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Pedido'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Itens selecionados:'),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.selectedItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.selectedItems[index].name),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (widget.selectedItems[index].quantity > 1) {
                                  setState(() {
                                    widget.selectedItems[index].quantity--;
                                  });
                                }
                              },
                            ),
                            Text(widget.selectedItems[index].quantity.toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  widget.selectedItems[index].quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
              const Text('OBSERVAÇÕES:'),
              const SizedBox(height: 10),
              SingleChildScrollView(
                child: TextField(
                  controller: observationsController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Ex: Hamburguer sem alface e tomate.',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Pedido pedido = Pedido(
                      itens: widget.selectedItems,
                      observacoes: observationsController.text,
                    );

                    List<Pedido> pedidos = [pedido, ...widget.pedidos]; // Adicione o novo pedido à lista de pedidos existente
                    Navigator.popUntil(context, ModalRoute.withName('/')); // Retorna à tela inicial do garçom


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return NextScreenGarcom(
                          pedidos: pedidos,
                        );
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check),
                      SizedBox(width: 8),
                      Text('Finalizar Pedido'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Criar um ListTile para cada pedido concluído
              for (var pedido in widget.pedidos)
                ListTile(
                  title: Text('Pedido'),
                  subtitle: Text('Itens: ${pedido.itens.length}'),
                  onTap: () {
                    // Navegar para os detalhes do pedido
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DetalhesPedido(pedido: pedido);
                      }),
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








void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}




