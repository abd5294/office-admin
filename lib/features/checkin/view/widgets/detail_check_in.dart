import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class DetailCheckIn extends StatelessWidget {
  final String time;
  final int totalTopCount;
  final int totalBottomCount;
  final String session;

  const DetailCheckIn({
    super.key,
    required this.time,
    required this.session,
    required this.totalBottomCount,
    required this.totalTopCount,
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
              const Text(
                'Check In Time',
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
              SizedBox(height: 84),
              const Text(
                'Checkout Image',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              RichText(
                text: TextSpan(
                  text: totalBottomCount.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Palette.primaryColor,
                    fontWeight: FontWeight.w700,
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
                child: Image.network(
                  'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?semt=ais_hybrid&w=740',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
