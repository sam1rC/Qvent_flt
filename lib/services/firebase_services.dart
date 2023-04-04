import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Get events from database
Future<List> getEvents() async {
  List events = [];
  CollectionReference collectionReferenceEvents = db.collection('events');
  QuerySnapshot queryEvents = await collectionReferenceEvents.get();
  for (var doc in queryEvents.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final event = {
      "date": data["date"],
      "name": data["name"],
      "read_tickets": data["read_tickets"],
      "tickets": data["tickets"],
      "uid": doc.id,
    };
    events.add(event);
  }

  return events;
}

//Add name to database
Future<void> addEvent(String name, String date) async {
  await db
      .collection('events')
      .add({"name": name, "date": date, "tickets": [], "read_tickets": 0});
}

Future<void> updateEventTickets(String uid, List<dynamic> tickets) async {
  await db
      .collection('events')
      .doc(uid)
      .set({"tickets": tickets}, SetOptions(merge: true));
}
