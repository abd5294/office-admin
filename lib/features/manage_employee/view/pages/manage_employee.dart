import 'package:flutter/material.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';

class ManageEmployee extends StatelessWidget {
  static const route = '/manage-emp';

  const ManageEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(0, 60),
            child: CustomAppBar(),
          ),
        ),
      ),
    );
  }
}
