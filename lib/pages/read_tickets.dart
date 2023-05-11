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
  dynamic ticketsGen;
  dynamic ticketsPref;
  dynamic eventId;
  dynamic read_tickets;
  late String ticketExists = 'null';
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
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    dynamic ticketsGen_argument = arguments['ticketsGen'];
    dynamic read_tickets_argument = arguments['read_tickets'];
    dynamic eventId_argument = arguments['eventId'];
    dynamic ticketsPref_argument = arguments['ticketsPref'];
    ticketsGen = ticketsGen_argument;
    ticketsPref = ticketsPref_argument;
    read_tickets = read_tickets_argument;
    eventId = eventId_argument;
    var safeArea = SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Generar boletas'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            //Positioned(bottom: 10, child: buildResult()),
          ],
        ),
      ),
    );
    return safeArea;
  }

  Future<Widget> buildResult() async => await showDialog(
      context: context,
      builder: (context) {
        if (ticketExists) {
          return AlertDialog(
              title: const Text("Boleta leída con éxito"),
              actions: [
                TextButton(
                  onPressed: () {
                    return Navigator.pop(context, false);
                  },
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.red)),
                )
              ]);
        } else {
          return AlertDialog(
              title: const Text("La boleta no existe o ya fue leída"),
              actions: [
                TextButton(
                  onPressed: () {
                    return Navigator.pop(context, false);
                  },
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.red)),
                )
              ]);
        }
      });

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

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen(
      (barcode) => setState(() {
        this.barcode = barcode;
        ticketExists =
            findTicket(barcode.code, ticketsGen, ticketsPref, barcode, eventId);

        controller.pauseCamera();
        showDialog(
            context: context,
            builder: (context) {
              if (ticketExists) {
                return AlertDialog(
                    title: const Text("Boleta leída con éxito"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          controller.resumeCamera();
                          return Navigator.pop(context, false);
                        },
                        child: const Text('Aceptar',
                            style: TextStyle(color: Colors.green)),
                      )
                    ]);
              } else {
                return AlertDialog(
                    title: const Text("La boleta no existe o ya fue leída"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          controller.resumeCamera();
                          return Navigator.pop(context, false);
                        },
                        child: const Text('Aceptar',
                            style: TextStyle(color: Colors.green)),
                      )
                    ]);
              }
            });
      }),
    );
  }

  String findTicket(String? ticketNumber, dynamic ticketsGen,
      dynamic ticketsPref, dynamic barcode, dynamic eventId) {
    List<dynamic> listTickets = ticketsGen;
    List<dynamic> listTicketsPref = ticketsPref;
    if (listTickets.contains(ticketNumber)) {
      deleteTicket(barcode.code, ticketsGen);
      updateEventTickets(eventId, ticketsGen);
      return "Gen";
    } else if (listTicketsPref.contains(ticketNumber)) {
      deleteTicket(barcode.code, ticketsPref);
      updateEventTickets(eventId, ticketsPref);
      return "Pref";
    } else {
      return "null";
    }
  }

  List<dynamic> deleteTicket(String? ticketNumber, dynamic tickets) {
    List<dynamic> updatedTickets = tickets;
    updatedTickets.remove(ticketNumber);
    return updatedTickets;
  }
}
