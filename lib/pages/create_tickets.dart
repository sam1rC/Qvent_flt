import 'package:flutter/material.dart';

class CreateTicketsPage extends StatefulWidget {
  const CreateTicketsPage({super.key});

  @override
  State<CreateTicketsPage> createState() => _CreateTicketsPageState();
}

class _CreateTicketsPageState extends State<CreateTicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar boletas'),
      ),
    );
  }
}
