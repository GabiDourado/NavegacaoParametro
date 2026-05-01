import 'package:flutter/material.dart';

class Finalizacao extends StatelessWidget {
  final double valorFinal;

  const Finalizacao({super.key, required this.valorFinal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Finalização")),
      body: Center(
        child: Text(
          "O valor total é: R\$ ${valorFinal.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}