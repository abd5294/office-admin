import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/checkin/view/pages/check_in_individual_screen.dart';

class CheckInCard extends ConsumerWidget {
  final int index;
  final String date;
  final int id;

  const CheckInCard({
    super.key,
    required this.index,
    required this.date,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 15,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ClipRRect(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    index.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Date',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
              ),
              Text(
                date,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(
                      '${CheckInIndividualScreen.route}?id=$id&date=$date',
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Palette.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
