import 'package:go_router/go_router.dart';
import 'package:office/features/auth/view/auth_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_list_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_individual_screen.dart';
import 'package:office/features/employee/view/pages/create_employee_screen.dart';
import 'package:office/features/employee/view/pages/edit_employee_screen.dart';
import 'package:office/features/employee/view/pages/manage_employee_screen.dart';
import 'package:office/features/festival/view/pages/create_festival_screen.dart';
import 'package:office/features/festival/view/pages/festival_leaves_screen.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';
import 'package:office/features/employee/view/pages/employee_screen.dart';
import 'package:office/features/leaves/view/pages/leave_application_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: HomeScreen.route,
  routes: [
    GoRoute(path: AuthScreen.route, builder: (context, state) => AuthScreen()),
    GoRoute(path: HomeScreen.route, builder: (context, state) => HomeScreen()),

    GoRoute(
      path: ManageEmployeeScreen.route,
      builder: (context, state) => ManageEmployeeScreen(),
    ),
    GoRoute(
      path: FestivalLeavesScreen.route,
      builder: (context, state) => FestivalLeavesScreen(),
    ),

    GoRoute(
      path: EmployeeScreen.route,
      builder: (context, state) => EmployeeScreen(),
    ),

    GoRoute(
      path: LeaveApplicationScreen.route,
      builder: (context, state) => LeaveApplicationScreen(),
    ),

    GoRoute(
      path: CreateEmployeeScreen.route,
      builder: (context, state) => CreateEmployeeScreen(),
    ),
    GoRoute(
      path: EditEmployeeScreen.route,
      builder: (context, state) => EditEmployeeScreen(),
    ),

    GoRoute(
      path: CreateFestivalScreen.route,
      builder: (context, state) => CreateFestivalScreen(),
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
  ],
);
