import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_svg/svg.dart';

class AppbarWidgets extends StatefulWidget implements PreferredSizeWidget {
  const AppbarWidgets({super.key});

  @override
  State<AppbarWidgets> createState() => _AppbarWidgetsState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}

class _AppbarWidgetsState extends State<AppbarWidgets> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.all(5),
      toolbarHeight: 60,
      title: SvgPicture.asset(AppAssetsPath.appbarLogo, width: 130),
      actions: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.grey,
          ),
          onPressed: () {},
          icon: Icon(Icons.person_2_outlined),
        ),

        IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            backgroundColor: Colors.grey.shade200,
          ),
          onPressed: () {},
          icon: Icon(Icons.call_outlined),
        ),
        IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            backgroundColor: Colors.grey.shade200,
          ),
          onPressed: () {},
          icon: Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }
}
