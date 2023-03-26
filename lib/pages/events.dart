import 'package:flutter/material.dart';
import 'package:qvent/services/firebase_services.dart';
import 'package:sizer/sizer.dart';
import 'create_event.dart';
//Services
import '../services/firebase_services.dart';

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
      body: FutureBuilder(
        future: getEvents(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data?[index]['name']);
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
