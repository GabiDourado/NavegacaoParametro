import 'package:flutter/material.dart';
class Compras extends StatefulWidget {
  const Compras({super.key});

  @override
  State<Compras> createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  @override
  Widget build(BuildContext context) {
    return const Text("Tela de compras", style: TextStyle(fontSize: 18),);
  }
}
