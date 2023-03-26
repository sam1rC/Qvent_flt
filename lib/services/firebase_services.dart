import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getEvents() async {
  List events = [];

  CollectionReference collectionReferenceEvents = db.collection('events');

  QuerySnapshot queryEvents = await collectionReferenceEvents.get();

  queryEvents.docs.forEach((document) {
    events.add(document.data());
  });

  return events;
}
