import 'package:go_router/go_router.dart';
import 'package:office/core/utils/settings_screen.dart';
import 'package:office/features/auth/view/login_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_screen.dart';
import 'package:office/features/checkin/view/pages/checkin_error_screen.dart';
import 'package:office/features/employee/view/pages/update_profile_screen.dart';
import 'package:office/features/update_password/view/confirm_password_screen.dart';
import 'package:office/features/update_password/view/forget_password_screen.dart';
import 'package:office/features/update_password/view/otp_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_list_screen.dart';
import 'package:office/features/checkin/view/pages/check_in_individual_screen.dart';
import 'package:office/features/checkin/view/pages/check_out_screen.dart';
import 'package:office/features/employee/view/pages/create_employee_screen.dart';
import 'package:office/features/employee/view/pages/edit_employee_screen.dart';
import 'package:office/features/employee/view/pages/manage_employee_screen.dart';
import 'package:office/features/festival/model/festival_leave_model.dart';
import 'package:office/features/festival/view/pages/create_festival_screen.dart';
import 'package:office/features/festival/view/pages/edit_festival_screen.dart';
import 'package:office/features/festival/view/pages/festival_leaves_screen.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/features/employee/view/pages/employee_details_screen.dart';
import 'package:office/features/employee/view/pages/employee_screen.dart';
import 'package:office/features/leaves/view/pages/create_leave_screen.dart';
import 'package:office/features/leaves/view/pages/leave_application_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: LoginScreen.route,
  routes: [
    GoRoute(
      path: LoginScreen.route,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: SettingsScreen.route,
      builder: (context, state) => SettingsScreen(),
    ),

    GoRoute(path: HomeScreen.route, builder: (context, state) => HomeScreen()),
    GoRoute(
      path: ForgotPasswordScreen.route,
      builder: (context, state) => ForgotPasswordScreen(),
    ),

    GoRoute(
      path: OtpScreen.route,
      builder: (context, state) {
        final email = state.uri.queryParameters['email']!;
        return OtpScreen(email: email);
      },
    ),
    GoRoute(
      path: ConfirmPasswordScreen.route,
      builder: (context, state) {
        final otpStr = state.uri.queryParameters['otp'];
        final email = state.uri.queryParameters['email']!;
        final otp = int.parse(otpStr!);
        return ConfirmPasswordScreen(otp: otp, email: email);
      },
    ),

    GoRoute(
      path: ManageEmployeeScreen.route,
      builder: (context, state) => ManageEmployeeScreen(),
    ),

    GoRoute(
      path: EditEmployeeScreen.route,
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
        final emergencyContacts =
            state.uri.queryParameters['emergencyContacts'] ?? '';
        final department = state.uri.queryParameters['department'] ?? '';
        final dateOfJoining = state.uri.queryParameters['dateOfJoining'] ?? '';

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
          department: department,
          dateOfJoining: dateOfJoining,
        );
      },
    ),

    GoRoute(
      path: UpdateProfileScreen.route,
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
        final emergencyContacts =
            state.uri.queryParameters['emergencyContacts'] ?? '';

        return UpdateProfileScreen(
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
      path: EditFestivalScreen.route,
      name: 'editFestival',
      builder: (context, state) {
        final festival = state.extra as FestivalLeaveModel;
        return EditFestivalScreen(festival: festival);
      },
    ),

    GoRoute(
      path: FestivalLeavesScreen.route,
      builder: (context, state) => FestivalLeavesScreen(),
    ),

    GoRoute(
      path: EmployeeScreen.route,
      builder: (context, state) {
        return EmployeeScreen();
      },
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
        return CheckInListScreen(id: int.parse(id!), name: name!);
      },
    ),
    GoRoute(
      path: CheckInIndividualScreen.route,
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];
        final date = state.uri.queryParameters['date'];
        return CheckInIndividualScreen(id: int.parse(id!), date: date!);
      },
    ),

    GoRoute(
      path: CheckinErrorScreen.route,
      builder: (context, state) {
        final error = state.uri.queryParameters['error'];
        return CheckinErrorScreen(errorString: error.toString());
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
      path: CreateEmployeeScreen.route,
      builder: (context, state) => CreateEmployeeScreen(),
    ),

    GoRoute(
      path: CreateFestivalScreen.route,
      builder: (context, state) => CreateFestivalScreen(),
    ),

    GoRoute(
      path: CheckInScreen.route,
      builder: (context, state) => CheckInScreen(),
    ),
    GoRoute(
      path: CheckOutScreen.route,
      builder: (context, state) => CheckOutScreen(),
    ),
  ],
);
