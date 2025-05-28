import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/core/utils/settings_screen.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.push(SettingsScreen.route),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Palette.secondary,
              ),
              child: const Icon(Icons.menu, size: 24),
            ),
          ),
          GestureDetector(
            onTap:
                () => context.push(
                  '${EmployeeDetailsScreen.route}?id=${user!.id}',
                ),
            child: const CircleAvatar(
              radius: 24,
              backgroundColor: Palette.secondary,
              child: Icon(Icons.person, color: Colors.black, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
