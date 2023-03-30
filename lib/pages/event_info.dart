import 'package:flutter/material.dart';
//Sizer tool
import 'package:sizer/sizer.dart';

//This page displays the event information like available tickets and read tickets. It also contains the button to create and read tickets.
class EventInfoPage extends StatefulWidget {
  const EventInfoPage({super.key});

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String title = arguments['name'];
    var tickets = arguments['tickets'];
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: const EventInfoCard());
  }
}

//This is the top card with the event information mentioned above.
class EventInfoCard extends StatefulWidget {
  const EventInfoCard({super.key});

  @override
  State<EventInfoCard> createState() => _EventInfoCardState();
}

class _EventInfoCardState extends State<EventInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.h),
      child: Card(
        child: SizedBox(
          width: 80.w,
          height: 30.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Boletas disponibles'), Text('8')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Boletas leídas'), Text('2')],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
