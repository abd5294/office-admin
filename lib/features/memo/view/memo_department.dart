/*
  The following widget structure follows the design of ManageEmployeeScreen:
  - Uses CustomAppBar, MainTextColumn, and CustomBottomSheet.
  - The department list is shown inside the bottom sheet.
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/festival/view/pages/create_festival_screen.dart';
import 'package:office/features/memo/controller/department_controller.dart';
import 'package:office/features/memo/view/create_department_screen.dart';
import 'package:office/features/memo/view/create_memo_screen.dart';
import 'package:office/features/memo/widgets/manage_department_tile.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class MemoDepartmentsScreen extends ConsumerWidget {
  static const route = '/memo-departments';

  const MemoDepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departmentState = ref.watch(departmentControllerProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: 'addDepartmentFAB',
                    onPressed: () {
                      context.push(CreateDepartmentScreen.route);
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Palette.primaryColor,
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: 'addNotifications',
                    onPressed: () {
                      context.push(CreateMemoScreen.route);
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Palette.primaryColor,
                    child: const Icon(
                      Icons.notification_add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          appBar: const PreferredSize(
            preferredSize: Size(0, 74),
            child: CustomAppBar(),
          ),
          body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: MainTextColumn(
              title: 'Departments',
              subTitle: 'View all memo departments',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Department List',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: departmentState.when(
                      data:
                          (departments) => ListView.separated(
                            itemCount: departments.length,
                            itemBuilder: (context, index) {
                              final department = departments[index];
                              return ManageDepartmentTile(
                                count: index + 1,
                                department: department,
                                onDelete: () {
                                  ref
                                      .read(
                                        departmentControllerProvider.notifier,
                                      )
                                      .deleteDepartment(department.id);
                                },
                              );
                            },
                            separatorBuilder:
                                (context, index) => const SizedBox(height: 8),
                          ),
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (error, _) => Center(
                            child: Text(
                              error.toString(),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
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
