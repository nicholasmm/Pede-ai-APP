

import 'package:flutter/material.dart';

import 'MenuItem.dart';

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