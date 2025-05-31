import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:office/features/employee/controller/employee_controller.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/expandable_tile.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class EmployeeScreen extends ConsumerWidget {
  static const route = '/emp-screen';

  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empState = ref.watch(employeeControllerProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(employeeControllerProvider);
    });
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
                  empState.when(
                    data: (data) {
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder:
                              (context, index) => ExpandableTile(
                                employeeName: data[index].name,
                                index: index + 1,
                                id: data[index].id,
                              ),
                          separatorBuilder:
                              (context, index) => SizedBox(height: 8),
                          itemCount: data.length,
                        ),
                      );
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: SizedBox.shrink,
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
