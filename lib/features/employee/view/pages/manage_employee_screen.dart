import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/employee/view/pages/create_employee_screen.dart';
import 'package:office/features/employee/view/widget/manage_employee_tile.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';

class ManageEmployeeScreen extends StatelessWidget {
  static const route = '/manage-emp';

  const ManageEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.push(CreateEmployeeScreen.route);
            },
            shape: CircleBorder(),
            backgroundColor: Palette.primaryColor,
            child: Icon(Icons.add, color: Colors.white),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          appBar: PreferredSize(
            preferredSize: Size(0, 60),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36),
                Text(
                  'Manage Employee',
                  style: Theme.of(context).textTheme.headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Modify details or add employees',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Palette.appGrey),
                ),
              ],
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee List',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:
                          (context, index) => ManageEmployeeTile(
                            name: 'Abdur Rahman',
                            email: 'asdf@gmail.com',
                            phone: '999-333-4444',
                            bloodGroup: 'B+',
                            role: 'Employee',
                          ),
                      separatorBuilder:
                          (context, index) => SizedBox(height: 8),
                      itemCount: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
