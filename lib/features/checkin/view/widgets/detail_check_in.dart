import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class CheckInDetails extends StatelessWidget {
  final String time;
  final int totalTopCount;
  final String session;
  final String imageUrl;
  final int index;

  const CheckInDetails({
    super.key,
    required this.time,
    required this.session,
    required this.totalTopCount,
    required this.imageUrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                index == 0 ? 'Check In Time' : 'Check Out Time',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              RichText(
                text: TextSpan(
                  text: totalTopCount.toString(),
                  style: const TextStyle(
                    color: Palette.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                  children: [
                    const TextSpan(
                      text: ' Total Leaves',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: '$time ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(
                      text: session,
                      style: const TextStyle(
                        color: Color(0xFF71727A),
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 90),
              Text(
                index == 0 ? 'Check In Image' : 'Check Out Image',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 181,
                width: 134,
                decoration: BoxDecoration(color: Color(0xFFd9d9d9)),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
