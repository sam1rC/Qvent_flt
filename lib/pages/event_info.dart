import 'package:flutter/material.dart';
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
    var tickets = arguments['tickets'];
    int read_tickets = arguments['read_tickets'];
    dynamic eventId = arguments['uid'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          EventInfoCard(
              ticketsLength: tickets.length, readTickets: read_tickets),
          TicketsButtons(
            notifyParent:
                refresh, //this is to notify when the tickets have been generated to refresh the info
            tickets: tickets,
            eventId: eventId,
          )
        ],
      ),
    );
  }
}

//This is the top card with the event information mentioned above.
class EventInfoCard extends StatefulWidget {
  const EventInfoCard(
      {super.key, required this.ticketsLength, required this.readTickets});
  final int ticketsLength;
  final int readTickets;

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
                        'Boletas disponibles',
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
                            '${widget.ticketsLength}',
                            style: TextStyle(
                              fontSize: 20.sp,
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
                        'Boletas leídas',
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
                            '${widget.readTickets}',
                            style: TextStyle(
                              fontSize: 20.sp,
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
      required this.tickets,
      required this.eventId,
      required this.notifyParent});
  final eventId;
  final tickets;
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
                "tickets": widget.tickets,
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
              "tickets": widget.tickets,
            });
          },
          child: const Text('Boletas disponibles'),
        ),
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Leer boleta'),
        )
      ],
    );
  }
}
