import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';

class SettingsScreen extends StatelessWidget {
  static const route = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rowTexts = ['Privacy Policy', 'Terms And Conditions', 'LogOut'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_rounded, size: 24),
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
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Palette.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Abdur Rahman',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'abdur@gmail.com',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 32),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => rowtile(rowTexts[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: rowTexts.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget rowtile(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 12),
        ],
      ),
    );
  }
}
