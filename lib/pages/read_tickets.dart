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
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Generar boletas'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
        ],
      ),
    ),
  );

  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey,
  );
}

