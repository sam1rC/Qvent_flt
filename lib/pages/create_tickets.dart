import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qvent/services/firebase_services.dart';
//Sizer tool
import 'package:sizer/sizer.dart';
//Uuid tool
import 'package:uuid/uuid.dart';

class CreateTicketsPage extends StatefulWidget {
  const CreateTicketsPage({super.key});

  @override
  State<CreateTicketsPage> createState() => _CreateTicketsPageState();
}

class _CreateTicketsPageState extends State<CreateTicketsPage> {
  int ticketNumber = 0;
  List<String> ticketTypes = ['Preferencial', 'General'];
  String? selectedTicketType = 'General';
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    dynamic tickets = arguments['tickets'];
    dynamic ticketsPref = arguments['ticketsPref'];
    dynamic eventId = arguments['eventId'];
    dynamic capacity = arguments['capacity'];
    List<int> items = [for (int i = 0; i <= capacity; i += 1) i];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar boletas'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Nro de boletas',
                    style: TextStyle(
                        color: const Color(0xFFE5D9B6), fontSize: 22.sp),
                  ),
                  CupertinoButton.filled(
                    child: Text(
                      '$ticketNumber',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      FixedExtentScrollController(initialItem: ticketNumber);
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: CupertinoPicker(
                            looping: true,
                            backgroundColor: Colors.white,
                            itemExtent: 30,
                            scrollController: FixedExtentScrollController(
                              initialItem: ticketNumber,
                            ),
                            children: items
                                .map((item) => Text(
                                      '$item',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ))
                                .toList(),
                            onSelectedItemChanged: (int value) {
                              setState(() {
                                ticketNumber = value;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  DropdownButton(
                    value: selectedTicketType,
                    items: ticketTypes
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedTicketType = value;
                      print(value);
                    }),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (ticketNumber + tickets.length > capacity) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: const Text(
                                    "Las boletas no pueden sobrepasar el aforo"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      return Navigator.pop(context, false);
                                    },
                                    child: const Text('Aceptar',
                                        style: TextStyle(color: Colors.green)),
                                  )
                                ]);
                          });
                    } else {
                      tickets = generateTickets(ticketNumber, eventId, tickets);
                      await updateEventTickets(eventId, tickets).then((_) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: const Text('Generar'))
            ],
          ),
        ),
      ),
    );
  }
}

List<dynamic> generateTickets(
    int ticketNumber, dynamic eventId, dynamic tickets) {
  List<dynamic> updatedTickets = tickets;
  int totalLength = ticketNumber + updatedTickets.length;
  for (int i = updatedTickets.length; i < totalLength; i++) {
    updatedTickets.add(const Uuid().v4());
  }
  return updatedTickets;
}
