import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Sizer tool
import 'package:sizer/sizer.dart';

class CreateTicketsPage extends StatefulWidget {
  const CreateTicketsPage({super.key});

  @override
  State<CreateTicketsPage> createState() => _CreateTicketsPageState();
}

class _CreateTicketsPageState extends State<CreateTicketsPage> {
  int ticketNumber = 0;
  List<int> items = [for (int i = 0; i <= 200; i += 1) i];
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    dynamic tickets = arguments['tickets'];
    dynamic eventId = arguments['eventId'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar boletas'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
          child: Column(
            children: [
              Row(
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
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    print(ticketNumber);
                  },
                  child: const Text('Generar'))
            ],
          ),
        ),
      ),
    );
  }
}
