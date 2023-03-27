import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Get events from database
Future<List> getEvents() async {
  List events = [];
  CollectionReference collectionReferenceEvents = db.collection('events');
  QuerySnapshot queryEvents = await collectionReferenceEvents.get();
  queryEvents.docs.forEach((document) {
    events.add(document.data());
  });

  return events;
}

//Add name to database
Future<void> addEvent(String name, String date) async {
  await db
      .collection('events')
      .add({"name": name, "date": date, "tickets": [], "read_tickets": 0});
}
