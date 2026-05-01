import 'package:flutter/material.dart';
import 'finalizacao.dart';

class Compras extends StatefulWidget {
  const Compras({super.key});

  @override
  State<Compras> createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  final TextEditingController _quantidadeController = TextEditingController();
  final double _precoUnitario = 50.00;
  double _valorFrete = 10.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Área de Compras"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Informações do Produto
            const Text(
              "Produto: Camiseta Flutter",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Valor Unitário: R\$ ${_precoUnitario.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Campo de Quantidade
            TextField(
              controller: _quantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantidade",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.add_shopping_cart),
              ),
            ),
            const SizedBox(height: 20),

            // Seleção de Frete
            const Text("Selecione o Frete:", style: TextStyle(fontSize: 16)),
            RadioListTile<double>(
              title: const Text("Normal (R\$ 10,00)"),
              value: 10.00,
              groupValue: _valorFrete,
              onChanged: (double? value) {
                setState(() {
                  _valorFrete = value!;
                });
              },
            ),
            RadioListTile<double>(
              title: const Text("Expresso (R\$ 25,00)"),
              value: 25.00,
              groupValue: _valorFrete,
              onChanged: (double? value) {
                setState(() {
                  _valorFrete = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            // Botão Calcular
        ElevatedButton(
          onPressed: () {
            int quantidade = int.tryParse(_quantidadeController.text) ?? 0;

            if (quantidade > 0) {
              double totalCalculado = (quantidade * _precoUnitario) + _valorFrete;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Finalizacao(valorFinal: totalCalculado),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Insira uma quantidade válida")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
          ),
          child: const Text("Calcular Total", style: TextStyle(fontSize: 18)),
        ),
          ],
        ),
      ),
    );
  }
}
