import 'package:flutter/material.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/employee/controller/employee_screen_controller.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/expandable_tile.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class EmployeeScreen extends StatelessWidget {
  static const route = '/emp-screen';

  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EmployeeModelController employeeModel = EmployeeModelController();
    List employees = employeeModel.getEmployees();

    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(0, 74),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainTextColumn(
              title: 'Your Employees',
              subTitle: 'View your employees',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'List of Employees',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:
                          (context, index) => ExpandableTile(
                            employeeName: employees[index].name,
                            index: index + 1,
                            attendance: employees[index].attendance,
                          ),
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: employees.length,
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
