import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necessario para os formatadores de texto
import 'finalizacao.dart';

class Compras extends StatefulWidget {
  const Compras({super.key});

  @override
  State<Compras> createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  final TextEditingController _qtdCamiseta = TextEditingController();
  final TextEditingController _qtdCaneca = TextEditingController();
  final TextEditingController _qtdMoletom = TextEditingController();

  final double _precoCamiseta = 50.00;
  final double _precoCaneca = 35.00;
  final double _precoMoletom = 120.00;

  double _valorFrete = 10.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loja Flutter"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      // O SingleChildScrollView evita o erro de "overflow" quando o teclado sobe
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Monte seu carrinho:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Lista de produtos
            _buildItemCompra("Camiseta Flutter", _precoCamiseta, _qtdCamiseta),
            _buildItemCompra("Caneca Dart", _precoCaneca, _qtdCaneca),
            _buildItemCompra("Moletom Dev", _precoMoletom, _qtdMoletom),

            const Divider(height: 40, thickness: 1.5),

            const Text(
              "Tipo de Frete:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Fretes
            RadioListTile<double>(
              title: const Text("Normal (R\$ 10,00)"),
              value: 10.00,
              groupValue: _valorFrete,
              onChanged: (double? novoValor) {
                setState(() {
                  _valorFrete = novoValor!;
                });
              },
            ),
            RadioListTile<double>(
              title: const Text("Expresso (R\$ 25,00)"),
              value: 25.00,
              groupValue: _valorFrete,
              onChanged: (double? novoValor) {
                setState(() {
                  _valorFrete = novoValor!;
                });
              },
            ),

            const SizedBox(height: 30),

            // Botão de calculo e navegação
            ElevatedButton(
              onPressed: () {
                int q1 = int.tryParse(_qtdCamiseta.text) ?? 0;
                int q2 = int.tryParse(_qtdCaneca.text) ?? 0;
                int q3 = int.tryParse(_qtdMoletom.text) ?? 0;

                // Calculo do total
                double totalProdutos = (q1 * _precoCamiseta) +
                    (q2 * _precoCaneca) +
                    (q3 * _precoMoletom);

                double totalFinal = totalProdutos + _valorFrete;

                // Só avança se o usuario comprou pelo menos 1 item
                if (totalProdutos > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Finalizacao(valorFinal: totalFinal),
                    ),
                  );
                } else {
                  // Mensagem de aviso se o carrinho estiver vazio
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Adicione pelo menos 1 item ao carrinho!"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Finalizar e Calcular", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  // Função para criar as linhas de cada produto
  Widget _buildItemCompra(String nome, double preco, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nome, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("R\$ ${preco.toStringAsFixed(2)}", style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              // IMPEDE NÚMEROS NEGATIVOS E SÍMBOLOS:
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: "Qtd",
                hintText: "0",
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}