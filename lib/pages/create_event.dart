import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Evento'),
        elevation: 0,
      ),
      body: const EventCreationForm(),
    );
  }
}

class EventCreationForm extends StatefulWidget {
  const EventCreationForm({super.key});

  @override
  State<EventCreationForm> createState() => _EventCreationFormState();
}

TextEditingController dateController = TextEditingController();
@override
void initState() {
  dateController.text = "";
}

class _EventCreationFormState extends State<EventCreationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          child: Column(
            children: [
              SizedBox(height: 3.h),
              const EventNameWidget(),
              SizedBox(height: 3.h),
              const EventDateWidget(),
              SizedBox(height: 5.h),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Crear'),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class EventNameWidget extends StatefulWidget {
  const EventNameWidget({super.key});

  @override
  State<EventNameWidget> createState() => _EventNameWidgetState();
}

class _EventNameWidgetState extends State<EventNameWidget> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration:
          InputDecoration(border: OutlineInputBorder(), hintText: 'Nombre'),
    );
  }
}

class EventDateWidget extends StatefulWidget {
  const EventDateWidget({super.key});

  @override
  State<EventDateWidget> createState() => _EventDateWidgetState();
}

class _EventDateWidgetState extends State<EventDateWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController,
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today),
        labelText: "Selecciona una fecha",
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2123),
        );
        if (pickedDate != null) {
          String formatedDate = DateFormat.yMMMd().format(pickedDate);
          setState(
            () {
              dateController.text = formatedDate;
            },
          );
        }
      },
    );
  }
}
