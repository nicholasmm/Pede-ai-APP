import 'package:flutter/material.dart';
import 'MenuItem.dart';
import 'comanda_garcom.dart';
import 'detalhes_pedido.dart';

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