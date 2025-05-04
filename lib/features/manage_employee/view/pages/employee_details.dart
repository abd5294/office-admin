import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/shared/widgets/custom_app_bar.dart';
import 'package:office/shared/widgets/custom_bottom_sheet.dart';
import 'package:office/shared/widgets/custom_card.dart';

class EmployeeDetails extends StatelessWidget {
  static const route = '/emp-details';

  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(0, 60),
            child: CustomAppBar(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36),
                Text(
                  'Abdur Rahman',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Employee Details',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Palette.appGrey),
                ),
              ],
            ),
          ),
          bottomSheet: CustomBottomSheet(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: StaggeredGrid.extent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: [
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 2,
                          mainAxisExtent: 140,
                          child:
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 140,
                          child: CustomCard(
                            title: 'Employee Page',
                            subTitle: 'View your employees',
                          ),
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 140,
                          child: CustomCard(
                            title: 'Employee Page',
                            subTitle: 'View your employees',
                          ),
                        ),
                        StaggeredGridTile.extent(
                          crossAxisCellCount: 1,
                          mainAxisExtent: 140,
                          child: CustomCard(
                            title: 'Employee Page',
                            subTitle: 'View your employees',
                          ),
                        ),
                      ],
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
