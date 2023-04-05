import 'package:flutter/material.dart';
import 'dart:io';
//tools
import 'package:sizer/sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TicketCardWidget extends StatelessWidget {
  const TicketCardWidget(
      {super.key, required this.reverseIndex, required this.imageUrl});
  final int reverseIndex;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Title(
            color: const Color(0xFFD5CEA3),
            child:
                Text('${reverseIndex + 1}', style: TextStyle(fontSize: 15.sp)),
          ),
          Image.network(imageUrl, scale: 1.3),
          IconButton(
              iconSize: 35,
              padding: EdgeInsets.zero,
              onPressed: () async {
                final uri = Uri.parse(imageUrl);
                final response = await http.get(uri);
                final bytes = response.bodyBytes;

                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/qr.jpg';
                File(path).writeAsBytesSync(bytes);

                await Share.shareXFiles([XFile(path)]);
              },
              icon: const Icon(Icons.share))
        ],
      ),
    );
  }
}
