import 'package:flutter/material.dart';

class AvailableTicketsPage extends StatefulWidget {
  const AvailableTicketsPage({super.key});

  @override
  State<AvailableTicketsPage> createState() => _AvailableTicketsPageState();
}

class _AvailableTicketsPageState extends State<AvailableTicketsPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    dynamic tickets = arguments['tickets'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boletas disponibles'),
      ),
    );
  }
}
