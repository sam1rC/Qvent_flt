import 'package:flutter/material.dart';
import 'package:qvent/services/firebase_services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//Sizer tool
import 'package:sizer/sizer.dart';



class ReadTicketsPage extends StatefulWidget {
  const ReadTicketsPage({super.key});

  @override
  State<ReadTicketsPage> createState() => _ReadTicketsPageState();
}

class _ReadTicketsPageState extends State<ReadTicketsPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

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
    onQRViewCreated: onQRViewCreated,
  );

  void onQRViewCreated(QRViewController controller){
    setState(() => this.controller = controller);

  }
}

