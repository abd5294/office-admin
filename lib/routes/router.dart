import 'package:go_router/go_router.dart';
import 'package:office/features/auth/view/login_screen.dart';
import 'package:office/features/auth/view/confirm_password_screen.dart';
import 'package:office/features/auth/view/fotget_password.dart';
import 'package:office/features/auth/view/otp_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_list_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_individual_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_out_screen.dart';
import 'package:office/features/employee/view/pages/create_employee_screen.dart';
import 'package:office/features/employee/view/pages/edit_employee_screen.dart';
import 'package:office/features/employee/view/pages/manage_employee_screen.dart';
import 'package:office/features/festival/view/pages/create_festival_screen.dart';
import 'package:office/features/festival/view/pages/festival_leaves_screen.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';
import 'package:office/features/employee/view/pages/employee_screen.dart';
import 'package:office/features/leaves/view/pages/create_leave_screen.dart';
import 'package:office/features/leaves/view/pages/edit_leave_screen.dart';
import 'package:office/features/leaves/view/pages/leave_application_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: LoginScreen.route,
  routes: [
    GoRoute(
      path: LoginScreen.route,
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(path: HomeScreen.route, builder: (context, state) => HomeScreen()),
    GoRoute(
      path: ForgotPasswordScreen.route,
      builder: (context, state) => ForgotPasswordScreen(),
    ),

    GoRoute(path: OtpScreen.route, builder: (context, state) => OtpScreen()),
    GoRoute(
      path: ConfirmPasswordScreen.route,
      builder: (context, state) => ConfirmPasswordScreen(),
    ),

    GoRoute(
      path: ManageEmployeeScreen.route,
      builder: (context, state) => ManageEmployeeScreen(),
    ),

    GoRoute(
      path: '/edit-emp',
      name: 'edit-emp',
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];
        final name = state.uri.queryParameters['name'] ?? '';
        final email = state.uri.queryParameters['email'] ?? '';
        final phone = state.uri.queryParameters['phone'] ?? '';
        final bloodGroup = state.uri.queryParameters['bloodGroup'] ?? '';
        final designation = state.uri.queryParameters['designation'] ?? '';
        final address = state.uri.queryParameters['address'] ?? '';
        final gender = state.uri.queryParameters['gender'] ?? '';
        final dob = state.uri.queryParameters['dob'] ?? '';
        final emergencyContacts = state.uri.queryParameters['emergencyContacts'] ?? '';

        return EditEmployeeScreen(
          id: int.parse(id!),
          name: name,
          email: email,
          phone: phone,
          bloodGroup: bloodGroup,
          designation: designation,
          address: address,
          gender: gender,
          dob: dob,
          emergencyContacts: emergencyContacts,
        );
      },
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
      path: EmployeeDetailsScreen.route,
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];
        return EmployeeDetailsScreen(id: int.parse(id!));
      },
    ),

    GoRoute(
      path: CheckInListScreen.route,
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];
        final name = state.uri.queryParameters['name'];
        return CheckInListScreen(id: int.parse(id!), name: name!,);
      },
    ),
    GoRoute(
      path: CheckInIndividualScreen.route,
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];
        return CheckInIndividualScreen(id: int.parse(id!));
      },
    ),

    GoRoute(
      path: LeaveApplicationScreen.route,
      builder: (context, state) => LeaveApplicationScreen(),
    ),

    GoRoute(
      path: CreateLeaveScreen.route,
      builder: (context, state) => CreateLeaveScreen(),
    ),

    GoRoute(
      path: EditLeaveScreen.route,
      builder: (context, state) => EditLeaveScreen(),
    ),

    GoRoute(
      path: CreateEmployeeScreen.route,
      builder: (context, state) => CreateEmployeeScreen(),
    ),

    GoRoute(
      path: CreateFestivalScreen.route,
      builder: (context, state) => CreateFestivalScreen(),
    ),

    GoRoute(
      path: CheckInOutScreen.route,
      builder: (context, state) => CheckInOutScreen(),
    ),
  ],
);
