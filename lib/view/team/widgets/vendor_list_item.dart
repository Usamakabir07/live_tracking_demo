import 'dart:async';

import 'package:flutter/material.dart';
import 'package:live_tracking_demo/view/team/widgets/vendor_tracking_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/colors.dart';
import '../../../viewModels/team_view_model.dart';

class VendorListItem extends StatelessWidget {
  const VendorListItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minVerticalPadding: 10,
          onTap: () {
            context
                .read<TeamViewModel>()
                .joinVehicleTrackingRoom(vehicleId: 'vehicle123');
            Navigator.pushNamed(context, VendorTrackingScreen.routeName);
          },
          leading: CircleAvatar(
            child: Image.network(
                "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png"),
          ),
          title: Text(
            "Vendor ${index + 1}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColors.titleColor,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  "This vendor is in transition",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColors.subtitleColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
          horizontalTitleGap: 10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        const Divider(
          thickness: 0.5,
          height: 2,
        ),
      ],
    );
  }
}
