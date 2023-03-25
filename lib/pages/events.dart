import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'create_event.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Eventos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const CreateEventPage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add_circle_outlined),
          ),
        ],
      ),
    );
  }
}
