import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

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

//add tickets to the event
Future<void> updateEventTickets(String uid, List<dynamic> tickets) async {
  await db
      .collection('events')
      .doc(uid)
      .set({"tickets": tickets}, SetOptions(merge: true));
}

//delete event
Future<void> deleteEvent(String uid) async {
  await db.collection('events').doc(uid).delete();
}

Future<void> addOneReadTicket(String uid, int read_tickets, String ticket) async {
  await db.collection('events').doc(uid).set({"read_tickets": read_tickets}, SetOptions(merge: true));

}
