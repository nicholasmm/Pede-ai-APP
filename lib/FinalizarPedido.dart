// ignore: file_names
import 'package:flutter/material.dart';

import 'MenuItem.dart';
import 'detalhes_pedido.dart';
import 'tela_garçom.dart';

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