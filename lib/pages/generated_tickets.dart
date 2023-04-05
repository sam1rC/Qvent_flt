import 'package:flutter/material.dart';
import 'package:qvent/services/firebase_services.dart';
import 'package:sizer/sizer.dart';
import 'create_event.dart';
//Services
import '../services/firebase_services.dart';
//Custom widgets
import '../widgets/card_widget.dart';

class GeneratedTicketsPage extends StatefulWidget {
  const GeneratedTicketsPage({super.key});

  @override
  State<GeneratedTicketsPage> createState() => _GeneratedTicketsPageState();
}

class _GeneratedTicketsPageState extends State<GeneratedTicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boletas disponibles'),
      ),
      body: FutureBuilder(
        future: getEvents(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/event_info', arguments: {
                      "name": snapshot.data?[index]['name'],
                      "tickets": snapshot.data?[index]['tickets'],
                      "read_tickets": snapshot.data?[index]['read_tickets'],
                    });
                  },
                  child: CardWidget(title: snapshot.data?[index]['name']),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}



