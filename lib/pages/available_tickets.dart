import 'package:flutter/material.dart';
import '../widgets/ticket_card_widget.dart';

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
      body: GridView.builder(
          itemCount: tickets.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 2),
          itemBuilder: (context, index) {
            int reverseIndex = tickets.length - 1 - index;
            String imageUrl = getQRImageSource(tickets[reverseIndex]);
            return TicketCardWidget(
                reverseIndex: reverseIndex, imageUrl: imageUrl);
          }),
    );
  }
}

String getQRImageSource(String ticket) {
  return 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$ticket';
}
