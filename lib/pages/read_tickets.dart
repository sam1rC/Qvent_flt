import 'dart:io';

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
  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
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
          Positioned(bottom: 10, child: buildResult()),
        ],
      ),
    ),
  );

  Widget buildResult() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color:Colors.white24,
    ),
    child: Text(
    barcode != null ? 'Result : ${barcode!.code}' : 'Scan a code!',
    maxLines:3,
    ),
    
    );

  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Colors.white,
      borderRadius: 10,
      borderLength: 20,
      borderWidth: 10,
      cutOutSize: MediaQuery.of(context).size.width * 0.8,
    ),
  );

  void onQRViewCreated(QRViewController controller){
    setState(() => this.controller = controller);

    controller.scannedDataStream
      .listen((barcode) => setState(() => this.barcode = barcode));

  }
}

