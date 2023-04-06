import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qvent/services/firebase_services.dart';
//Sizer tool
import 'package:sizer/sizer.dart';



class ReadTicketsPage extends StatefulWidget {
  const ReadTicketsPage({super.key});

  @override
  State<ReadTicketsPage> createState() => _ReadTicketsPageState();
}

class _ReadTicketsPageState extends State<ReadTicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text('Leer Boletas'),
      ),
    );
  }
}