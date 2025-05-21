import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/features/employee/controller/manage_employee_controller.dart';
import 'package:office/features/employee/view/pages/create_employee_screen.dart';
import 'package:office/features/employee/view/widget/manage_employee_tile.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/main_text_column.dart';

class ManageEmployeeScreen extends ConsumerWidget {
  static const route = '/manage-emp';

  const ManageEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empState = ref.watch(manageEmployeeControllerProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(vertical: 23.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  context.push(CreateEmployeeScreen.route);
                },
                shape: CircleBorder(),
                backgroundColor: Palette.primaryColor,
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          appBar: PreferredSize(
            preferredSize: Size(0, 74),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainTextColumn(
              title: 'Manage Employees',
              subTitle: 'Modify details or add employees',
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Employee List',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: empState.when(
                      data:
                          (data) => ListView.separated(
                            itemBuilder:
                                (context, index) => ManageEmployeeTile(
                                  id : data[index].id,
                                  name: data[index].name,
                                  email: data[index].email,
                                  phone: data[index].phone,
                                  bloodGroup: data[index].bloodType,
                                  role: data[index].role,
                                ),
                            separatorBuilder:
                                (context, index) => const SizedBox(height: 8),
                            itemCount: data.length,
                          ),
                      error: (error, stackTrace) {
                        return Center(child: Text('An error occurred'));
                      },
                      loading: () => Center(child: CircularProgressIndicator()),
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
