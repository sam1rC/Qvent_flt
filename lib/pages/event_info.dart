import 'package:flutter/material.dart';
import 'package:qvent/services/firebase_services.dart';
//Sizer tool
import 'package:sizer/sizer.dart';
//AutoSize Text tool
import 'package:auto_size_text/auto_size_text.dart';

//This page displays the event information like available tickets and read tickets. It also contains the button to create and read tickets.
class EventInfoPage extends StatefulWidget {
  const EventInfoPage({super.key});

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  @override
  Widget build(BuildContext context) {
    //this function is used to refresh the information after generate new tickets or read a ticket
    refresh() {
      setState(() {});
    }

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String title = arguments['name'];
    var ticketsPref = arguments['ticketsPref'];
    var ticketsGen = arguments['ticketsGen'];
    int read_tickets = arguments['read_tickets'];
    dynamic eventId = arguments['uid'];
    int capacity = arguments['capacity'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          EventInfoCard(
              ticketsPrefLength: ticketsPref.length,
              ticketsGenLength: ticketsGen.length),
          TicketsButtons(
            notifyParent:
                refresh, //this is to notify when the tickets have been generated to refresh the info
            ticketsPref: ticketsPref,
            ticketsGen: ticketsGen,
            eventId: eventId,
            read_tickets: read_tickets,
            capacity: capacity,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "Te queda disponible el ${(100 - ((ticketsPref.length + ticketsGen.length) / capacity) * 100)}% del aforo",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

//This is the top card with the event information mentioned above.
class EventInfoCard extends StatefulWidget {
  const EventInfoCard(
      {super.key,
      required this.ticketsPrefLength,
      required this.ticketsGenLength});
  final int ticketsPrefLength;
  final int ticketsGenLength;

  @override
  State<EventInfoCard> createState() => _EventInfoCardState();
}

class _EventInfoCardState extends State<EventInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.h),
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: 30.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'Boletas preferenciales',
                        style: TextStyle(fontSize: 20.sp),
                        maxLines: 1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: AutoSizeText(
                            '${widget.ticketsPrefLength}',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'Boletas generales',
                        style: TextStyle(fontSize: 20.sp),
                        maxLines: 1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: AutoSizeText(
                            '${widget.ticketsGenLength}',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class TicketsButtons extends StatefulWidget {
  final Function() notifyParent; //This function refresh the parent widget
  const TicketsButtons(
      {super.key,
      required this.ticketsPref,
      required this.ticketsGen,
      required this.eventId,
      required this.read_tickets,
      required this.capacity,
      required this.notifyParent});
  final eventId;
  final ticketsGen;
  final ticketsPref;
  final read_tickets;
  final capacity;
  @override
  State<TicketsButtons> createState() => _TicketsButtonsState();
}

class _TicketsButtonsState extends State<TicketsButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              '/create_tickets',
              arguments: {
                "eventId": widget.eventId,
                "tickets": widget.ticketsGen,
                "capacity": widget.capacity,
                "ticketsPref": widget.ticketsPref,
              },
            );
            //update info page
            widget.notifyParent();
          },
          child: const Text('Generar boletas'),
        ),
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/available_tickets', arguments: {
              "tickets": widget.ticketsGen,
            });
          },
          child: const Text('Boletas generales'),
        ),
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/available_tickets', arguments: {
              "tickets": widget.ticketsGen,
            });
          },
          child: const Text('Boletas preferenciales'),
        ),
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/read_tickets', arguments: {
              "eventId": widget.eventId,
              "tickets": widget.ticketsGen,
              "read:tickets": widget.read_tickets,
            });
          },
          child: const Text('Leer Boletas'),
        )
      ],
    );
  }
}
