import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/providers/user_provider.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/auth/view/login_screen.dart';
import 'package:office/features/employee/view/pages/edit_employee_screen.dart';

class SettingsScreen extends ConsumerWidget {
  static const route = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider)!;
    final rowTexts = ['Privacy Policy', 'Terms And Conditions', 'Logout'];
    final encodedBloodGroup = Uri.encodeComponent(user.bloodGroup);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_rounded, size: 24),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),

      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffeaf2ff),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Icon(Icons.person, color: Color(0xFFb4dbff), size: 80),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        context.push(
                          '${EditEmployeeScreen.route}'
                          '?id=${user.id}'
                          '&name=${user.name}'
                          '&email=${user.email}'
                          '&phone=${user.phone}'
                          '&bloodGroup=$encodedBloodGroup'
                          '&role=${user.role}'
                          '&designation=${user.designation}'
                          '&address=${user.address}'
                          '&gender=${user.gender}'
                          '&dob=${user.dob}'
                          '&emergencyContacts=${user.emergencyContacts}',
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Palette.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              user.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              user.email,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 32),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder:
                  (context, index) =>
                      rowtile(index, rowTexts[index], context, ref),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: rowTexts.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget rowtile(int index, String title, BuildContext context, WidgetRef ref) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black,
            size: 12,
          ),
        ],
      ),
    );

    if (index == 2) {
      return GestureDetector(
        onTap: () {
          ref.read(userProvider.notifier).state = null;
          context.go(LoginScreen.route);
        },
        child: row,
      );
    }

    return row;
  }
}
