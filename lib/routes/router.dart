import 'package:go_router/go_router.dart';
import 'package:office/features/auth/view/auth_screen.dart';
import 'package:office/features/home/view/pages/home_screen.dart';
import 'package:office/features/manage_employee/view/pages/manage_employee.dart';

final GoRouter router = GoRouter(
  initialLocation: ManageEmployee.route,
  routes: [
    GoRoute(path: AuthScreen.route, builder: (context, state) => AuthScreen()),
    GoRoute(path: HomeScreen.route, builder: (context, state) => HomeScreen()),
    GoRoute(
      path: ManageEmployee.route,
      builder: (context, state) => ManageEmployee(),
    ),
  ],
);
