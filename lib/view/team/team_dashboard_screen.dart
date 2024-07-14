import 'dart:async';

import 'package:flutter/material.dart';
import 'package:live_tracking_demo/view/team/widgets/vendor_list_item.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../../viewModels/team_view_model.dart';

class TeamDashboardScreen extends StatefulWidget {
  static const routeName = '/team-dashboard-screen';
  const TeamDashboardScreen({super.key});

  @override
  State<TeamDashboardScreen> createState() => _TeamDashboardScreenState();
}

class _TeamDashboardScreenState extends State<TeamDashboardScreen> {
  @override
  void initState() {
    context.read<TeamViewModel>().establishWebSocketConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu_rounded,
          color: MyColors.titleColor,
        ),
        title: Text(
          "Vendors",
          style: TextStyle(
            fontSize: 18,
            color: MyColors.titleColor,
          ),
        ),
        actions: [
          Icon(
            Icons.search_rounded,
            color: MyColors.titleColor,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Consumer<TeamViewModel>(
        builder: (context, viewModel, _) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: 3,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return VendorListItem(index: index);
              },
            ),
          );
        },
      ),
    );
  }
}
