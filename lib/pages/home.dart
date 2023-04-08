import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Services
import 'package:qvent/services/firebase_services.dart';
//Custom widgets
import '../widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Eventos'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/create');
              //update the home page
              setState(() {});
            },
            icon: const Icon(Icons.add_circle_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
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
                        "uid": snapshot.data?[index]['uid'],
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
      ),
    );
  }
}
