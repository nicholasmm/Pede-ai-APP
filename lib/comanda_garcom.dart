import 'package:flutter/material.dart';
import 'FinalizarPedido.dart';
import 'MenuItem.dart';

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
