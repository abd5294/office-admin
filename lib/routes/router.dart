import 'package:go_router/go_router.dart';
import 'package:office/features/auth/view/auth_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_list_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_individual_screen.dart';
import 'package:office/features/employee/view/pages/create_employee_screen.dart';
import 'package:office/features/employee/view/pages/edit_employee_screen.dart';
import 'package:office/features/employee/view/pages/manage_employee_screen.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';
import 'package:office/features/employee/view/pages/employee_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: EditEmployeeScreen.route,
  routes: [
    GoRoute(path: AuthScreen.route, builder: (context, state) => AuthScreen()),
    GoRoute(path: HomeScreen.route, builder: (context, state) => HomeScreen()),
    GoRoute(
      path: CreateEmployeeScreen.route,
      builder: (context, state) => CreateEmployeeScreen(),
    ),
    GoRoute(
      path: EditEmployeeScreen.route,
      builder: (context, state) => EditEmployeeScreen(),
    ),
    GoRoute(
      path: ManageEmployeeScreen.route,
      builder: (context, state) => ManageEmployeeScreen(),
    ),
    GoRoute(
      path: CheckInIndividualScreen.route,
      builder: (context, state) => CheckInIndividualScreen(),
    ),
    GoRoute(
      path: CheckInListScreen.route,
      builder: (context, state) => CheckInListScreen(),
    ),
    GoRoute(
      path: EmployeeDetailsScreen.route,
      builder: (context, state) => EmployeeDetailsScreen(),
    ),
    GoRoute(
      path: EmployeeScreen.route,
      builder: (context, state) => EmployeeScreen(),
    ),
  ],
);
