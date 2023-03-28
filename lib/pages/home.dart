import 'package:flutter/material.dart';
import 'package:qvent/services/firebase_services.dart';
import 'package:sizer/sizer.dart';
import 'create_event.dart';
//Services
import '../services/firebase_services.dart';

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
              await Navigator.pushNamed(context, '/create_event');
              //update the home page
              setState(() {});
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
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                  child: Card(
                    child: SizedBox(
                      width: double.infinity,
                      height: 5.h,
                      child: Row(
                        children: [
                          Text(snapshot.data?[index]['name']),
                        ],
                      ),
                    ),
                  ),
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
