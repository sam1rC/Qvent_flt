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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar boletas'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
                    child: Text('$ticketNumber'),
                    onPressed: () => showCupertinoModalPopup(
                      context: context,
                      builder: (_) => SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 30,
                          scrollController: FixedExtentScrollController(
                            initialItem: 0,
                          ),
                          children: items.map((item) => Text('$item')).toList(),
                          onSelectedItemChanged: (int value) {
                            setState(() {
                              ticketNumber = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Generar'))
            ],
          ),
        ),
      ),
    );
  }
}
