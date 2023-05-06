import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Services
import 'package:qvent/services/firebase_services.dart';
//Custom widgets
import '../widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future events;
  @override
  void initState() {
    super.initState();
    events = getEvents();
  }

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
          future: events,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: _pullRefresh,
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (direction) async {
                        await deleteEvent(snapshot.data?[index]['uid']);
                        snapshot.data?.removeAt(index);
                      },
                      confirmDismiss: (direction) async {
                        bool result = false;

                        result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    "Vas a eliminar el evento ${snapshot.data?[index]['name']}"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      return Navigator.pop(context, false);
                                    },
                                    child: const Text('Cancelar',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      return Navigator.pop(context, true);
                                    },
                                    child: const Text(
                                      'Confirmar',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  )
                                ],
                              );
                            });

                        return result;
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete),
                      ),
                      direction: DismissDirection.startToEnd,
                      key: Key(snapshot.data?[index]['uid']),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/event_info',
                              arguments: {
                                "name": snapshot.data?[index]['name'],
                                "tickets": snapshot.data?[index]['tickets'],
                                "read_tickets": snapshot.data?[index]
                                    ['read_tickets'],
                                "uid": snapshot.data?[index]['uid'],
                              });
                        },
                        child: CardWidget(title: snapshot.data?[index]['name']),
                      ),
                    );
                  },
                ),
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

  Future<void> _pullRefresh() async {
    Future newEvents = getEvents();
    setState(() {
      events = newEvents;
    });
  }
}
