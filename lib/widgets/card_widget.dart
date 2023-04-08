import 'package:flutter/material.dart';
//Sizer tool
import 'package:sizer/sizer.dart';

//This widget is the card being displayed in the home page with each event title.
class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          child: SizedBox(
            width: double.infinity,
            height: 5.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
